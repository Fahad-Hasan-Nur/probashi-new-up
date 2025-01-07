import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/controllers/current_stock_controller.dart';
import 'package:probashi/controllers/sales_controller.dart';
import 'package:probashi/pages/dashboard.dart';
import '/models/sales.dart';
import '/services/data_sync_service.dart';
import '../../../../../base/constants/table_names.dart';
import '../../../../../base/utils/db_helper.dart';
import '../pages/login.dart';

class DataSyncController extends GetxController {
  var isLoading = true.obs;
  var checkLoading = true.obs;
  var logOut = false.obs;
  final _syncService = Get.put(DataSyncService());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setFalse() async {
    await Future.delayed(Duration(seconds: 1))
        .then((value) => isLoading.value = false)
        .then((value) {});
  }

  Future<void> SyncComplete() async {
    if (await InternetConnectionChecker().hasConnection) {
      Get.find<SalesController>().getWeeklySales();
    }
    if (logOut.value) {
      Get.find<SalesController>().salesList.clear();
      await Future.delayed(Duration(seconds: 1))
          .then((value) => isLoading.value = false)
          .then((value) {
        GetStorage().erase();
        GetStorage().remove('loginUser');
        DatabaseHelper.instance.truncate(TableNames.CURRENT_STOCK_TABLE);

        Get.offAll(() => LoginPage());
      });
    } else {
      DatabaseHelper.instance
          .truncate(TableNames.CURRENT_STOCK_TABLE)
          .then((value) => Get.find<CurrentStockController>().initData());
      //  DatabaseHelper.instance.truncate(TableNames.SALES_TABLE);
      //  Get.find<SalesController>().initData();
      Get.offAll(DashboardPage());
    }
  }

  Future syncData() async {
    List<Sales> sales = [];
    List<Map<String, dynamic>> allSales =
        await DatabaseHelper.instance.queryAllNonSynced();
    for (var ob in allSales) {
      sales.add(Sales.fromJson(ob));
    }
    if (allSales.length < 1) {
      Get.find<DataSyncController>().SyncComplete();
    } else {
      await _syncService.saveSales(sales);
    }
  }

  Future<bool> isEmptySales() async {
    List<Map<String, dynamic>> allSales =
        await DatabaseHelper.instance.queryAll(TableNames.SALES_TABLE);
    if (allSales.length > 0) {
      return false;
    } else {
      return true;
    }
  }
}
