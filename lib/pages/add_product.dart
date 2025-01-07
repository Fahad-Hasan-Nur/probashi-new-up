import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:probashi/base/constants/constant_strings.dart';
import '/controllers/party_controller.dart';
import '/controllers/sales_controller.dart';
import '/controllers/store_controller.dart';
import '/widgets/drawer.dart';
import 'package:uuid/uuid.dart';
import '../controllers/current_stock_controller.dart';
import 'product_info.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final stockController = Get.put(CurrentStockController());
  final storeController = Get.put(StoreController());
  final partyController = Get.put(PartyController());
  final salesController = Get.put(SalesController());
  final format = DateFormat("yyyy-MM-dd");
  DateTime? dob = DateTime.now();
  //num _selectedPartyId = 0;
  final _createContactFormKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController storeTextController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController myController = TextEditingController();
  var _dropDownValue;

  setInitialData() async {
    Map<String, dynamic> user = GetStorage().read('loginUser');
    if (user['RoleName'] == sr) {}
    dateController.text = DateTime.now().toString().substring(0, 10);
    numberController.text =
        Get.find<SalesController>().invoice.value.toString();
  }

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final numberField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: numberController,
        decoration: InputDecoration(
          labelText: 'TAX Invoice',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final dateField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(
          labelText: 'Date',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );
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
              if (isAdvanceTime(value.toString())) {
                Get.snackbar("Sorry", "You can not select future date!!",
                    duration: Duration(seconds: 1),
                    icon:
                        Icon(Icons.error_outline_rounded, color: Colors.white),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black,
                    colorText: Colors.white);
              } else {
                dob = value;
              }
            });

            return dob;
          },
        ));

    final storeField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Get.find<StoreController>().staticStore.value.name != null
            ? TextFormField(
                readOnly: true,
                initialValue: Get.find<StoreController>()
                    .staticStore
                    .value
                    .name
                    .toString(),
                validator: RequiredValidator(errorText: 'quentity is required'),
                decoration: InputDecoration(
                  labelText: 'Store',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              )
            : Text("No data");
      }),
    );

    final submitButton = MaterialButton(
      color: Colors.orange,
      onPressed: () {
        print(Get.find<PartyController>().selectedParty.value.partyId);
        if (Get.find<PartyController>().selectedParty.value.partyId != 0) {
          checkAndUpdateCustomer();
          if (Get.find<CurrentStockController>().isVat != "") {
            Get.find<SalesController>().salesDate.value = dob.toString();
            Get.to(
              () => const ProductInformationPage(),
              transition: Transition.rightToLeft,
            );
          } else {
            setVatStatus();
          }
        } else {
          Get.defaultDialog(
              title: "OPPPPPSSSS!!!!",
              middleText: 'Select Customer First.',
              titleStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        'Next',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );

    final customerField1 = Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Customer',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: myController,
                  decoration: new InputDecoration(
                    hintText: "type or search",
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback: getData,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  myController.text = suggestion!;
                  updateCustomer();
                },
              ),
            )),
      ),
    );

    // final customerField = Container(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: InputDecorator(
    //       decoration: InputDecoration(
    //         labelText: 'Customer',
    //         labelStyle: TextStyle(color: Colors.black),
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5.0),
    //         ),
    //       ),
    //       child: Obx(() {
    //         var party = Get.find<PartyController>().allParties;
    //         print(Get.find<PartyController>().allParties.toList());
    //         return DropdownButton<String>(
    //           hint: Text("Select Customer."),
    //           dropdownColor: yelloLight,
    //           value: _dropDownValue,
    //           isExpanded: true,
    //           elevation: 16,
    //           onChanged: (String? newValue) {
    //             setState(() {
    //               _dropDownValue = newValue!;
    //               setVatStatus();
    //             });
    //             for (var item in party) {
    //               if (item.username == newValue) {
    //                 Get.find<PartyController>().selectedParty.value = item;
    //                 _selectedPartyId = item.partyId!;
    //                 break;
    //               }
    //             }
    //           },
    //           items: party.map((Party data) {
    //             return DropdownMenuItem(
    //               value: data.username,
    //               child: Text(
    //                 data.username!,
    //               ),
    //             );
    //           }).toList(),
    //         );
    //       }),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(' Invoice Create'),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _createContactFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  dateField1,
                  storeField,
                  // customerField,
                  customerField1,
                  numberField,
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: submitButton,
      ),
      drawer: MyDrawer(),
    );
  }

  void checkAndUpdateCustomer() {
    if (Get.find<SalesController>().salesDetails.length > 1) {
      for (int i = 0;
          i < Get.find<SalesController>().salesDetails.length;
          i++) {
        Get.find<SalesController>().salesDetails[i].partyId =
            Get.find<PartyController>().selectedParty.value.partyId as int;
      }
    }
  }

  void setVatStatus() {
    Get.defaultDialog(
        title: "Do you want to continue with vat???",
        middleText: '',
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        barrierDismissible: false,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: Color.fromARGB(255, 50, 214, 9),
              onPressed: () {
                Navigator.of(context).pop();

                Get.find<CurrentStockController>().isVat.value = "true";
                makeInvoice();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'YES',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Color.fromARGB(255, 255, 8, 8),
              onPressed: () {
                Get.find<CurrentStockController>().isVat.value = "false";

                Navigator.of(context).pop();
                makeInvoice();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'NO',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ));
  }

  makeInvoice() async {
    setState(() {
      var uuid = Uuid();
      numberController.text = uuid.v4();
      salesController.invoice.value = uuid.v4();
    });
  }

  updateCustomer() {
    if (Get.find<PartyController>().partyData.contains(myController.text)) {
      for (var item in Get.find<PartyController>().allParties) {
        if (item.username == myController.text) {
          Get.find<PartyController>().selectedParty.value = item;
          break;
        }
      }
      setVatStatus();
    }
  }

  static Future<List<String>> getData(String query) async {
    List<String> cc = Get.find<PartyController>().partyData;
    return List.of(cc).where((cc) {
      final ccLower = cc.toLowerCase();
      final queryLower = query.toLowerCase();
      return ccLower.contains(queryLower);
    }).toList();
  }

  bool isAdvanceTime(String data) {
    String today = ((DateTime.now().toString()).substring(0, 10));
    num selected = num.parse(
        data.substring(0, 4) + data.substring(5, 7) + data.substring(8, 10));
    num now = num.parse(
        today.substring(0, 4) + today.substring(5, 7) + today.substring(8, 10));
    if (selected > now) {
      return true;
    } else {
      return false;
    }
  }
}
