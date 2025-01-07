import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/pages/dashboard.dart';
import '/pages/login.dart';

class ProBashi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Probashi Inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        fontFamily: 'Nunito',
      ),
      home: getFirstPage(),
    );
  }

  getFirstPage() {
    if (GetStorage().read("isLoggedIn") != null) {
      if (GetStorage().read("isLoggedIn")) {
        return DashboardPage();
      } else {
        return LoginPage();
      }
    } else {
      return LoginPage();
    }
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Container(
        height: 250,
        child: Image.asset('assets/splash-logo.png'),
      ),
    ),
  );
}
