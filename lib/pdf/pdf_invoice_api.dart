import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../models/sales.dart';
import '/pdf/pdf_api.dart';

import '/base/utils/utils.dart';
import '/invoice_model/customer.dart';
import '/invoice_model/invoice.dart';
import '/invoice_model/supplier.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice, Sales ob, String oldDue) async {
    final pdf = Document();
    var arabicFont =
        Font.ttf(await rootBundle.load("assets/fonts/Hacen Tunisia.ttf"));

    pdf.addPage(Page(
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        margin: pw.EdgeInsets.all(3),
        pageFormat: PdfPageFormat.roll80,
        build: (context) => Column(
              children: [
                buildHeader(invoice, ob, oldDue),
                SizedBox(height: 3 * PdfPageFormat.mm),
                buildInvoice(invoice),
                Divider(),
                buildTotal(invoice, ob),
              ],
            )));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, Sales ob, String oldDue) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          pw.Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildSupplierAddress(invoice.supplier),
              SizedBox(height: 20),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                Container(
                  height: 30,
                  width: 30,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.info.number,
                  ),
                ),
              ]),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                  width: 100, child: buildCustomerAddress(invoice.customer)),
              buildInvoiceInfo(invoice.info, ob, oldDue),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 6)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info, Sales ob, String oldDue) {
    final titles = <String>[
      'Invoice Number:',
      'Invoice Issue Date:',
      'Old Due:',
      'Invoice Type:'
    ];
    var data = null;
    if (ob.salesInvoice != '') {
      data = <String>[
        ob.salesInvoice.toString(),
        Utils.formatDate(info.date),
        oldDue,
        "Mobile App"
      ];
    } else {
      data = <String>['', Utils.formatDate(info.date), oldDue];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];
        return buildText(title: title, value: value, value1: '', width: 80);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(supplier.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address, style: TextStyle(fontSize: 9)),
          Text(supplier.paymentInfo, style: TextStyle(fontSize: 9)),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      // 'طبيعة السلع أو الخدمات',
      'Nature of goods or services',
      'Quantity',
      'Unit Price',
      'Item Subtotal \n(IncludingVAT)'

      // 'كمية',

      //  'سعر الوحدة',
      //  'المضافة متضمناا ضريبة القيمةالبند المجموع الفرعي '
    ];
    final data = invoice.items.map((item) {
      return [
        item.description,
        '${item.quantity}',
        '\SAR ${item.unitPrice}',
        '\SAR ${(item.totalIncVat).toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      columnWidths: {
        0: FlexColumnWidth(30),
        1: FlexColumnWidth(12),
        2: FlexColumnWidth(12),
        3: FlexColumnWidth(20),
      },
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 5,
      ),
      headerAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerRight,
      },
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 5,
      cellStyle: pw.TextStyle(fontSize: 5),
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice, Sales ob) {
    final netTotal = ob.totalExcludingVAT;
    final vat = ob.totalIncludingVAT! - ob.totalExcludingVAT!;
    final total = ob.totalIncludingVAT;
    final paid = ob.paidAmount;
    final debt = ob.badDebt;
    final due = ob.dueAmount;

    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                buildText(
                  title: 'Total Taxable Amount (Excluding VAT)',
                  value: Utils.formatPrice(netTotal as double),
                  value1:
                      '      ضريبة القيمة لجمالي الخاضع للضريبة غير شامل     ',
                  unite: true,
                ),
                buildText(
                  title: 'Total Vat',
                  value: Utils.formatPrice(vat as double),
                  value1: '       مجموع ضريبة القيمة المضافة',
                  unite: true,
                ),
                buildText(
                  title: 'Total amount due',
                  value: Utils.formatPrice(double.parse(total.toString())),
                  value1: '      جمالي المبلغ المستحق',
                  unite: true,
                ),
                buildText(
                  title: 'Paid Amount',
                  value: Utils.formatPrice(double.parse(paid.toString())),
                  value1: '      المبلغ المدفوع',
                  unite: true,
                ),
                buildText(
                  title: 'Bad debt Amount',
                  value: Utils.formatPrice(double.parse(debt.toString())),
                  value1: '      مبلغ الديون المعدومة',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'lnvoice Due Amount',
                  value: Utils.formatPrice(due as double),
                  value1: '      مبلغ الفاتورة المستحقة',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold, fontSize: 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: TextStyle(fontSize: 5)),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    required String value1,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontSize: 5);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold))),
          Text(value1,
              textDirection: TextDirection.rtl,
              style: unite
                  ? style
                  : TextStyle(
                      fontSize: 5,
                    )),
          Text(value,
              style: unite
                  ? style
                  : TextStyle(
                      fontSize: 5,
                    )),
        ],
      ),
    );
  }
}
