import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/services/auth_service.dart';

class LoginController extends GetxController {
  var storeName = ''.obs;
  AuthService auth = Get.put(AuthService());
  @override
  void onInit() {
    super.onInit();
  }

  authenticateUser(String userId, String password) async {
    await auth.findUser(userId, password);
  }

  quaritine(String data) {
    if (data.contains("Administrative Quarantine")) {
      return Get.snackbar(" IP Blocked", "Unblock your ip and try again.",
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black);
    }
  }
}
