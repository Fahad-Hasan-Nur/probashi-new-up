import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:probashi/controllers/data_sync_controller.dart';
import '../base/utils/db_helper.dart';
import '../models/party.dart';
import '/controllers/current_stock_controller.dart';
import '/controllers/sales_controller.dart';
import '/controllers/store_controller.dart';
import '/models/sale_details.dart';
import '/models/sales.dart';
import '/controllers/party_controller.dart';
import '/invoice_model/customer.dart';
import '/invoice_model/invoice.dart';
import '/invoice_model/supplier.dart';
import '/pdf/pdf_api.dart';
import '/pdf/pdf_invoice_api.dart';
import 'dashboard.dart';

class CustomerTransactionPage extends StatefulWidget {
  const CustomerTransactionPage({Key? key}) : super(key: key);

  @override
  _CustomerTransactionPageState createState() =>
      _CustomerTransactionPageState();
}

class _CustomerTransactionPageState extends State<CustomerTransactionPage> {
  final _createCustomerTransactionPageFormKey = GlobalKey<FormState>();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController bedDueColtroller = TextEditingController();
  TextEditingController invoiceDueColtroller = TextEditingController();
  TextEditingController oldDueColtroller = TextEditingController();
  TextEditingController totalExcludingVatFieldController =
      TextEditingController();
  TextEditingController totalVatFieldController = TextEditingController();
  double totalExcludingVAT = 0;
  double totalVAT = 0;
  double totalIncludingVAT = 0;
  bool printData = false;
  var data;
  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final totalAmountField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: totalAmountController,
        decoration: InputDecoration(
          labelText: 'Total Amount Due',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final oldDueField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: oldDueColtroller,
        decoration: InputDecoration(
          labelText: 'Old Due',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final totalExcludingVatField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: totalExcludingVatFieldController,
        decoration: InputDecoration(
          labelText: 'Total Excluding VAT',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final totalVatField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: totalVatFieldController,
        decoration: InputDecoration(
          labelText: 'Total  VAT',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final paidAmountField = Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: RequiredValidator(errorText: 'name is required'),
          controller: paidAmountController,
          decoration: InputDecoration(
            labelText: 'Paid Amount',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
          onChanged: (text) {
            setState(() {
              try {
                if (paidAmountController.text != "") {
                  Get.find<SalesController>().paid.value =
                      double.parse(paidAmountController.text);
                  updateDue();
                }
              } catch (Exception) {
                Get.defaultDialog(
                    title: "Error",
                    titleStyle: TextStyle(
                      fontSize: 40,
                    ),
                    content: Text(
                      "Invalid Value!!!",
                      style: TextStyle(color: Colors.red),
                    ),
                    textConfirm: "TRY AGAIN",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                    buttonColor: Color.fromARGB(255, 255, 172, 71));
              }
            });
          },
        ));

    final bedDueField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: RequiredValidator(errorText: 'name is required'),
        controller: bedDueColtroller,
        decoration: InputDecoration(
          labelText: 'Bed Debt',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
        onChanged: (text) {
          setState(() {
            try {
              if (bedDueColtroller.text != "") {
                Get.find<SalesController>().debt.value =
                    double.parse(bedDueColtroller.text);
                updateDue();
              }
            } catch (Exception) {
              Get.defaultDialog(
                  title: "Error",
                  titleStyle: TextStyle(
                    fontSize: 40,
                  ),
                  content: Text(
                    "Invalid Value!!!",
                    style: TextStyle(color: Colors.red),
                  ),
                  textConfirm: "Fix Now",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Navigator.pop(context);
                  },
                  buttonColor: Color.fromARGB(255, 255, 172, 71));
            }
          });
        },
      ),
    );
    final spinkit =
        SpinKitFadingCircle(itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color:
              index.isEven ? Color.fromARGB(255, 227, 149, 66) : Colors.green,
        ),
      );
    });
    final invoiceDueField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: invoiceDueColtroller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Invoice Due',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final submitBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ElevatedButton(
              onPressed: () async {
                saveData();
                if (await InternetConnectionChecker().hasConnection &&
                    (paidAmountController.text.isNotEmpty) &&
                    ((double.parse(invoiceDueColtroller.text)) > (-1.0)) &&
                    ((double.parse(paidAmountController.text)) > (-1.0))) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => spinkit,
                      fullscreenDialog: true,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ElevatedButton(
              onPressed: () async {
                printData = true;
                saveData();
                if (await InternetConnectionChecker().hasConnection &&
                    (paidAmountController.text.isNotEmpty) &&
                    ((double.parse(invoiceDueColtroller.text)) > (-1.0)) &&
                    ((double.parse(paidAmountController.text)) > (-1.0))) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => spinkit,
                      fullscreenDialog: true,
                    ),
                  );
                }
              },
              child: Icon(Icons.print)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ElevatedButton(
            onPressed: () {
              saveDraft();
            },
            child: Icon(Icons.drafts),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 234, 0),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.find<SalesController>().salesDetails.clear();
            Get.find<SalesController>().invoice.value = "";
            Get.offAll(() => DashboardPage());
          },
          child: Icon(Icons.cancel),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 17, 0),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Customer Transaction',
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                key: _createCustomerTransactionPageFormKey,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            totalExcludingVatField,
                            totalVatField,
                            oldDueField,
                            totalAmountField,
                            paidAmountField,
                            bedDueField,
                            invoiceDueField,
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: submitBtn,
      ),
    );
  }

  void setInitialData() {
    List<SaleDetails> data = Get.find<SalesController>().salesDetails.value;

    for (SaleDetails ob in data) {
      totalExcludingVAT += ob.itemSubtotalExcludingVAT as num;
      totalVAT += ob.vATAmount as num;
      totalIncludingVAT += ob.itemSubtotalIncludingVAT as num;
    }
    Get.find<SalesController>().totalExcVAT.value =
        double.parse((totalExcludingVAT).toStringAsFixed(2));
    Get.find<SalesController>().totalIncVAT.value =
        double.parse((totalIncludingVAT).toStringAsFixed(2));
    Get.find<SalesController>().totalVAT.value = totalVAT;

    totalAmountController.text = totalIncludingVAT.toString();
    totalExcludingVatFieldController.text =
        double.parse((totalExcludingVAT).toStringAsFixed(2)).toString();
    totalVatFieldController.text =
        double.parse((totalVAT).toStringAsFixed(2)).toString();
    oldDueColtroller.text = double.parse(Get.find<PartyController>()
            .selectedParty
            .value
            .dueBalance
            .toString())
        .toStringAsFixed(2)
        .toString();
  }

  void updateDue() {
    invoiceDueColtroller.text = (totalIncludingVAT -
            ((Get.find<SalesController>().paid.value) +
                (Get.find<SalesController>().debt.value)))
        .toString();
    Get.find<SalesController>().due.value = (totalIncludingVAT -
        ((Get.find<SalesController>().paid.value) +
            (Get.find<SalesController>().debt.value)));
  }

  void saveData() async {
    if ((paidAmountController.text.isNotEmpty) &&
        (double.parse(invoiceDueColtroller.text)) > (-1.0)) {
      Sales ob = Sales();
      ob.salesId = 1;
      ob.SRInvoice = Get.find<SalesController>().invoice.value;
      ob.salesInvoice = '';
      ob.partyId =
          Get.find<PartyController>().selectedParty.value.partyId as int;
      ob.salesDate = Get.find<SalesController>()
              .salesDate
              .value
              .toString()
              .substring(0, 10) +
          " 00:00:00.0000000";
      ob.totalExcludingVAT = Get.find<SalesController>().totalExcVAT.value;
      ob.usePercentage = false;
      ob.discountPercentage = 0;
      ob.discountAmount = 0;
      if (Get.find<CurrentStockController>().isVat == "true") {
        ob.vATStatus = true;
      } else {
        ob.vATStatus = false;
      }
      ob.vATAmount = Get.find<SalesController>().totalVAT.value;
      ob.totalIncludingVAT = Get.find<SalesController>().totalIncVAT.value;
      ob.amountInWords =
          (NumberToWord().convert('en-in', (ob.totalIncludingVAT!.round())));
      try {
        ob.paidAmount = Get.find<SalesController>().paid.value;
        ob.badDebt = Get.find<SalesController>().debt.value;
        ob.dueAmount = Get.find<SalesController>().due.value;
      } catch (Exception) {
        Get.defaultDialog(
            title: "Error",
            titleStyle: TextStyle(
              fontSize: 40,
            ),
            content: Text(
              "Invalid Value!!!",
              style: TextStyle(color: Colors.red),
            ),
            textConfirm: "TRY AGAIN",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Navigator.pop(context);
            },
            buttonColor: Color.fromARGB(255, 255, 172, 71));
      }

      if (ob.dueAmount == 0) {
        ob.payStatus = "Paid";
      } else {
        ob.payStatus = "UnPaid";
      }
      ob.paymentNote = "Empty";

      Map<String, dynamic> user = GetStorage().read('loginUser');
      ob.sRId = user['EmployeeID'];
      ob.warehouseId =
          Get.find<StoreController>().staticStore.value.storeAssignID;
      ob.createdBy = user['UserId'].toString();
      ob.createdOn = DateTime.now().toString();
      ob.lastModifiedBy = user['UserId'].toString();
      ob.lastModifiedOn = DateTime.now().toString();
      ob.branchId = user['LocationID'];
      ob.active = true;
      ob.deleted = false;
      ob.submitDate = DateTime.now().toString();
      ob.saveMode = 'Submitted';
      ob.companyID = 1;
      ob.sync = "false";

      Get.snackbar("Congrates", "Created Successfull'",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);

      Get.find<SalesController>().saveSale(ob);
      Get.find<CurrentStockController>().isVat.value = "";

      //added
      if (await InternetConnectionChecker().hasConnection) {
        Get.find<DataSyncController>().syncData().then((value) async {
          Sales data = await Get.find<SalesController>()
              .getSalesById(ob.SRInvoice.toString());
          ob.salesInvoice = data.salesInvoice;
          if (printData) {
            printPdf(ob);
          }
        });
      } else {
        if (printData) {
          printPdf(ob);
        }
        updatePartyDue();
        Get.offAll(() => DashboardPage());
      }
      //added

    } else if ((paidAmountController.text.isEmpty) ||
        ((double.parse(paidAmountController.text)) < 0.0)) {
      Get.snackbar("OPPPSSS'", "Enter valid paid amount please'",
          duration: Duration(seconds: 1),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    } else {
      Get.snackbar("OPPPSSS'", "Paid amount can not be bigger than total due'",
          duration: Duration(seconds: 1),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }

  void printPdf(Sales ob) async {
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
      supplier: Supplier(
        name: 'Est.Thafirah Ahmed For Food &Vegetable.',
        address:
            'CR-NO5855341845, VAT registration \nNo-310288895700003,Phone#: Call',
        paymentInfo: 'Call +966532850999+966506299092',
      ),
      customer: Customer(
        name: '${Get.find<PartyController>().selectedParty.value.username}',
        address: setAddress(),
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: '',
        number: '${DateTime.now().year}-9999',
      ),
      items: await getInvoiceItem(ob.SRInvoice!),
    );
    print(ob.SRInvoice);
    print("invoice items " + await getInvoiceItem(ob.SRInvoice!).toString());

    final pdfFile = await PdfInvoiceApi.generate(invoice, ob,
        Get.find<PartyController>().selectedParty.value.dueBalance.toString());

    PdfApi.openFile(pdfFile);
  }

  getInvoiceItem(String id) async {
    List<InvoiceItem> data = [];

    List<SaleDetails> sales =
        await Get.find<SalesController>().getSalesDeatailBySales(id);
    for (var ob in sales)
      data.add(InvoiceItem(
          description: ob.productName.toString(),
          date: ob.createdOn.toString().substring(0, 10),
          quantity: ob.quantity as num,
          vat: ob.vATRate as num,
          unitPrice: ob.unitPriceIncludingVAT as num,
          totalIncVat: ob.itemSubtotalIncludingVAT as num));
    return data;
  }

  setAddress() {
    if (Get.find<PartyController>().selectedParty.value.address != null) {
      return '${Get.find<PartyController>().selectedParty.value.address}';
    } else {
      return '';
    }
  }

  Future updatePartyDue() async {
    Map<String, dynamic> user = GetStorage().read('loginUser');

    Party party = Get.find<PartyController>().selectedParty.value;
    party.dueBalance = ((double.parse(party.dueBalance.toString())) +
            (Get.find<SalesController>().due.value))
        .toString();
    await DatabaseHelper.instance.partyUpdate(party).then((value) =>
        Get.find<PartyController>().getParty("${user['EmployeeID']}"));
  }

  Future<void> saveDraft() async {
    if (paidAmountController.text.isEmpty) {
      paidAmountController.text = "0";
      invoiceDueColtroller.text = "0";
    }
    if ((paidAmountController.text.isNotEmpty) &&
        (double.parse(invoiceDueColtroller.text)) > (-1.0)) {
      Sales ob = Sales();
      ob.salesId = 1;
      ob.SRInvoice = Get.find<SalesController>().invoice.value;
      ob.salesInvoice = '';
      ob.partyId =
          Get.find<PartyController>().selectedParty.value.partyId as int;
      ob.salesDate = Get.find<SalesController>()
              .salesDate
              .value
              .toString()
              .substring(0, 10) +
          " 00:00:00.0000000";
      ob.totalExcludingVAT = Get.find<SalesController>().totalExcVAT.value;
      ob.usePercentage = false;
      ob.discountPercentage = 0;
      ob.discountAmount = 0;
      if (Get.find<CurrentStockController>().isVat == "true") {
        ob.vATStatus = true;
      } else {
        ob.vATStatus = false;
      }
      ob.vATAmount = Get.find<SalesController>().totalVAT.value;
      ob.totalIncludingVAT = Get.find<SalesController>().totalIncVAT.value;
      ob.amountInWords =
          (NumberToWord().convert('en-in', (ob.totalIncludingVAT!.round())));
      try {
        ob.paidAmount = Get.find<SalesController>().paid.value;
        ob.badDebt = Get.find<SalesController>().debt.value;
        ob.dueAmount = Get.find<SalesController>().due.value;
      } catch (Exception) {
        Get.defaultDialog(
            title: "Error",
            titleStyle: TextStyle(
              fontSize: 40,
            ),
            content: Text(
              "Invalid Value!!!",
              style: TextStyle(color: Colors.red),
            ),
            textConfirm: "TRY AGAIN",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Navigator.pop(context);
            },
            buttonColor: Color.fromARGB(255, 255, 172, 71));
      }

      if (ob.dueAmount == 0) {
        ob.payStatus = "Paid";
      } else {
        ob.payStatus = "UnPaid";
      }
      ob.paymentNote = "Empty";

      Map<String, dynamic> user = GetStorage().read('loginUser');
      ob.sRId = user['EmployeeID'];
      ob.warehouseId =
          Get.find<StoreController>().staticStore.value.storeAssignID;
      ob.createdBy = user['UserId'].toString();
      ob.createdOn = DateTime.now().toString();
      ob.lastModifiedBy = user['UserId'].toString();
      ob.lastModifiedOn = DateTime.now().toString();
      ob.branchId = user['LocationID'];
      ob.active = true;
      ob.deleted = false;
      ob.submitDate = DateTime.now().toString();
      ob.saveMode = 'Submitted';
      ob.companyID = 1;
      ob.sync = "draft";

      Get.snackbar("Congrates", "Draft Saved Successfull'",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);

      await Get.find<SalesController>().saveSale(ob).then((value) {
        Get.find<CurrentStockController>().isVat.value = "";
        Get.offAll(() => DashboardPage());
      });
    } else if ((paidAmountController.text.isEmpty) ||
        ((double.parse(paidAmountController.text)) < 0.0)) {
      Get.snackbar("OPPPSSS'", "Enter valid paid amount pleas'",
          duration: Duration(seconds: 1),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    } else {
      Get.snackbar("OPPPSSS'", "Paid amount can not be bigger than total du'",
          duration: Duration(seconds: 1),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }
}
