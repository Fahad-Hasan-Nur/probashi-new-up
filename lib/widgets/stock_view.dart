import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/models/current_stock.dart';

import '../controllers/store_controller.dart';

class StockView extends StatefulWidget {
  final VwCurrentStock product;
  const StockView({Key? key, required this.product}) : super(key: key);

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  bool net = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: Color.fromARGB(255, 4, 2, 0),
              width: .9,
            ),
            color: Color.fromARGB(255, 255, 243, 213),
          ),
          child: SizedBox(
            height: 170,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Color.fromARGB(255, 255, 241, 202),
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset("assets/images/fruit.jpeg")
                    //Image.network(
                    //"https://img.freepik.com/free-vector/hand-drawn-mango-background_23-2148154804.jpg?w=1380&t=st=1650793447~exp=1650794047~hmac=cb9ddf3ec7cfcb029644ac3bbdce92141773398d05cf6ff4dba89c6a58134dbe"),
                    ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.productName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Get.find<StoreController>().isRetailStore.value
                          ? Text(
                              'Price: SAR ${widget.product.retailPrice}/ ${widget.product.retailUnit}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 148, 89, 0),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                          : (GetStorage().read('loginUser')['ShortCode'] ==
                                  'JED')
                              ? Text(
                                  'Price: SAR ${widget.product.jEDSalePrice}/ ${widget.product.baseUnit}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 148, 89, 0),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )
                              : Text(
                                  'Price: SAR ${widget.product.kHMSalePrice}/ ${widget.product.baseUnit}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 148, 89, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.left,
                                ),
                      (widget.product.inQuantity! > 0)
                          ? Text(
                              "Available: " +
                                  widget.product.inQuantity.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 116, 2),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                          : Text(
                              "Out of Stock",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
