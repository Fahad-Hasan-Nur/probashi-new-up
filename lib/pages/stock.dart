import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probashi/controllers/current_stock_controller.dart';
import 'package:probashi/controllers/sales_controller.dart';
import 'package:probashi/widgets/drawer.dart';
import 'package:probashi/widgets/sales_view.dart';

import '../widgets/stock_view.dart';

class StockPage extends StatefulWidget {
  @override
  State<StockPage> createState() => _StockPage();
}

class _StockPage extends State<StockPage> {
  var isSearching = false;
  final searchboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listView = GetX<CurrentStockController>(builder: (controller) {
      return (Get.find<CurrentStockController>().products.isNotEmpty)
          ? ListView.builder(
              itemCount:
                  Get.find<CurrentStockController>().filteredProducts.length,
              itemBuilder: (context, index) {
                return StockView(
                  product: Get.find<CurrentStockController>()
                      .filteredProducts[index],
                );
              },
            )
          : Center(child: Text("Nothing to Show."));
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: !isSearching
            ? const Text("Stock")
            : TextFormField(
                controller: searchboxController,
                autofocus: true,
                onChanged: (value) =>
                    Get.find<CurrentStockController>().runFilter(value),
                decoration: const InputDecoration(
                  hintText: 'Search Something',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 13),
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              if (isSearching) {
                Get.find<CurrentStockController>().runFilter("");
              }
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: isSearching
                ? const Icon(Icons.cancel)
                : const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(child: listView),
      ),
      drawer: MyDrawer(),
    );
  }
}
