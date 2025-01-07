import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../../controllers/sales_controller.dart';
import '../../widgets/sales_view_dashboard.dart';
import '../../widgets/todays_sales_view_dashboard.dart';

class DashboardSalesPage extends StatefulWidget {
  @override
  State<DashboardSalesPage> createState() => _DashboardSalesPageState();
}

class _DashboardSalesPageState extends State<DashboardSalesPage> {
  final _createContactFormKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listView = GetX<SalesController>(builder: (controller) {
      return (Get.find<SalesController>().salesList.isNotEmpty)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Get.find<SalesController>().salesList.length,
              itemBuilder: (context, index) {
                return TodaysSalesViewDashboard(
                  sales: Get.find<SalesController>().salesList[index],
                );
              },
            )
          : Center(child: Text("Nothing to Show."));
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              'Today Sales',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 1, 0, 0),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 176, 148, 107),
                            )
                          ]),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "CUSTOMER",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.orange),
                        ),
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 0, 0, 0),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 218, 189, 125),
                            )
                          ]),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "SALE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.orange),
                        ),
                      ))),
                )
              ],
            ),
            Container(
              child: Form(key: _createContactFormKey, child: listView),
            ),
          ],
        ),
      ),
    );
  }
}
