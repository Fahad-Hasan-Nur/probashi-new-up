import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/controllers/data_sync_controller.dart';
import '../base/utils/db_helper.dart';
import '../models/party.dart';
import '/controllers/current_stock_controller.dart';
import '/controllers/sales_controller.dart';
import '/models/sale_details.dart';
import '/models/sales.dart';
import '/controllers/party_controller.dart';
import '/invoice_model/customer.dart';
import '/invoice_model/invoice.dart';
import '/invoice_model/supplier.dart';
import '/pdf/pdf_api.dart';
import '/pdf/pdf_invoice_api.dart';
import 'dashboard.dart';

class DraftPage extends StatefulWidget {
  final Sales sales;
  const DraftPage({Key? key, required this.sales}) : super(key: key);

  @override
  _DraftPageState createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {
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
                if (paidAmountController.text != "" &&
                    bedDueColtroller.text != "") {
                  widget.sales.paidAmount =
                      double.parse(paidAmountController.text);
                  updateDue();
                } else {
                  invoiceDueColtroller.text = "0";
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
              if (paidAmountController.text != "" &&
                  bedDueColtroller.text != "") {
                widget.sales.badDebt = double.parse(bedDueColtroller.text);
                updateDue();
              } else {
                invoiceDueColtroller.text = "0";
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
              child: Text(
                'Save & Print',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        ElevatedButton(
          onPressed: () {
            Get.find<SalesController>().salesDetails.clear();
            Get.find<SalesController>().invoice.value = "";
            Get.offAll(() => DashboardPage());
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
            'Sales Draft',
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

  void setInitialData() async {
    List<SaleDetails> data = await Get.find<SalesController>()
        .getSalesDeatailBySales(widget.sales.SRInvoice.toString());

    for (SaleDetails ob in data) {
      totalExcludingVAT += ob.itemSubtotalExcludingVAT as num;
      totalVAT += ob.vATAmount as num;
      totalIncludingVAT += ob.itemSubtotalIncludingVAT as num;
    }
    widget.sales.totalExcludingVAT =
        double.parse((totalExcludingVAT).toStringAsFixed(2));
    widget.sales.totalIncludingVAT =
        double.parse((totalIncludingVAT).toStringAsFixed(2));
    widget.sales.vATAmount = totalVAT;

    totalAmountController.text = totalIncludingVAT.toString();
    totalExcludingVatFieldController.text =
        double.parse((totalExcludingVAT).toStringAsFixed(2)).toString();
    totalVatFieldController.text =
        double.parse((totalVAT).toStringAsFixed(2)).toString();

    await Get.find<PartyController>()
        .getPartyById(widget.sales.partyId!)
        .then((value) {
      oldDueColtroller.text = double.parse(value.dueBalance.toString())
          .toStringAsFixed(2)
          .toString();
    });
    paidAmountController.text = widget.sales.paidAmount.toString();
    bedDueColtroller.text = widget.sales.badDebt.toString();
    invoiceDueColtroller.text = widget.sales.dueAmount.toString();
  }

  void updateDue() {
    invoiceDueColtroller.text = (totalIncludingVAT -
            (num.parse(paidAmountController.text) +
                (num.parse(bedDueColtroller.text))))
        .toString();
    widget.sales.dueAmount = totalIncludingVAT -
        (num.parse(paidAmountController.text) +
            (num.parse(bedDueColtroller.text)));
  }

  void saveData() async {
    if ((paidAmountController.text.isNotEmpty) &&
        (double.parse(invoiceDueColtroller.text)) > (-1.0)) {
      try {
        widget.sales.paidAmount = num.parse(paidAmountController.text);
        widget.sales.badDebt = num.parse(bedDueColtroller.text);
        widget.sales.dueAmount = num.parse(invoiceDueColtroller.text);
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

      if (widget.sales.dueAmount == 0) {
        widget.sales.payStatus = "Paid";
      } else {
        widget.sales.payStatus = "UnPaid";
      }
      widget.sales.paymentNote = "Empty";

      Map<String, dynamic> user = GetStorage().read('loginUser');

      widget.sales.sync = "false";

      Get.snackbar("Congrates", "Created Successfull'",
          duration: Duration(seconds: 2),
          icon: Icon(Icons.error_outline_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      await Get.find<SalesController>().updateSale(widget.sales);
      Get.find<CurrentStockController>().isVat.value = "";

      //added
      if (await InternetConnectionChecker().hasConnection) {
        Get.find<DataSyncController>().syncData().then((value) async {
          Sales data = await Get.find<SalesController>()
              .getSalesById(widget.sales.SRInvoice.toString());
          widget.sales.salesInvoice = data.salesInvoice;
          if (printData) {
            printPdf(widget.sales);
          }
        });
      } else {
        if (printData) {
          printPdf(widget.sales);
        }

        updatePartyDue();
        Get.offAll(() => DashboardPage());
      }
      //added

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
}
