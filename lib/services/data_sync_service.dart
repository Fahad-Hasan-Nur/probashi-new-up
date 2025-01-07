import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probashi/controllers/sales_controller.dart';
import '../controllers/store_controller.dart';
import '/controllers/data_sync_controller.dart';
import '/models/sales.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '/base/constants/table_names.dart';
import '/base/utils/api_list.dart';
import '/base/utils/db_helper.dart';
import '../models/response.dart';
import '../models/sale_details.dart';
import '../models/sales_request_model.dart';

class DataSyncService {
  bool check = true;
  Future<void> saveSales(List<Sales> sales) async {
    for (Sales ob in sales) {
      String salesInvoice = await makeInvoice(ob.vATStatus.toString());
      String queryMain =
          "INSERT INTO [Sales]([SRInvoice],[PartyId],[SalesDate],[SalesInvoice],[TotalExcludingVAT],[UsePercentage],[DiscountPercentage],[DiscountAmount],[VATStatus],[VATAmount],[TotalIncludingVAT],[AmountInWords],[PaidAmount],[BadDebt],[DueAmount],[PayStatus],[PaymentNote],[BranchId],[SRId],[WarehouseId],[Active],[Deleted],[SubmitDate],[SaveMode],[DocumentUrl],[CompanyID],[CreatedBy],[CreatedOn],[LastModifiedBy],[LastModifiedOn])VALUES('${ob.SRInvoice}','${ob.partyId}','${ob.salesDate}','${salesInvoice}','${ob.totalExcludingVAT}','${ob.usePercentage}','${ob.discountPercentage}','${ob.discountAmount}','${ob.vATStatus}','${ob.vATAmount}','${ob.totalIncludingVAT}','${ob.amountInWords}','${ob.paidAmount}','${ob.badDebt}','${ob.dueAmount}','${ob.payStatus}','${ob.paymentNote}','${ob.branchId}','${ob.sRId}','${ob.warehouseId}','${ob.active}','${ob.deleted}','${ob.submitDate}','${ob.saveMode}','${ob.documentUrl}','${ob.companyID}','${ob.createdBy}','${ob.createdOn}','${ob.lastModifiedBy}','${ob.lastModifiedOn}')";
      List<SalesRequestModel> main = [];
      SalesRequestModel data = SalesRequestModel();
      data.statement = queryMain;
      data.tableName = "Sales";
      data.operation = "INSERT";
      data.lastModifiedOn = "${DateTime.now().toString()}";
      data.uuId = 'SRInvoice=' "'${ob.SRInvoice}'" '';
      main.add(data);
      var url = Uri.parse(probashiPostApi);
      var body = json.encode(main);
      var response = await http.post(
        url,
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<ResponseData> allres = [];
        var jsonData = json.decode(response.body);
        for (var data in jsonData) {
          allres.add(ResponseData.fromJson(data));
        }
        if (allres.length > 0) {
          if (allres[0].sqlInfoMessage == "Successful") {
            await saveSaleDetails(allres[0].lastRowAffectedId.toString(),
                allres[0].uuId.toString(), salesInvoice);
          } else {
            Get.find<DataSyncController>().setFalse();
            errorDialog();
          }
        } else {
          Get.find<DataSyncController>().setFalse();
          errorDialog();
        }
      } else {
        Get.find<DataSyncController>().setFalse();
        errorDialog();
      }
    }
    if (check == false) {
      await updateData(sales);
      Get.find<DataSyncController>().SyncComplete();
    }
  }

  Future<List<SaleDetails>> saveSaleDetails(
      String salesID, String SRInvoice, String salesInvoice) async {
    List<SalesRequestModel> main = [];
    List<SaleDetails> details = [];
    List<Map<String, dynamic>> allSaleDetails = await DatabaseHelper.instance
        .getSaleDetailsBySales(
            TableNames.SALE_DETAILS_TABLE, SRInvoice.toString());
    for (var ob in allSaleDetails) {
      print(ob);
      details.add(SaleDetails.fromJson(ob));
    }

    for (SaleDetails ob in details) {
      String queryMain =
          "INSERT INTO  [SalesDetails]([SalesInvoice],[SRInvoice],[PartyId],[VATStatus],[WarehouseId],[SalesId],[CategoryID],[SubCategoryID],[ProductId],[UnitId],[Units],[UnitPriceIncludingVAT],[DiscountAmount],[VATRate],[VATAmount],[UnitPriceExcludingVAT],[Quantity],[QuantityInWords],[ItemSubtotalExcludingVAT],[ItemSubtotalIncludingVAT],[CalculateItemDiscount],[ReturnQuantity],[Deleted],[CreatedBy],[CreatedOn],[LastModifiedBy],[LastModifiedOn])VALUES('${salesInvoice}','${SRInvoice}','${ob.partyId}','${ob.vATStatus}','${ob.warehouseId}','${salesID}','${ob.categoryID}','${ob.subCategoryID}','${ob.productId}','${ob.unitId}','${ob.units}','${ob.unitPriceIncludingVAT}','${ob.discountAmount}','${ob.vATRate}','${ob.vATAmount}','${ob.unitPriceExcludingVAT}','${ob.quantity}','${ob.quantityInWords}','${ob.itemSubtotalExcludingVAT}','${ob.itemSubtotalIncludingVAT}','${ob.calculateItemDiscount}','${ob.returnQuantity}','${ob.deleted}','${ob.createdBy}','${ob.createdOn}','${ob.lastModifiedBy}','${ob.lastModifiedOn}')";
      print(queryMain);
      SalesRequestModel body = SalesRequestModel();
      body.statement = queryMain;
      body.tableName = "SalesDetails";
      body.operation = "INSERT";
      body.lastModifiedOn = DateTime.now().toString();
      body.uuId = 'SRInvoice=' "'${ob.SRInvoice}'" '';
      main.add(body);
    }

    var url = Uri.parse(probashiPostApi);
    var body = json.encode(main);
    var response = await http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<ResponseData> allres = [];
      var jsonData = json.decode(response.body);
      for (var data in jsonData) {
        allres.add(ResponseData.fromJson(data));
      }
      for (ResponseData ob in allres) {
        print(ob.sqlInfoMessage);
        if (ob.sqlInfoMessage == "Successful") {
          check = false;
        } else {
          check = true;
        }
      }
      if (check == true) {
        Get.find<DataSyncController>().setFalse();
        errorDialog();
      }
    } else {
      Get.find<DataSyncController>().setFalse();
      errorDialog();
    }
    return details;
  }

  updateData(List<Sales> sales) async {
    for (Sales ob in sales) {
      await updateSalesData(ob);
    }
    if (Get.find<DataSyncController>().logOut.value) {
      await DatabaseHelper.instance.truncate(TableNames.CURRENT_STOCK_TABLE);
    } else {
      Get.find<SalesController>().getLocalData();
    }
  }

  void errorDialog() {
    Get.find<DataSyncController>().setFalse();
    Get.defaultDialog(
        title: "OPPPPPSSSS!!!!",
        middleText: 'Failed to save data..Try again later',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
  }

  Future<String> makeInvoice(String isVat) async {
    String fYear = DateTime.now().toString().substring(2, 4);
    Map<String, dynamic> user = GetStorage().read('loginUser');
    int i = 0;
    String maxValue = "";
    String invoice = "";
    String srId = user['EmployeeID'].toString();
    if (Get.find<StoreController>().staticStore.value.locationID.toString() ==
        "null") {
      await Get.find<StoreController>().initiate().then((value) async {
        String locationId = value;
        String invDefinition = "";
        var vat = 'false';
        String invoiceDateRange = "WHERE SalesDate>='" +
            DateTime.now().toString().substring(0, 4) +
            "-01-01' AND SalesDate <'" +
            (int.parse(DateTime.now().toString().substring(0, 4)) + 1)
                .toString() +
            "-01-01'";
        if (isVat == "true") {
          invDefinition =
              await Get.find<SalesController>().getShortCode(locationId);
        } else {
          invDefinition =
              await Get.find<SalesController>().getShortCode(locationId) + "-V";
        }
        if (isVat == "true") {
          vat = 'true';
        }
        maxValue = await Get.find<SalesController>()
            .getMAxValue(invoiceDateRange, locationId, '$vat', srId);
        invoice = (invDefinition +
                // "-" +
                // srId +
                "-" +
                make4Digit((num.parse(maxValue) + 1).toString()) +
                "-" +
                fYear)
            .toString();

        var isExist = await Get.find<SalesController>()
            .findIsExists(invoiceDateRange, invoice, locationId);

        while (isExist == "Not Empty") {
          i++;
          maxValue = await Get.find<SalesController>()
              .getMAxValue(invoiceDateRange, locationId, '$vat', srId);
          invoice = (invDefinition +
                  "-" +
                  make4Digit((num.parse(maxValue) + 1 + i).toString()) +
                  "-" +
                  fYear)
              .toString();

          await Get.find<SalesController>()
              .findIsExists(invoiceDateRange, invoice, locationId)
              .then((value) => {isExist = value.toString()});
        }
      });
    } else {
      String locationId =
          Get.find<StoreController>().staticStore.value.locationID.toString();
      String invDefinition = "";
      var vat = 'false';
      String invoiceDateRange = "WHERE SalesDate>='" +
          DateTime.now().toString().substring(0, 4) +
          "-01-01' AND SalesDate <'" +
          (int.parse(DateTime.now().toString().substring(0, 4)) + 1)
              .toString() +
          "-01-01'";
      if (isVat == "true") {
        invDefinition =
            await Get.find<SalesController>().getShortCode(locationId);
      } else {
        invDefinition =
            await Get.find<SalesController>().getShortCode(locationId) + "-V";
      }
      if (isVat == "true") {
        vat = 'true';
      }
      maxValue = await Get.find<SalesController>()
          .getMAxValue(invoiceDateRange, locationId, '$vat', srId);
      invoice = (invDefinition +
              // "-" +
              // srId +
              "-" +
              make4Digit((num.parse(maxValue) + 1).toString()) +
              "-" +
              fYear)
          .toString();

      var isExist = await Get.find<SalesController>()
          .findIsExists(invoiceDateRange, invoice, locationId);

      while (isExist == "Not Empty") {
        i++;
        maxValue = await Get.find<SalesController>()
            .getMAxValue(invoiceDateRange, locationId, '$vat', srId);
        invoice = (invDefinition +
                "-" +
                make4Digit((num.parse(maxValue) + 1 + i).toString()) +
                "-" +
                fYear)
            .toString();

        await Get.find<SalesController>()
            .findIsExists(invoiceDateRange, invoice, locationId)
            .then((value) => {isExist = value.toString()});
      }
    }

    return invoice;
  }

  String make4Digit(String maxValue) {
    if (maxValue.length < 2) {
      maxValue = "000" + maxValue;
    } else if (maxValue.length < 3) {
      maxValue = "00" + maxValue;
    } else if (maxValue.length < 4) {
      maxValue = "0" + maxValue;
    }
    return maxValue;
  }

  updateSalesData(Sales ob) async {
    List<Sales> sales = [];
    String query = "select * from sales where SRInvoice='${ob.SRInvoice}'";
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var ob in jsonData) {
        sales.add(Sales.fromJson(ob));
      }
    }
    sales[0].sync = 'true';
    await DatabaseHelper.instance
        .deleteSale(sales[0].SRInvoice.toString(), TableNames.SALES_TABLE)
        .then((value) => DatabaseHelper.instance
            .insert(sales[0].toJson(), TableNames.SALES_TABLE));
  }
}
