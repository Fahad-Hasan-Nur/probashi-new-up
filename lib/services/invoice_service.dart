import '/base/utils/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvoiceService {
  Future<String> getShortCode(String locationId) async {
    String query =
        'SELECT ShortCode FROM Location WHERE LocationID=$locationId';
    print(locationId);
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData[0]['ShortCode'].toString();
    } else {
      return "";
    }
  }

  Future<String> getMaxValue(String invoiceDateRange, String locationId,
      String vatStatus, String srId) async {
    String query = "";
    if (vatStatus == "true") {
      query =
          "SELECT ISNULL(COUNT(SalesInvoice),0) as SalesInvocieNumber FROM Sales  $invoiceDateRange  AND BranchId=$locationId AND VATStatus='$vatStatus' ";
    } else {
      query =
          "SELECT TOP 1 (SalesInvoice) as SalesInvocieNumber FROM Sales  $invoiceDateRange  AND BranchId=$locationId AND VATStatus='$vatStatus' ORDER BY CreatedOn DESC";
    }

    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var range;
      if (vatStatus == "true") {
        range = jsonData[0]['SalesInvocieNumber'].toString();
      } else {
        range = jsonData[0]['SalesInvocieNumber'].toString().substring(6, 10);
      }

      print(jsonData[0]['SalesInvocieNumber'].toString());
      print(vatStatus);
      print("range is" + range);
      return range;
    } else {
      print(response.statusCode);
    }
    return "";
  }

  findIsExists(
      String invoiceDateRange, String maxValue, String locationId) async {
    String query =
        "SELECT SalesInvoice FROM Sales $invoiceDateRange  AND SalesInvoice='$maxValue' AND BranchId='$locationId'";
    var url = Uri.parse(probashiGetApi + query);
    print(url);

    var response = await http.get(url);
    List jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      if (jsonData.length == 0) {
        print(jsonData);
      } else {
        return "Not Empty";
      }
    } else {
      print(response.statusCode);
      return "";
    }
  }
}
