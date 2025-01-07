import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/controllers/login_controller.dart';
import '/base/utils/db_helper.dart';
import '/base/constants/table_names.dart';
import '/base/utils/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/current_stock.dart';

class CurrentStockService {
  Future<List<VwCurrentStock>> getStockByStore(String storeId) async {
    List<VwCurrentStock> storeProducts = [];
    String query = 'select * from vwcurrentstock where StoreID=$storeId';
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var product in jsonData) {
          storeProducts.add(VwCurrentStock.fromJson(product));
        }
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }
    return storeProducts;
  }

  Future<List<String>> getSubCategoryByStore(String storeId) async {
    List<String> subCategories = [];
    if (await InternetConnectionChecker().hasConnection) {
      String query =
          'select distinct SubCategoryName  from vwcurrentstock where StoreID=$storeId';
      var url = Uri.parse(probashiGetApi + query);
      var response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);
          for (var item in jsonData) {
            subCategories
                .add(VwCurrentStock.fromJson(item).subCategoryName.toString());
          }
        }
      } catch (exception) {
        Get.find<LoginController>().quaritine(response.body.toString());
      }
      return subCategories;
    } else {
      List<Map<String, dynamic>> categories = await DatabaseHelper.instance
          .selectCategory(TableNames.CURRENT_STOCK_TABLE);
      for (var item in categories) {
        subCategories.add(item['SubCategoryName']);
      }
      return subCategories;
    }
  }

  Future<List<VwCurrentStock>> getProductBySubCategory(
      String subCategoryName, String storeId) async {
    List<VwCurrentStock> storeProducts = [];
    // if (await InternetConnectionChecker().hasConnection) {
    //   String query =
    //       "select *  from vwcurrentstock where StoreID='$storeId' and SubCategoryName='$subCategoryName'";
    //   var url = Uri.parse(probashiGetApi + query);

    //   var response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     var jsonData = json.decode(response.body);
    //     for (var product in jsonData) {
    //       storeProducts.add(VwCurrentStock.fromJson(product));
    //     }
    //   }
    //   return storeProducts;
    // } else {
    if (subCategoryName == "All") {
      List<Map<String, dynamic>> product = await DatabaseHelper.instance
          .queryAll(TableNames.CURRENT_STOCK_TABLE);
      for (var item in product) {
        storeProducts.add(VwCurrentStock.fromJson(item));
      }
    } else {
      List<Map<String, dynamic>> product = await DatabaseHelper.instance
          .getProductBySubCategory(
              TableNames.CURRENT_STOCK_TABLE, subCategoryName);
      for (var item in product) {
        storeProducts.add(VwCurrentStock.fromJson(item));
      }
    }

    return storeProducts;
    //}
  }
}
