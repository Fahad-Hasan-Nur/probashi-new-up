import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probashi/controllers/login_controller.dart';
import 'package:probashi/pages/dashboard/dashboard_sales.dart';
import 'package:probashi/widgets/sales_view_dashboard.dart';
import '/controllers/current_stock_controller.dart';
import '/controllers/data_sync_controller.dart';
import '/widgets/drawer.dart';
import '../controllers/party_controller.dart';
import '../controllers/sales_controller.dart';
import '../controllers/store_controller.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic> user = GetStorage().read('loginUser');
  final loginController = Get.put(LoginController());
  final storeController = Get.put(StoreController());
  final partyController = Get.put(PartyController());
  final currentStockController = Get.put(CurrentStockController());
  final salesController = Get.put(SalesController());
  final dataSyncController = Get.put(DataSyncController());
  final _createContactFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<CurrentStockController>().getData();
    Get.find<SalesController>().getLocalData();
    Get.find<DataSyncController>().logOut.value = false;
    Get.find<SalesController>().getWeeklySales();
    partyController.getParty("${user['EmployeeID']}");
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = GetStorage().read('loginUser');

    final listView = GetX<SalesController>(builder: (controller) {
      return (Get.find<SalesController>().salesList.isNotEmpty)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Get.find<SalesController>().salesList.length,
              itemBuilder: (context, index) {
                return SalesViewDashboard(
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
          child: Text('Dashboard'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 8, left: 5, bottom: 0, right: 5),
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      gradient: LinearGradient(colors: [
                        Colors.orange,
                        Color.fromARGB(255, 255, 221, 170),
                      ], begin: Alignment.topLeft, end: Alignment.topRight),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 10,
                          color: Color.fromARGB(255, 176, 148, 107),
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                Get.find<SalesController>()
                                    .untilTodayDue
                                    .value
                                    .toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 1, 0, 12),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Total Due ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    color: Color.fromARGB(223, 255, 136, 0),
                                  )
                                ]),
                            child: const Icon(
                              Icons.currency_exchange,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 255, 182, 105),
                        ], begin: Alignment.topLeft, end: Alignment.topRight),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: Color.fromARGB(255, 176, 148, 107),
                          )
                        ]),
                    child: Center(
                        child: Text(
                      "Todays Summery",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 15, left: 5, bottom: 15, right: 5),
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 255, 179, 65),
                            Color.fromARGB(255, 255, 255, 255),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 176, 148, 107),
                            )
                          ]),
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              () => Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      Get.find<SalesController>()
                                          .weeklySale
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 1, 0, 12),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "Sales Today",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          Get.to(() => DashboardSalesPage());
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 15, left: 5, bottom: 15, right: 5),
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 255, 179, 65),
                            Color.fromARGB(255, 255, 255, 255),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 176, 148, 107),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    Get.find<SalesController>()
                                        .weeklyCollection
                                        .value
                                        .toString(),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 1, 0, 12),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Collection Today",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 8, left: 5, bottom: 15, right: 5),
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 255, 179, 65),
                            Color.fromARGB(255, 255, 255, 255),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 176, 148, 107),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    Get.find<SalesController>()
                                        .weeklyDiscount
                                        .value
                                        .toString(),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 1, 0, 12),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                " Discount Today",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 8, left: 5, bottom: 15, right: 5),
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 255, 179, 65),
                            Color.fromARGB(255, 255, 255, 255),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(255, 176, 148, 107),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    Get.find<SalesController>()
                                        .weeklyDue
                                        .value
                                        .toString(),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 1, 0, 12),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Due Today",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 255, 182, 105),
                        ], begin: Alignment.topLeft, end: Alignment.topRight),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: Color.fromARGB(255, 176, 148, 107),
                          )
                        ]),
                    child: Center(
                        child: Text(
                      "Todays Sales",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  child: Form(key: _createContactFormKey, child: listView),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
