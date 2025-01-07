import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:number_to_words/number_to_words.dart';
import '/controllers/current_stock_controller.dart';
import '/controllers/party_controller.dart';
import '/controllers/sales_controller.dart';
import '/models/current_stock.dart';
import '/models/sale_details.dart';
import '/pages/customer_transaction.dart';
import 'package:probashi/base/constants/constant_colors.dart' as myColor;

import '/controllers/store_controller.dart';

class ProductInformationPage extends StatefulWidget {
  const ProductInformationPage({Key? key}) : super(key: key);

  @override
  _ProductInformationPage createState() => _ProductInformationPage();
}

class _ProductInformationPage extends State<ProductInformationPage> {
  var isSearching = false;
  final _createContactFormKey = GlobalKey<FormState>();
  String? dropdownValue;
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final searchboxController = TextEditingController();
  final categorySearchController = TextEditingController();
  num price = 0;
  String unit = '';

  @override
  void initState() {
    super.initState();
    Get.find<CurrentStockController>().getSubCategoryByStore(
        '${Get.find<StoreController>().staticStore.value.storeAssignID}');
    quantityController.text = "";
    priceController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = MaterialButton(
      color: Colors.orange,
      onPressed: () {
        if (Get.find<SalesController>().salesDetails.length > 0) {
          print(Get.find<SalesController>().salesDetails.value[0].toJson());
          Get.to(() => const CustomerTransactionPage());
        } else {
          Get.snackbar("Sorry", "Select product first.",
              duration: Duration(seconds: 1),
              icon: Icon(Icons.error_outline_rounded, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black,
              colorText: Colors.white);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        'Next',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );

    final productlistField =
        GetX<CurrentStockController>(builder: (controller) {
      return Get.find<CurrentStockController>().filteredProducts.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  Get.find<CurrentStockController>().filteredProducts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.all(2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: myColor.yelloAccent,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Get.find<StoreController>()
                                        .isRetailStore
                                        .value
                                    ? Text(
                                        'SAR: ${controller.filteredProducts[index].retailPrice}/ ${controller.filteredProducts[index].retailUnit}',
                                        textAlign: TextAlign.center,
                                      )
                                    : (GetStorage().read(
                                                'loginUser')['ShortCode'] ==
                                            'JED')
                                        ? Text(
                                            'SAR: ${controller.filteredProducts[index].jEDSalePrice}/ ${controller.filteredProducts[index].baseUnit}',
                                            textAlign: TextAlign.center,
                                          )
                                        : Text(
                                            'SAR: ${controller.filteredProducts[index].kHMSalePrice}/ ${controller.filteredProducts[index].baseUnit}',
                                            textAlign: TextAlign.center,
                                          ),
                              ),
                            ],
                          ),
                          Container(
                            color: myColor.yelloAccent,
                            child: Text(
                              '${controller.filteredProducts[index].productName}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 20,
                            child: (controller
                                        .filteredProducts[index].inQuantity! >
                                    0)
                                ? Text(
                                    "Available:" +
                                        controller
                                            .filteredProducts[index].inQuantity
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                          )
                        ]),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(5),
                      color: Color.fromARGB(255, 0, 0, 0),
                      border: Border.all(
                        color: Color.fromARGB(255, 240, 175, 175),
                      ),
                    ),
                  ),
                  onTap: () {
                    int data = Get.find<SalesController>()
                        .getSalesDeatailByProductID(
                            controller.filteredProducts[index].productID!);
                    if (data < 0) {
                      if (Get.find<StoreController>().isRetailStore.value ==
                          true) {
                        priceController.text = controller
                            .filteredProducts[index].retailPrice
                            .toString();
                        unit = controller.filteredProducts[index].retailUnit
                            .toString();
                      } else if (GetStorage().read('loginUser')['ShortCode'] ==
                          'JED') {
                        priceController.text = "";
                        // controller
                        //     .filteredProducts[index].jEDSalePrice
                        //     .toString();
                        unit = controller.filteredProducts[index].baseUnit
                            .toString();
                      } else {
                        priceController.text = "";
                        //  controller
                        //     .filteredProducts[index].kHMSalePrice
                        //     .toString();
                        unit = controller.filteredProducts[index].baseUnit
                            .toString();
                      }
                      (controller.filteredProducts[index].inQuantity! > 0)
                          ? Get.defaultDialog(
                              cancelTextColor: Colors.black,
                              confirmTextColor: Colors.black,
                              textConfirm: "ADD",
                              title:
                                  " Available Quantity: ${controller.filteredProducts[index].inQuantity} ${unit}",
                              content: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText:
                                                'Please Enter Quantity..'),
                                        controller: quantityController,
                                        decoration: InputDecoration(
                                          labelText: 'Quantity',
                                          labelStyle: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          border: OutlineInputBorder(),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText: 'Please Enter Price..'),
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          labelText: 'Price',
                                          labelStyle: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          border: OutlineInputBorder(),
                                        ),
                                      ))
                                ],
                              ),
                              onCancel: () {},
                              onConfirm: () {
                                double i =
                                    double.parse(quantityController.text);
                                double j = double.parse((controller
                                        .filteredProducts[index].inQuantity)
                                    .toString());

                                if (i > j) {
                                  Get.snackbar(
                                      "Sorry", "We have only $j item left.",
                                      duration: Duration(seconds: 1),
                                      icon: Icon(Icons.error_outline_rounded,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white);
                                } else if (i == 0 || i < 0) {
                                  Get.snackbar("Sorry", "Enter valid amount",
                                      duration: Duration(seconds: 1),
                                      icon: Icon(Icons.error_outline_rounded,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white);
                                } else {
                                  SaleDetails ob = SaleDetails();
                                  ob.salesDetailsId = 1;
                                  ob.quantity =
                                      num.parse(quantityController.text);
                                  ob.productName = controller
                                      .filteredProducts[index].productName;
                                  ob.partyId = Get.find<PartyController>()
                                      .selectedParty
                                      .value
                                      .partyId as int;
                                  if (controller.isVat.value == "true") {
                                    ob.vATStatus = true;
                                  } else {
                                    ob.vATStatus = false;
                                  }
                                  ob.warehouseId = Get.find<StoreController>()
                                      .staticStore
                                      .value
                                      .storeAssignID;
                                  ob.salesId = 1;
                                  ob.salesInvoice = '';

                                  ob.categoryID = controller
                                      .filteredProducts[index]
                                      .productCategoryID as int;
                                  ob.subCategoryID = controller
                                      .filteredProducts[index]
                                      .productSubCategoryID as int;
                                  ob.productId = controller
                                      .filteredProducts[index].productID as int;
                                  ob.unitId = controller
                                      .filteredProducts[index].unitID as int;
                                  if (Get.find<StoreController>()
                                          .isRetailStore
                                          .value ==
                                      true) {
                                    ob.units = controller
                                        .filteredProducts[index].retailUnit;
                                  } else {
                                    ob.units = controller
                                        .filteredProducts[index].baseUnit;
                                  }
                                  ob.unitPriceIncludingVAT =
                                      num.parse(priceController.text);
                                  ob.discountAmount = 0;
                                  ob.calculateItemDiscount = 0;
                                  ob.returnQuantity = 0;
                                  ob.deleted = false;

                                  if (Get.find<CurrentStockController>()
                                          .isVat
                                          .toString() ==
                                      "true") {
                                    ob.vATRate = controller
                                        .filteredProducts[index].vATPercentage;
                                    ob.unitPriceExcludingVAT =
                                        (ob.unitPriceIncludingVAT as num) /
                                            (((ob.vATRate as num) + 100) / 100);
                                    ob.itemSubtotalIncludingVAT =
                                        ob.unitPriceIncludingVAT! *
                                            num.parse(quantityController.text);
                                    ob.itemSubtotalExcludingVAT =
                                        ob.unitPriceExcludingVAT! *
                                            num.parse(quantityController.text);
                                  } else {
                                    ob.vATRate = 0;
                                    ob.vATAmount = 0;
                                    ob.unitPriceExcludingVAT =
                                        num.parse(priceController.text);
                                    ob.itemSubtotalIncludingVAT =
                                        ob.unitPriceIncludingVAT! *
                                            num.parse(quantityController.text);
                                    ob.itemSubtotalExcludingVAT =
                                        ob.unitPriceExcludingVAT! *
                                            num.parse(quantityController.text);
                                  }
                                  ob.vATAmount =
                                      (ob.itemSubtotalIncludingVAT as num) -
                                          (ob.itemSubtotalExcludingVAT as num);

                                  ob.quantityInWords = NumberToWord().convert(
                                      'en-in',
                                      (double.parse(quantityController.text)
                                          .round()));
                                  Map<String, dynamic> user =
                                      GetStorage().read('loginUser');

                                  ob.createdBy = user['UserId'].toString();
                                  ob.createdOn = DateTime.now().toString();
                                  ob.lastModifiedBy = user['UserId'].toString();
                                  ob.lastModifiedOn = DateTime.now().toString();

                                  Get.find<SalesController>()
                                      .salesDetails
                                      .add(ob);

                                  print(ob.toJson());
                                  quantityController.text = "";
                                  Navigator.pop(context, true);
                                  Get.snackbar(
                                      "Congrates", "Added successfully",
                                      duration: Duration(milliseconds: 800),
                                      icon: Icon(Icons.done_all_rounded,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white);
                                }
                              },
                            )
                          : Get.snackbar("Sorry", "Out of Stock!!!!",
                              duration: Duration(milliseconds: 800),
                              icon: Icon(Icons.error_outline_rounded,
                                  color: Colors.white),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Colors.white);
                    } else {
                      updateSalesDetails(data, Get.find<SalesController>());
                    }
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });

    final subcategoryListField =
        GetX<CurrentStockController>(builder: (controller) {
      return controller.subCategory.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                  itemCount: controller.filteredSubCategory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 6, 11),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.orange),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                          child: InkWell(
                            child: Text(
                              '${controller.filteredSubCategory[index]}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onTap: () {
                              Get.find<CurrentStockController>()
                                  .getProductBySubCategory(
                                      '${controller.filteredSubCategory[index]}',
                                      '${Get.find<StoreController>().staticStore.value.storeAssignID}');
                              categorySearchController.text = "";
                              Get.find<CurrentStockController>()
                                  .runFilterCategory("");

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });

    final selectedProductField = GetX<SalesController>(builder: (controller) {
      return controller.salesDetails.isNotEmpty
          ? ListView.builder(
              itemCount: controller.salesDetails.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Get.find<SalesController>()
                          .salesDetails
                          .remove(controller.salesDetails[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Item Deleted from list..')));
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 222, 186),
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: new BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height / 4,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    controller
                                        .salesDetails.value[index].productName
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Unit Price: ${controller.salesDetails.value[index].unitPriceIncludingVAT}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Selected Quantity: ${controller.salesDetails.value[index].quantity}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                height: 98,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    border:
                                        Border.all(color: myColor.yelloAccent),
                                    borderRadius: new BorderRadius.circular(7)),
                                child: Center(
                                  child: Text(
                                    "SAR ${((controller.salesDetails.value[index].itemSubtotalIncludingVAT) as num).toStringAsFixed(3)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    updateSalesDetails(index, controller);
                  },
                );
              })
          : Center();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: !isSearching
            ? const Text("Product Information")
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
        ],
      ),
      body: SafeArea(
          child: Form(
        key: _createContactFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 13),
                Container(
                    height: 130,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(child: productlistField),
                        ],
                      ),
                    )),
                SizedBox(height: 20),
                Container(
                    height: 500,
                    child: Container(
                        child: Column(
                      children: [
                        Expanded(child: selectedProductField),
                      ],
                    ))),
                SizedBox(height: 13),
              ],
            ),
          ),
        ),
      )),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 250, 242, 228),
          child: Column(
            children: [
              DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    accountName: Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    accountEmail: null,
                  )),
              TextFormField(
                controller: categorySearchController,
                autofocus: true,
                onChanged: (value) =>
                    Get.find<CurrentStockController>().runFilterCategory(value),
                decoration: const InputDecoration(
                  hintText: 'Search Category',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 13),
                ),
              ),
              subcategoryListField
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: submitButton,
      ),
    );
  }

  void updateSalesDetails(int index, SalesController controller) {
    num? id = controller.salesDetails.value[index].productId;
    VwCurrentStock data =
        Get.find<CurrentStockController>().getProductById(id!);
    quantityController.text =
        controller.salesDetails.value[index].quantity.toString();
    priceController.text =
        controller.salesDetails.value[index].unitPriceIncludingVAT.toString();
    Get.defaultDialog(
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.black,
      textConfirm: "ADD",
      title: " Available Quantity: ${data.inQuantity} ${unit}",
      content: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator:
                    RequiredValidator(errorText: 'Please Enter Quantity..'),
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: RequiredValidator(errorText: 'Please Enter Price..'),
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      ),
      onCancel: () {
        quantityController.text = "";
      },
      onConfirm: () {
        setState(() {
          double i = double.parse(quantityController.text);
          double j = double.parse((data.inQuantity).toString());
          if (i > j) {
            Get.snackbar("Sorry", "We have only $j item left.",
                duration: Duration(seconds: 1),
                icon: Icon(Icons.error_outline_rounded, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.white);
          } else {
            controller.salesDetails[index].quantity =
                double.parse(quantityController.text);

            controller.salesDetails[index].unitPriceIncludingVAT =
                double.parse(priceController.text);
            controller.salesDetails[index].discountAmount = 0;
            if (Get.find<CurrentStockController>().isVat.toString() == "true") {
              controller.salesDetails[index].vATRate = data.vATPercentage;
              controller.salesDetails[index].unitPriceExcludingVAT = (controller
                      .salesDetails[index].unitPriceIncludingVAT as num) /
                  (((controller.salesDetails[index].vATRate as num) + 100) /
                      100);
              controller.salesDetails[index].itemSubtotalIncludingVAT =
                  controller.salesDetails[index].unitPriceIncludingVAT! *
                      num.parse(quantityController.text);
              controller.salesDetails[index].itemSubtotalExcludingVAT =
                  controller.salesDetails[index].unitPriceExcludingVAT! *
                      num.parse(quantityController.text);
            } else {
              controller.salesDetails[index].vATRate = 0;
              controller.salesDetails[index].vATAmount = 0;
              controller.salesDetails[index].unitPriceExcludingVAT =
                  num.parse(priceController.text);
              controller.salesDetails[index].itemSubtotalIncludingVAT =
                  controller.salesDetails[index].unitPriceIncludingVAT! *
                      num.parse(quantityController.text);
              controller.salesDetails[index].itemSubtotalExcludingVAT =
                  controller.salesDetails[index].unitPriceExcludingVAT! *
                      num.parse(quantityController.text);
            }
            controller.salesDetails[index].vATAmount = (controller
                    .salesDetails[index].itemSubtotalIncludingVAT as num) -
                (controller.salesDetails[index].itemSubtotalExcludingVAT
                    as num);

            controller.salesDetails[index].quantityInWords = NumberToWord()
                .convert(
                    'en-in', (double.parse(quantityController.text).round()));

            quantityController.text = "";
            Navigator.pop(context, true);
            Get.snackbar("Congrates", "Added successfully",
                duration: Duration(milliseconds: 800),
                icon: Icon(Icons.done_all_rounded, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.white);
          }
          quantityController.text = "";
        });
      },
    );
  }
}
