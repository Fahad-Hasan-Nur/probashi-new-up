import 'package:get/get.dart';
import 'package:probashi/controllers/login_controller.dart';

import '../base/utils/db_helper.dart';
import '/models/party.dart';
import '/base/utils/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PartyService {
  Future<List<Party>> getPartyByStore(String storeId) async {
    List<Party> storeParties = <Party>[];
    String query = 'select * from party where StoreAssignId=1';
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var ob in jsonData) {
        storeParties.add(Party.fromJson(ob));
      }
    }
    return storeParties;
  }

  Future<List<Party>> getPartyByStore1(String userId) async {
    List<Party> storeParties = <Party>[];
    var jsonData;

    String query =
        "SELECT Party.PartyId, Party.Username, VWParty.DueBalance FROM MainOfficeLocation INNER JOIN Party WITH (NOLOCK) ON MainOfficeLocation.Id = Party.AreaId INNER JOIN VWParty ON Party.PartyId = VWParty.PartyId WHERE (MainOfficeLocation.Id = (SELECT AreaLocationID FROM Employee WHERE       (EmployeeID = '$userId'))) AND (Party.PartyRoleId = '1')";
    var url = Uri.parse(probashiGetApi + query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        jsonData = json.decode(response.body);
        for (var ob in jsonData) {
          storeParties.add(Party.fromJson(ob));
        }
      } catch (Exception) {
        Get.find<LoginController>().quaritine(jsonData.toString());
      }
    }
    return storeParties;
  }

  Future<void> updatePartyDue(String due, int partyId) async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.getPartyById(partyId);
    Party ob = (Party.fromJson(data[0]));
    ob.dueBalance = due;
    return await DatabaseHelper.instance.partyUpdate(ob);
  }
}
