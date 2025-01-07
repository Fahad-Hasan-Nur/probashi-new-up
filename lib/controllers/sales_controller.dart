import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/controllers/current_stock_controller.dart';
import '../base/constants/table_names.dart';
import '../base/utils/db_helper.dart';
import '/models/sales.dart';
import '/models/sale_details.dart';
import '/services/invoice_service.dart';
import '/services/sales_service.dart';

class SalesController extends GetxController {
  List<Sales> salesList = <Sales>[].obs;
  List<Sales> filteredSalesList = <Sales>[].obs;
  var salesDetails = <SaleDetails>[].obs;
  var paid = 0.0.obs;
  var debt = 0.0.obs;
  var totalIncVAT = 0.0.obs;
  var totalExcVAT = 0.0.obs;
  var totalVAT = 0.0.obs;
  var due = 0.0.obs;
  var invoice = ''.obs;
  var shortCode = ''.obs;
  var weeklySale = 0.0.obs;
  var weeklyCollection = 0.0.obs;
  var weeklyDue = 0.0.obs;
  var weeklyDiscount = 0.0.obs;
  var untilTodayDue = 0.0.obs;
  var sales = Sales().obs;
  var salesDate = "".obs;
  final _invoiceService = Get.put(InvoiceService());
  final _salesService = Get.put(SalesService());

  int getSalesDeatailByProductID(num id) {
    for (int i = 0; i < salesDetails.length; i++) {
      if (salesDetails[i].productId == id) {
        return i;
      }
    }
    return -1;
  }

  getShortCode(String id) async {
    shortCode.value = await _invoiceService.getShortCode(id);
    return _invoiceService.getShortCode(id);
  }

  getMAxValue(String a, String b, String c, String d) {
    return _invoiceService.getMaxValue(a, b, c, d);
  }

  Future findIsExists(
      String invoiceDateRange, String maxValue, String locationId) async {
    return await _invoiceService.findIsExists(
        invoiceDateRange, maxValue, locationId);
  }

  saveSale(Sales ob) async {
    salesList.add(ob);
    filteredSalesList.add(ob);
    return await _salesService.saveSales(ob);
  }

  updateSale(Sales ob) async {
    return await _salesService.updateSale(ob);
  }

  Future<List<Sales>> getSales(String userId) async {
    List<Sales> allSales = await _salesService.getSalesByUser(userId);
    if (salesList.isNotEmpty) {
      salesList.clear();
      for (var item in allSales) {
        salesList.add(item);
      }
    } else {
      for (var item in allSales) {
        salesList.add(item);
      }
    }

    if (filteredSalesList.isNotEmpty) {
      filteredSalesList.clear();
      filteredSalesList.addAll(salesList);
    } else {
      filteredSalesList.addAll(salesList);
    }
    return filteredSalesList;
  }

  @override
  void onInit() async {
    super.onInit();
    if (await InternetConnectionChecker().hasConnection) {
      getWeeklySales();
      refreshSalesData();
    }
    getLocalData();
  }

  void getLocalData() async {
    Map<String, dynamic> user = GetStorage().read('loginUser');

    List<Map<String, dynamic>> allSales =
        await DatabaseHelper.instance.queryAllSalesByUser(user['UserId']);

    if (salesList.isNotEmpty) {
      salesList.clear();
      for (var item in allSales) {
        salesList.add(Sales.fromJson(item));
      }
    } else {
      for (var item in allSales) {
        salesList.add(Sales.fromJson(item));
      }
    }

    if (filteredSalesList.isNotEmpty) {
      filteredSalesList.clear();
      filteredSalesList.addAll(salesList);
    } else {
      filteredSalesList.addAll(salesList);
    }
  }

  void runFilter(String keyword) {
    List<Sales> results = [];
    if (keyword.trim().isEmpty) {
      results = salesList;
    } else {
      print(salesList.toList());
      results = salesList
          .where((data) => data.salesDate!
              .toLowerCase()
              .contains(keyword.trim().toLowerCase()))
          .toList();
      print(results.toList());
    }

    if (filteredSalesList.isNotEmpty) {
      filteredSalesList.clear();
      filteredSalesList.addAll(results);
    } else {
      filteredSalesList.addAll(results);
    }
  }

  deleteSale(String? srInvoice) async {
    Get.find<CurrentStockController>().updateStock(srInvoice.toString()).then(
        (value) => DatabaseHelper.instance
            .deleteSale(srInvoice.toString(), TableNames.SALES_TABLE)
            .then((value) => DatabaseHelper.instance.deleteSaleDetails(
                srInvoice.toString(), TableNames.SALE_DETAILS_TABLE))
            .then((value) => getLocalData()));
  }

  deleteSaleOnly(String? srInvoice) async {
    Get.find<CurrentStockController>().updateStock(srInvoice.toString()).then(
        (value) => DatabaseHelper.instance
            .deleteSale(srInvoice.toString(), TableNames.SALES_TABLE)
            .then((value) => getLocalData()));
  }

  Future<List<SaleDetails>> getSalesDeatailBySales(String srInvoice) async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.getSalesDeatailBySales(srInvoice);
    List<SaleDetails> sales = [];
    for (var ob in data) {
      sales.add(SaleDetails.fromJson(ob));
    }
    return sales;
  }

  getWeeklySales() async {
    if (await InternetConnectionChecker().hasConnection) {
      _salesService.getWeeklySales();
    }
  }

  Future refreshSalesData() async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.queryAll(TableNames.SALES_TABLE);
    List<Sales> sales = [];
    for (var ob in data) {
      sales.add(Sales.fromJson(ob));
    }
    for (Sales ob in sales) {
      if (ob.salesInvoice != '') {
        if (await _salesService.isDeletedSale(ob)) {
          await DatabaseHelper.instance
              .deleteSale(ob.SRInvoice.toString(), TableNames.SALES_TABLE);
        }
      }
    }
    getLocalData();
  }

  getSalesById(String srInvoice) async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.getSalesById(srInvoice);
    List<Sales> sales = [];
    for (var ob in data) {
      sales.add(Sales.fromJson(ob));
    }
    return sales[0];
  }
}
