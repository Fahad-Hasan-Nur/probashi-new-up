import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../pages/sales_history.dart';
import '../pages/stock.dart';
import '/controllers/data_sync_controller.dart';
import '/pages/add_product.dart';
import '/pages/dashboard.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final spinkit =
        SpinKitFadingCircle(itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color:
              index.isEven ? Color.fromARGB(255, 227, 149, 66) : Colors.green,
        ),
      );
    });
    Map<String, dynamic> user = GetStorage().read('loginUser');

    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 245, 224, 192),
        child: ListView(
          children: [
            // Column(
            //   children: [
            //     DrawerHeader(
            //       margin: EdgeInsets.zero,
            //       padding: EdgeInsets.zero,
            //       child: UserAccountsDrawerHeader(
            //         currentAccountPicture: CircleAvatar(
            //             backgroundImage: NetworkImage(
            //           "https://static.vecteezy.com/system/resources/previews/002/275/816/original/cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg",
            //         )),
            //         accountName: Text("${user['EmployeeName']} "),
            //         accountEmail: Text(user['LocationName']),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              color: Colors.orange,
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.face_retouching_natural_rounded,
                    size: MediaQuery.of(context).size.width / 3,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text("  ${user['EmployeeName']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 3, 38, 5))),
                  Text(
                    "  ${user['StoreName']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255, 7, 52, 10)),
                  ),
                  Text(
                    "  ${user['LocationName']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 7, 52, 10)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
              ),
              title: Text(
                "Dashboard",
                textScaleFactor: 1.5,
              ),
              onTap: () {
                Get.to(() => DashboardPage());
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.shopping_cart),
              title: Text(
                "Sales",
                textScaleFactor: 1.5,
              ),
              onTap: () {
                Get.to(() => AddProductPage());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.production_quantity_limits,
              ),
              title: Text(
                "My Stock",
                textScaleFactor: 1.5,
              ),
              onTap: () {
                Get.to(() => StockPage());
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.cloud_download,
              ),
              title: Text(
                "History",
                textScaleFactor: 1.5,
              ),
              onTap: () {
                Get.to(() => SalesHistoryPage());
              },
            ),
            ListTile(
              onTap: () async {
                if (await InternetConnectionChecker().hasConnection) {
                  Get.find<DataSyncController>().logOut.value = true;
                  Get.find<DataSyncController>().isLoading.value = true;
                  if (Get.find<DataSyncController>().isLoading.value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => spinkit,
                        fullscreenDialog: true,
                      ),
                    );
                  }
                  Get.find<DataSyncController>().syncData();
                } else {
                  if (await Get.find<DataSyncController>().isEmptySales()) {
                    Get.find<DataSyncController>().logOut.value = true;

                    Get.find<DataSyncController>().SyncComplete();
                  } else {
                    Get.defaultDialog(
                      title: "SORRY",
                      titleStyle: TextStyle(
                        fontSize: 40,
                      ),
                      content: Text(
                        "You are not Online!!!",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                }
              },
              leading: Icon(
                Icons.login,
              ),
              title: Text(
                "Log Out",
                textScaleFactor: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
