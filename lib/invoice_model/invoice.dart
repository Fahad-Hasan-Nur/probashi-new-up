//In the name of Allah

import 'package:probashi/invoice_model/supplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final num quantity;
  final num unitPrice;
  final num vat;
  final String date;
  final num totalIncVat;

  const InvoiceItem(
      {required this.description,
      required this.quantity,
      required this.unitPrice,
      required this.vat,
      required this.date,
      required this.totalIncVat});
}
