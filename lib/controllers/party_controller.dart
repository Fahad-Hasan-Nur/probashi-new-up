import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '/models/party.dart';
import '../../../../../base/constants/table_names.dart';
import '../../../../../base/utils/db_helper.dart';
import '../services/party_service.dart';

class PartyController extends GetxController {
  List<Party> allParties = <Party>[].obs;
  var partyData = <String>[].obs;

  var selectedParty = Party().obs;
  final _service = Get.put(PartyService());

  selectParty(Party ob) {
    selectedParty = ob as Rx<Party>;
  }

  fetchInitialData() {
    for (Party ob in allParties) {
      partyData.add(ob.username.toString());
      //+ " (" + ob.vATNumber.toString() + ")");
    }
  }

  Future getParty(String storeId) async {
    if (await InternetConnectionChecker().hasConnection) {
      List<Party> parties = await _service
          .getPartyByStore1(storeId)
          .then((value) => savePartyToLocal(value));

      if (allParties.isNotEmpty) {
        allParties.clear();
        for (var item in parties) {
          allParties.add(item);
        }
      } else {
        for (var item in parties) {
          allParties.add(item);
        }
      }
    } else {
      List<Map<String, dynamic>> data =
          await DatabaseHelper.instance.queryAll(TableNames.PARTY_TABLE);
      if (allParties.isNotEmpty) {
        allParties.clear();
        for (var item in data) {
          allParties.add(Party.fromJson(item));
        }
      } else {
        for (var item in data) {
          allParties.add(Party.fromJson(item));
        }
      }
    }
  }

  Future<List<Party>> savePartyToLocal(List<Party> parties) async {
    await DatabaseHelper.instance.truncate(TableNames.PARTY_TABLE);
    for (Party ob in parties) {
      await DatabaseHelper.instance.insert(
        {
          PartyTableColumn.ACTIVE: ob.active,
          PartyTableColumn.ADDITIONAL_NUMBER: ob.additionalNumber,
          PartyTableColumn.ADDRESS: ob.address,
          PartyTableColumn.AREA_ID: ob.areaId,
          PartyTableColumn.BUILDING_NUMBER: ob.buildingNumber,
          PartyTableColumn.CITY_NAME: ob.cityName,
          PartyTableColumn.CONTACT_NUMBER: ob.contactNumber,
          PartyTableColumn.CONTACT_PERSON: ob.contactPerson,
          PartyTableColumn.COUNTRY: ob.country,
          PartyTableColumn.CR: ob.cr,
          PartyTableColumn.CREATED_BY: ob.createdBy,
          PartyTableColumn.CREATED_ON: ob.createdOn,
          PartyTableColumn.DESCRIPTION: ob.description,
          PartyTableColumn.DISTRICT_NAME: ob.districtName,
          PartyTableColumn.DR: ob.dr,
          PartyTableColumn.IS_SUPERVISOR: ob.isSupervisor,
          PartyTableColumn.IS_TAX_EXEMPT: ob.isTaxExempt,
          PartyTableColumn.LAST_MODIFIED_BY: ob.lastModifiedBy,
          PartyTableColumn.LAST_MODIFIED_ON: ob.lastModifiedOn,
          PartyTableColumn.LOCATION_ID: ob.locationId,
          PartyTableColumn.OPENING_BALANCE: ob.openingBalance,
          PartyTableColumn.OPENING_BALANCE_DATE: ob.openingBalanceDate,
          PartyTableColumn.PARTY_ID: ob.partyId,
          PartyTableColumn.PARTY_ROLE_ID: ob.partyRoleId,
          PartyTableColumn.POSTAL_CODE: ob.postalCode,
          PartyTableColumn.STORE_ASSIGN_ID: ob.storeAssignId,
          PartyTableColumn.STREET_NAME: ob.streetName,
          PartyTableColumn.TIN_NUMBER: ob.tINNumber,
          PartyTableColumn.USERNAME: ob.username,
          PartyTableColumn.VAT_NUMBER: ob.vATNumber,
          PartyTableColumn.email: ob.email,
          PartyTableColumn.DUE_BALANCE: ob.dueBalance
        },
        TableNames.PARTY_TABLE,
      );
    }
    return parties;
  }

  Future<Party> getPartyById(int id) async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.getPartyById(int.parse(id.toString()));
    return (Party.fromJson(data[0]));
  }

  Future updatePartyDue(String due) async {
    return await _service.updatePartyDue(
        due, Get.find<PartyController>().selectedParty.value.partyId as int);
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> user = GetStorage().read('loginUser');
    getParty("${user['EmployeeID']}").then((value) => fetchInitialData());
  }

  void decreaseDue(double? dueAmount, int? partyId) async {
    Map<String, dynamic> user = GetStorage().read('loginUser');

    Party party = await getPartyById(partyId as int);
    party.dueBalance =
        (double.parse(party.dueBalance.toString()) - dueAmount!).toString();
    print(party.dueBalance);
    await DatabaseHelper.instance.partyUpdate(party).then((value) =>
        Get.find<PartyController>().getParty("${user['EmployeeID']}"));
  }
}
