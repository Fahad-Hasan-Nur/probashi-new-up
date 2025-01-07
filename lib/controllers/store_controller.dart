import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '/models/party.dart';
import '/models/store.dart';
import '../../../../../base/constants/constant_strings.dart';
import '../../../../../base/constants/table_names.dart';
import '../../../../../base/utils/db_helper.dart';
import '../services/store_service.dart';

class StoreController extends GetxController {
  List<Store> stores = <Store>[].obs;
  var selectedStore = Store().obs;
  var staticStore = Store().obs;
  var isRetailStore = false.obs;
  final _service = Get.put(StoreService());

  getAdminStores(String userId) async {
    List<Store> data = await _service.getStoreByAdmin(userId);
    if (stores.isNotEmpty) {
      stores.clear();
      for (var item in data) {
        stores.add(item);
      }
    } else {
      for (var item in data) {
        stores.add(item);
      }
    }
  }

  selectParty(Party ob) {
    selectedStore = ob as Rx<Store>;
  }

  getSrStore(int employeeId, int locationId) async {
    if (await InternetConnectionChecker().hasConnection) {
      List<Map<String, dynamic>> data =
          await DatabaseHelper.instance.queryAll(TableNames.STORE_TABLE);
      if (data.length > 0) {
        Store ob = Store.fromJson(data[0]);
        await DatabaseHelper.instance.delete(
          ob.id!,
          TableNames.STORE_TABLE,
        );
      }
      staticStore.value = await _service.getStoreBySr(employeeId, locationId);
      saveToLocal(staticStore.value);
      isRetailStore.value = staticStore.value.isRetailStore as bool;
    } else {
      List<Map<String, dynamic>> data =
          await DatabaseHelper.instance.queryAll(TableNames.STORE_TABLE);
      staticStore.value = Store.fromJson(data[0]);
      if (staticStore.value.isRetailStore == false) {
        isRetailStore.value = false;
      } else {
        isRetailStore.value = true;
      }
    }
    return staticStore.value.storeID;
  }

  initiate() {
    Map<String, dynamic> user = GetStorage().read('loginUser');
    if (user['RoleName'] == sr) {
      return getSrStore(user['EmployeeID'], user['LocationID']);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    initiate();
  }

  Future<void> saveToLocal(Store ob) async {
    await DatabaseHelper.instance.insert(
      {
        StoreTableColumn.CENTER_ID: ob.centerID,
        StoreTableColumn.DEPARTMENT_SECTION_ID: ob.departmentSectionID,
        StoreTableColumn.DESCRIPTION: ob.description,
        StoreTableColumn.IS_RETAIL_STORE: ob.isRetailStore,
        StoreTableColumn.LOCATION_ID: ob.locationID,
        StoreTableColumn.NAME: ob.name,
        StoreTableColumn.OFFICE_ID: ob.officeID,
        StoreTableColumn.STORE_ASSIGN_ID: ob.storeAssignID,
        StoreTableColumn.STORE_ID: ob.storeID,
        StoreTableColumn.STORE_TYPE: ob.storeType,
      },
      TableNames.STORE_TABLE,
    );
  }
}
