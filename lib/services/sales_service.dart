import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../base/utils/api_list.dart';
import '../controllers/current_stock_controller.dart';
import '../controllers/login_controller.dart';
import '/base/constants/table_names.dart';
import '/controllers/sales_controller.dart';
import '/models/current_stock.dart';
import '/models/sale_details.dart';
import '/models/sales.dart';
import 'package:http/http.dart' as http;

import '/base/utils/db_helper.dart';

class SalesService {
  saveSales(Sales ob) async {
    DatabaseHelper.instance.insert(
      {
        SalesTableColumn.ACTIVE: ob.active,
        SalesTableColumn.AMOUNT_IN_WORDS: ob.amountInWords,
        SalesTableColumn.BAD_DEBT: ob.badDebt,
        SalesTableColumn.BRANCH_ID: ob.branchId,
        SalesTableColumn.COMPANY_ID: ob.companyID,
        SalesTableColumn.CREATED_BY: ob.createdBy,
        SalesTableColumn.CREATED_ON: ob.createdOn,
        SalesTableColumn.DELETED: ob.deleted,
        SalesTableColumn.DISCOUNT_AMOUNT: ob.discountAmount,
        SalesTableColumn.DISCOUNT_PERCENTAGE: ob.discountPercentage,
        SalesTableColumn.DOCUMENT_URL: ob.documentUrl,
        SalesTableColumn.DUE_AMOUNT: ob.dueAmount,
        SalesTableColumn.LAST_MODIFIED_ON: ob.lastModifiedOn,
        SalesTableColumn.LAST_MODIFIED_BY: ob.lastModifiedBy,
        SalesTableColumn.PAID_AMOUNT: ob.paidAmount,
        SalesTableColumn.PARTY_ID: ob.partyId,
        SalesTableColumn.PAYMENT_NOTE: ob.paymentNote,
        SalesTableColumn.PAY_STATUS: ob.payStatus,
        SalesTableColumn.SALES_DATE: ob.salesDate,
        SalesTableColumn.SALES_INVOICE: ob.salesInvoice,
        SalesTableColumn.SAVE_MODE: ob.saveMode,
        SalesTableColumn.SR_ID: ob.sRId,
        SalesTableColumn.SUBMIT_DATE: ob.submitDate,
        SalesTableColumn.TOTAL_EXCLUDING_VAT: ob.totalExcludingVAT,
        SalesTableColumn.TOTAL_INCLUDING_VAT: ob.totalIncludingVAT,
        SalesTableColumn.USE_PERCENTAGE: ob.usePercentage,
        SalesTableColumn.VAT_AMOUNT: ob.vATAmount,
        SalesTableColumn.VAT_STATUS: ob.vATStatus,
        SalesTableColumn.WAREHOUSE_ID: ob.warehouseId,
        SalesTableColumn.SR_INVOICE: ob.SRInvoice,
        SalesTableColumn.SYNC: ob.sync
      },
      TableNames.SALES_TABLE,
    );

    for (SaleDetails data in Get.find<SalesController>().salesDetails) {
      saveSaleDetails(data, ob.SRInvoice.toString())
          .then((value) =>
              Get.find<CurrentStockController>().getProductFromLOcal())
          .then((value) => Get.find<SalesController>().salesDetails.clear());
    }
  }

  saveSaleDetails(SaleDetails ob, String srInvoice) async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.getProductById(ob.productId.toString());

    VwCurrentStock product = VwCurrentStock.fromJson(data[0]);
    product.inQuantity = (product.inQuantity! - (ob.quantity as num));
    await DatabaseHelper.instance
        .productUpdate(product)
        .then((value) => Get.find<CurrentStockController>().getLocalData());

    DatabaseHelper.instance.insert(
      {
        SaleDetailsTableColumn.CALCULATE_ITEM_DISCOUNT:
            ob.calculateItemDiscount,
        SaleDetailsTableColumn.CATEGORY_ID: ob.categoryID,
        SaleDetailsTableColumn.CREATED_BY: ob.createdBy,
        SaleDetailsTableColumn.CREATED_ON: ob.createdOn,
        SaleDetailsTableColumn.DELETED: ob.deleted,
        SaleDetailsTableColumn.DISCOUNT_AMOUNT: ob.discountAmount,
        SaleDetailsTableColumn.ITEM_SUBTOTAL_EXCLUDING_VAT:
            ob.itemSubtotalExcludingVAT,
        SaleDetailsTableColumn.ITEM_SUBTOTAL_INCLUDING_VAT:
            ob.itemSubtotalIncludingVAT,
        SaleDetailsTableColumn.LAST_MODIFIED_BY: ob.lastModifiedBy,
        SaleDetailsTableColumn.LAST_MODIFIED_ON: ob.lastModifiedOn,
        SaleDetailsTableColumn.PARTY_ID: ob.partyId,
        SaleDetailsTableColumn.PRODUCT_ID: ob.productId,
        SaleDetailsTableColumn.PRODUCT_NAME: ob.productName,
        SaleDetailsTableColumn.QUANTITY: ob.quantity,
        SaleDetailsTableColumn.QUANTITY_IN_WORDS: ob.quantityInWords,
        SaleDetailsTableColumn.RETURN_QUANTITY: ob.returnQuantity,
        SaleDetailsTableColumn.SALES_DETAILS_ID: 1,
        SaleDetailsTableColumn.SALES_ID: 1,
        SaleDetailsTableColumn.SALES_INVOICE: ob.salesInvoice,
        SaleDetailsTableColumn.SUBCATEGORY_ID: ob.subCategoryID,
        SaleDetailsTableColumn.UNITS: ob.units,
        SaleDetailsTableColumn.UNIT_ID: ob.unitId,
        SaleDetailsTableColumn.UNIT_PRICE_INCLUDING_VAT:
            ob.unitPriceIncludingVAT,
        SaleDetailsTableColumn.UNIT_PRIC_EEXCLUDING_VAT:
            ob.unitPriceExcludingVAT,
        SaleDetailsTableColumn.VAT_AMOUNT: ob.vATAmount,
        SaleDetailsTableColumn.VAT_RATE: ob.vATRate,
        SaleDetailsTableColumn.VAT_STATUS: ob.vATStatus,
        SaleDetailsTableColumn.WAREHOUSE_ID: ob.warehouseId,
        SaleDetailsTableColumn.SR_INVOICE: srInvoice
      },
      TableNames.SALE_DETAILS_TABLE,
    );
    print("stock updated");
  }

  Future<List<Sales>> getSalesByUser(String userID) async {
    List<Sales> storeProducts = [];
    String query = "select TOP 5 * from sales where createdBy='$userID'";
    var url = Uri.parse(probashiGetApi + query);

    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var product in jsonData) {
          storeProducts.add(Sales.fromJson(product));
        }
      } else {
        print(response.statusCode);
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
    return storeProducts;
  }

  getWeeklySales() async {
    Map<String, dynamic> user = GetStorage().read('loginUser');
    int storeID = user['StoreID'];
    int locationId = user['LocationID'];
    int areaLocationID = user['AreaLocationID'];
    List<Map<String, dynamic>> data = [];
    String query =
        "SELECT SalesRepresentative, StoreID, LocationId, AreaLocationID, PreviousDaySales, PreviousDayCollection, Discount, TodayDues, UntilTodayBeforeDues, Balance FROM VWWeeklySummary WHERE StoreID=$storeID AND LocationId=$locationId AND AreaLocationID=$areaLocationID ";
    var url = Uri.parse(probashiGetApi + query);

    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var product in jsonData) {
          data.add(product);
        }
        Get.find<SalesController>().weeklyCollection.value =
            data[0]['PreviousDayCollection'];
        Get.find<SalesController>().weeklyDiscount.value = data[0]['Discount'];
        Get.find<SalesController>().weeklyDue.value = data[0]['TodayDues'];
        Get.find<SalesController>().weeklySale.value =
            data[0]['PreviousDaySales'];
        Get.find<SalesController>().untilTodayDue.value =
            data[0]['UntilTodayBeforeDues'];
      } else {
        print(response.statusCode);
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
  }

  Future<bool> isDeletedSale(Sales ob) async {
    List<Sales> sales = [];
    String query = "select * from sales where SalesId='${ob.salesId}'";
    var url = Uri.parse(probashiGetApi + query);

    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var data in jsonData) {
          sales.add(Sales.fromJson(data));
        }
      } else {
        print(response.statusCode);
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
    if (sales.length > 0) {
      return false;
    } else {
      return true;
    }
  }

  updateSale(Sales ob) async {
    await DatabaseHelper.instance.salesUpdate(ob);
  }
}
