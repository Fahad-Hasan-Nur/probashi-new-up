class Party {
  String? dueBalance;
  int? _partyId;
  String? _username;
  String? _email;
  String? _contactPerson;
  String? _contactNumber;
  bool? _isTaxExempt;
  String? _buildingNumber;
  String? _streetName;
  String? _districtName;
  String? _cityName;
  String? _country;
  String? _postalCode;
  String? _additionalNumber;
  String? _vATNumber;
  String? _tINNumber;
  int? _locationId;
  int? _areaId;
  int? _storeAssignId;
  int? _partyRoleId;
  bool? _active;
  bool? _dr;
  bool? _cr;
  String? _address;
  String? _openingBalanceDate;
  num? _openingBalance;
  String? _description;
  bool? _isSupervisor;
  String? _createdBy;
  String? _createdOn;
  String? _lastModifiedBy;
  String? _lastModifiedOn;

  Party(
      {String? dueBalance,
      int? partyId,
      String? username,
      String? email,
      String? contactPerson,
      String? contactNumber,
      bool? isTaxExempt,
      String? buildingNumber,
      String? streetName,
      String? districtName,
      String? cityName,
      String? country,
      String? postalCode,
      String? additionalNumber,
      String? vATNumber,
      String? tINNumber,
      int? locationId,
      int? areaId,
      int? storeAssignId,
      int? partyRoleId,
      bool? active,
      bool? dr,
      bool? cr,
      String? address,
      String? openingBalanceDate,
      num? openingBalance,
      String? description,
      bool? isSupervisor,
      String? createdBy,
      String? createdOn,
      String? lastModifiedBy,
      String? lastModifiedOn}) {
    // if (dueBalance != String) {
    //   this._dueBalance = dueBalance;
    // }
    if (partyId != int) {
      this._partyId = partyId;
    }
    if (username != String) {
      this._username = username;
    }
    if (email != String) {
      this._email = email;
    }
    if (contactPerson != String) {
      this._contactPerson = contactPerson;
    }
    if (contactNumber != String) {
      this._contactNumber = contactNumber;
    }
    if (isTaxExempt != String) {
      this._isTaxExempt = isTaxExempt;
    }
    if (buildingNumber != String) {
      this._buildingNumber = buildingNumber;
    }
    if (streetName != String) {
      this._streetName = streetName;
    }
    if (districtName != String) {
      this._districtName = districtName;
    }
    if (cityName != String) {
      this._cityName = cityName;
    }
    if (country != String) {
      this._country = country;
    }
    if (postalCode != String) {
      this._postalCode = postalCode;
    }
    if (additionalNumber != String) {
      this._additionalNumber = additionalNumber;
    }
    if (vATNumber != String) {
      this._vATNumber = vATNumber;
    }
    if (tINNumber != String) {
      this._tINNumber = tINNumber;
    }
    if (locationId != int) {
      this._locationId = locationId;
    }
    if (areaId != int) {
      this._areaId = areaId;
    }
    if (storeAssignId != String) {
      this._storeAssignId = storeAssignId;
    }
    if (partyRoleId != String) {
      this._partyRoleId = partyRoleId;
    }
    if (active != String) {
      this._active = active;
    }
    if (dr != String) {
      this._dr = dr;
    }
    if (cr != String) {
      this._cr = cr;
    }
    if (address != String) {
      this._address = address;
    }
    if (openingBalanceDate != String) {
      this._openingBalanceDate = openingBalanceDate;
    }
    if (openingBalance != String) {
      this._openingBalance = openingBalance;
    }
    if (description != String) {
      this._description = description;
    }
    if (isSupervisor != String) {
      this._isSupervisor = isSupervisor;
    }
    if (createdBy != String) {
      this._createdBy = createdBy;
    }
    if (createdOn != String) {
      this._createdOn = createdOn;
    }
    if (lastModifiedBy != String) {
      this._lastModifiedBy = lastModifiedBy;
    }
    if (lastModifiedOn != String) {
      this._lastModifiedOn = lastModifiedOn;
    }
  }
  // String? get dueBalance => _dueBalance;
  // set dueBalance(String? _dueBalance) => _dueBalance = dueBalance;
  int? get partyId => _partyId;
  set partyId(int? partyId) => _partyId = partyId;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get contactPerson => _contactPerson;
  set contactPerson(String? contactPerson) => _contactPerson = contactPerson;
  String? get contactNumber => _contactNumber;
  set contactNumber(String? contactNumber) => _contactNumber = contactNumber;
  bool? get isTaxExempt => _isTaxExempt;
  set isTaxExempt(bool? isTaxExempt) => _isTaxExempt = isTaxExempt;
  String? get buildingNumber => _buildingNumber;
  set buildingNumber(String? buildingNumber) =>
      _buildingNumber = buildingNumber;
  String? get streetName => _streetName;
  set streetName(String? streetName) => _streetName = streetName;
  String? get districtName => _districtName;
  set districtName(String? districtName) => _districtName = districtName;
  String? get cityName => _cityName;
  set cityName(String? cityName) => _cityName = cityName;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get postalCode => _postalCode;
  set postalCode(String? postalCode) => _postalCode = postalCode;
  String? get additionalNumber => _additionalNumber;
  set additionalNumber(String? additionalNumber) =>
      _additionalNumber = additionalNumber;
  String? get vATNumber => _vATNumber;
  set vATNumber(String? vATNumber) => _vATNumber = vATNumber;
  String? get tINNumber => _tINNumber;
  set tINNumber(String? tINNumber) => _tINNumber = tINNumber;
  int? get locationId => _locationId;
  set locationId(int? locationId) => _locationId = locationId;
  int? get areaId => _areaId;
  set areaId(int? areaId) => _areaId = areaId;
  int? get storeAssignId => _storeAssignId;
  set storeAssignId(int? storeAssignId) => _storeAssignId = storeAssignId;
  int? get partyRoleId => _partyRoleId;
  set partyRoleId(int? partyRoleId) => _partyRoleId = partyRoleId;
  bool? get active => _active;
  set active(bool? active) => _active = active;
  bool? get dr => _dr;
  set dr(bool? dr) => _dr = dr;
  bool? get cr => _cr;
  set cr(bool? cr) => _cr = cr;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get openingBalanceDate => _openingBalanceDate;
  set openingBalanceDate(String? openingBalanceDate) =>
      _openingBalanceDate = openingBalanceDate;
  num? get openingBalance => _openingBalance;
  set openingBalance(num? openingBalance) => _openingBalance = openingBalance;
  String? get description => _description;
  set description(String? description) => _description = description;
  bool? get isSupervisor => _isSupervisor;
  set isSupervisor(bool? isSupervisor) => _isSupervisor = isSupervisor;
  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;
  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;
  String? get lastModifiedBy => _lastModifiedBy;
  set lastModifiedBy(String? lastModifiedBy) =>
      _lastModifiedBy = lastModifiedBy;
  String? get lastModifiedOn => _lastModifiedOn;
  set lastModifiedOn(String? lastModifiedOn) =>
      _lastModifiedOn = lastModifiedOn;

  Party.fromJson(Map<String, dynamic> json) {
    _partyId = json['PartyId'];
    _username = json['Username'];
    _email = json['Email'];
    _contactPerson = json['ContactPerson'];
    _contactNumber = json['ContactNumber'];
    _isTaxExempt = json['IsTaxExempt'];
    _buildingNumber = json['BuildingNumber'];
    _streetName = json['StreetName'];
    _districtName = json['DistrictName'];
    _cityName = json['CityName'];
    _country = json['Country'];
    _postalCode = json['PostalCode'];
    _additionalNumber = json['AdditionalNumber'];
    _vATNumber = json['VATNumber'];
    _tINNumber = json['TINNumber'];
    _locationId = json['LocationId'];
    _areaId = json['AreaId'];
    _storeAssignId = json['StoreAssignId'];
    _partyRoleId = json['PartyRoleId'];
    _active = json['Active'];
    _dr = json['Dr'];
    _cr = json['Cr'];
    _address = json['Address'];
    _openingBalanceDate = json['OpeningBalanceDate'];
    _openingBalance = json['OpeningBalance'];
    _description = json['Description'];
    _isSupervisor = json['IsSupervisor'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _lastModifiedBy = json['LastModifiedBy'];
    _lastModifiedOn = json['LastModifiedOn'];
    dueBalance = json['DueBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PartyId'] = this._partyId;
    data['Username'] = this._username;
    data['Email'] = this._email;
    data['ContactPerson'] = this._contactPerson;
    data['ContactNumber'] = this._contactNumber;
    data['IsTaxExempt'] = this._isTaxExempt;
    data['BuildingNumber'] = this._buildingNumber;
    data['StreetName'] = this._streetName;
    data['DistrictName'] = this._districtName;
    data['CityName'] = this._cityName;
    data['Country'] = this._country;
    data['PostalCode'] = this._postalCode;
    data['AdditionalNumber'] = this._additionalNumber;
    data['VATNumber'] = this._vATNumber;
    data['TINNumber'] = this._tINNumber;
    data['LocationId'] = this._locationId;
    data['AreaId'] = this._areaId;
    data['StoreAssignId'] = this._storeAssignId;
    data['PartyRoleId'] = this._partyRoleId;
    data['Active'] = this._active;
    data['Dr'] = this._dr;
    data['Cr'] = this._cr;
    data['Address'] = this._address;
    data['OpeningBalanceDate'] = this._openingBalanceDate;
    data['OpeningBalance'] = this._openingBalance;
    data['Description'] = this._description;
    data['IsSupervisor'] = this._isSupervisor;
    data['CreatedBy'] = this._createdBy;
    data['CreatedOn'] = this._createdOn;
    data['LastModifiedBy'] = this._lastModifiedBy;
    data['LastModifiedOn'] = this._lastModifiedOn;
    data['DueBalance'] = this.dueBalance;
    return data;
  }
}
