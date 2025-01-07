import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/controllers/login_controller.dart';
import 'package:probashi/pages/login.dart';
import '/models/user.dart';
import '/pages/dashboard.dart';
import '/base/utils/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  bool test = false;
  // List<User> user = [];
  Future findUser(String userId, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      String query = "select * from vwusers where UserId='$userId'";

      var url = Uri.parse(probashiGetApi + query);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        try {
          List<User> user = [];
          var jsonData = json.decode(response.body);
          for (var ob in jsonData) {
            user.add(User.fromJson(ob));
          }
          if (user.length > 0) {
            print(user.toList());
            if (user[0].roleName == "SALES REPRESENTATIVE") {
              getUser(userId, password);
            } else {
              Get.defaultDialog(
                  title: "SORRY",
                  titleStyle: TextStyle(
                    fontSize: 40,
                  ),
                  content: Text(
                    "You do not have required permissions!!!  ${user.first.roleName}",
                    style: TextStyle(color: Colors.red),
                  ),
                  textConfirm: "TRY AGAIN",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    // user.clear();
                    Get.offAll(LoginPage());
                  },
                  buttonColor: Color.fromARGB(255, 255, 172, 71));
            }
          } else {
            Get.defaultDialog(
                title: "SORRY",
                titleStyle: TextStyle(fontSize: 40, color: Colors.red),
                content: Text(
                  "Username Not Found!!!",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                textConfirm: "TRY AGAIN",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.offAll(LoginPage());
                },
                buttonColor: Color.fromARGB(255, 255, 172, 71));
          }
        } catch (Exception) {
          Get.offAll(LoginPage());
          Get.find<LoginController>().quaritine(response.body.toString());
        }
      } else {
        Get.defaultDialog(
            title: "SORRY",
            titleStyle: TextStyle(
              fontSize: 40,
            ),
            content: Text(
              "Internal error!!!",
              style: TextStyle(color: Colors.red),
            ),
            textConfirm: "TRY AGAIN",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.offAll(LoginPage());
            },
            buttonColor: Color.fromARGB(255, 255, 172, 71));
      }
    } else {
      Get.defaultDialog(
          title: "Sorry",
          titleStyle: TextStyle(
            fontSize: 40,
          ),
          content: Text(
            "You are not connected to internet!!!",
            style: TextStyle(color: Colors.red),
          ),
          textConfirm: "TRY AGAIN",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginPage());
          },
          buttonColor: Color.fromARGB(255, 255, 172, 71));
    }
  }

  getUser(String userId, String password) async {
    List<User> user = [];
    String query =
        "select * from vwusers where UserId='$userId 'AND Password='$password'";
    var url = Uri.parse(probashiGetApi + query);

    var response = await http.get(url);
    try {
      var jsonData = json.decode(response.body);
      for (var ob in jsonData) {
        user.add(User.fromJson(ob));
      }
    } catch (exception) {
      Get.find<LoginController>().quaritine(response.body.toString());
    }

    if (user.length > 0) {
      saveUser(user[0]);
    } else {
      Get.defaultDialog(
          title: "SORRY",
          titleStyle: TextStyle(
            fontSize: 40,
          ),
          content: Text(
            "Incorrect Password!!!",
            style: TextStyle(color: Colors.red),
          ),
          textConfirm: "TRY AGAIN",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginPage());
          },
          buttonColor: Color.fromARGB(255, 255, 172, 71));
    }
  }

  void saveUser(User user) {
    getStoreNameById(user.storeID!).then(
      (value) {
        user.storeName = value;
        final box = GetStorage();
        box.write('loginUser', user.toMap());
        box.write('isLoggedIn', true);
        Get.offAll(() => DashboardPage());
      },
    );
  }

  Future<String> getStoreNameById(int id) async {
    String query = "select Name from Store where StoreAssignID=$id";

    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        var jsonData = json.decode(response.body);
        return jsonData[0]['Name'];
      } catch (Exception) {
        Get.offAll(LoginPage());
        Get.find<LoginController>().quaritine(response.body.toString());
      }
    }
    return '';
  }
}
