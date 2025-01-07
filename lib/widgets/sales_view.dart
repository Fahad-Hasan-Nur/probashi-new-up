import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probashi/controllers/party_controller.dart';
import 'package:probashi/controllers/sales_controller.dart';
import 'package:probashi/models/sale_details.dart';
import 'package:probashi/pages/draft.dart';
import 'package:probashi/pages/sales_history.dart';
import '../invoice_model/customer.dart';
import '../invoice_model/invoice.dart';
import '../invoice_model/supplier.dart';
import '../models/party.dart';
import '../models/sales.dart';
import '../pdf/pdf_api.dart';
import '../pdf/pdf_invoice_api.dart';

class SalesView extends StatefulWidget {
  final Sales sales;
  const SalesView({Key? key, required this.sales}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  Party party = Party();

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  // This widget is the root of your application.
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
              color: Color.fromARGB(255, 255, 145, 1),
              width: .9,
            ),
            color: Color.fromARGB(255, 255, 243, 213),
          ),
          child: SizedBox(
            height: 120,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(party.username.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          textAlign: TextAlign.left),
                      Text(
                        widget.sales.salesInvoice.toString(),
                      ),
                      Text(
                        widget.sales.salesDate.toString().substring(0, 10),
                      ),
                      (widget.sales.sync == 'false')
                          ? Text(
                              "Not Synced",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      (widget.sales.sync == 'draft')
                          ? Text(
                              "  DRAFT",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )
                          : Text(
                              "SAR ${widget.sales.totalIncludingVAT}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 106, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                      (widget.sales.sync == 'false')
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 230, 95, 95),
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                      ),
                                      onPressed: () {
                                        deleteInvoice(widget.sales);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 20,
                                      )),
                                ),
                              ],
                            )
                          : (widget.sales.sync == 'true')
                              ? SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 1, 2, 0),
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                      ),
                                      onPressed: () {
                                        printPdf(widget.sales,
                                            party.dueBalance.toString());
                                      },
                                      child: Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: Color.fromARGB(255, 251, 255, 0),
                                        size: 20,
                                      )),
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 0, 0, 0),
                                            padding: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          onPressed: () {
                                            Get.to(DraftPage(
                                              sales: widget.sales,
                                            ));
                                          },
                                          child: Icon(
                                            Icons.drafts,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 20,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 230, 95, 95),
                                            padding: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          onPressed: () {
                                            deleteDraft(widget.sales);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 20,
                                          )),
                                    ),
                                  ],
                                )
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  void printPdf(Sales ob, String oldDue) async {
    final date = DateTime.parse(ob.createdOn.toString());
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
      supplier: Supplier(
        name: 'Est.Thafirah Ahmed For Food &Vegetable.',
        address:
            'CR-NO5855341845, VAT registration \nNo-310288895700003,Phone#: Call',
        paymentInfo: 'Call +966532850999+966506299092',
      ),
      customer: Customer(
        name: party.username.toString(),
        address: '',
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: '',
        number: '${DateTime.now().year}-9999',
      ),
      items: await getInvoiceItem(ob.SRInvoice!),
    );

    final pdfFile = await PdfInvoiceApi.generate(invoice, ob, oldDue);

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

  void setInitialData() async {
    Party ob =
        await Get.find<PartyController>().getPartyById(widget.sales.partyId!);
    setState(() {
      party = ob;
    });
  }

  deleteDraft(Sales ob) {
    Get.defaultDialog(
        title: "Do you really want to delete draft ???",
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

                Get.find<SalesController>().deleteSale(ob.SRInvoice);
                Get.offAll(SalesHistoryPage());
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
                Navigator.of(context).pop();
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

  deleteInvoice(Sales ob) {
    Get.defaultDialog(
        title: "Do you really want to delete this non synced invoice ???",
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

                Get.find<SalesController>().deleteSale(ob.SRInvoice);
                Get.offAll(SalesHistoryPage());
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
                Navigator.of(context).pop();
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
}
