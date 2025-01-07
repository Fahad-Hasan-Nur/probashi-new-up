import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '/base/utils/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/store.dart';

class StoreService {
  Future<List<Store>> getStoreByAdmin(String userId) async {
    List<Store> stores = [];
    String query = 'select * from party where userID=$userId';
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var ob in jsonData) {
          stores.add(Store.fromJson(ob));
        }
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
    return stores;
  }

  Future getStoreBySr(int employeeId, int locationId) async {
    int id = await getStoreID(employeeId, locationId);

    return await getStore(id);
  }

  Future getStoreID(int employeeId, int locationId) async {
    List<Store> stores = [];
    String query =
        'SELECT DISTINCT Store.StoreAssignID, Store.Name FROM Store INNER JOIN StoreAssign ON Store.StoreAssignID = StoreAssign.StoreID WHERE (StoreAssign.EmployeeID = $employeeId) AND (StoreAssign.LocationID=$locationId)';
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var ob = jsonData[0];
        return ob['StoreAssignID'];
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
  }

  Future<Store> getStore(int id) async {
    List<Store> stores = [];
    String query = 'select * from store where storeAssignID=$id';
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var ob in jsonData) {
        stores.add(Store.fromJson(ob));
      }
    }
    return stores[0];
  }
}
