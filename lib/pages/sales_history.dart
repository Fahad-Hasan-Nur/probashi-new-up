import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:probashi/controllers/sales_controller.dart';
import 'package:probashi/widgets/drawer.dart';
import 'package:probashi/widgets/sales_view.dart';

class SalesHistoryPage extends StatefulWidget {
  @override
  State<SalesHistoryPage> createState() => _SalesHistoryPageState();
}

class _SalesHistoryPageState extends State<SalesHistoryPage> {
  var isSearching = false;
  final _createContactFormKey = GlobalKey<FormState>();

  final searchboxController = TextEditingController();

  @override
  initState() {
    super.initState();
    refreshHistory();
  }

  @override
  DateTime? dob = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController dateController = TextEditingController();

  Widget build(BuildContext context) {
    final listView = GetX<SalesController>(builder: (controller) {
      return (Get.find<SalesController>().salesList.isNotEmpty)
          ? ListView.builder(
              itemCount: Get.find<SalesController>().filteredSalesList.length,
              itemBuilder: (context, index) {
                return SalesView(
                  sales: Get.find<SalesController>().filteredSalesList[index],
                );
              },
            )
          : Center(child: Text("Nothing to Show."));
    });
    final dateField1 = Padding(
        padding: const EdgeInsets.all(8.0),
        child: DateTimeField(
          decoration: InputDecoration(
            labelText: 'Date',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          format: format,
          controller: dateController,
          onShowPicker: (context, currentValue) async {
            // dob = currentValue;
            await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
            ).then((value) {
              Get.find<SalesController>()
                  .runFilter(value.toString().substring(0, 10));
              dob = value;
            });

            return dob;
          },
        ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: !isSearching ? const Text("History") : dateField1,
        actions: [
          IconButton(
            onPressed: () {
              if (isSearching) {
                Get.find<SalesController>().runFilter("");
                searchboxController.text = "";
              }
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: isSearching
                ? const Icon(Icons.cancel)
                : const Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                refreshHistory();
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
        child: Form(key: _createContactFormKey, child: listView),
      ),
      drawer: MyDrawer(),
    );
  }

  void refreshHistory() async {
    if (await InternetConnectionChecker().hasConnection) {
      Get.find<SalesController>().refreshSalesData();
    }
  }
}
