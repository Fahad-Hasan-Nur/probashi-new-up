class User {
  String? _userId;
  String? _password;
  String? _email;
  int? _employeeID;
  String? _empId;
  String? _employeeName;
  int? _locationID;
  String? _locationName;
  int? _centerID;
  String? _roleName;
  String? _shortCode;
  int? _storeID;
  int? _areaLocationID;
  String? _storeName;

  User({
    String? userId,
    String? password,
    String? email,
    int? employeeID,
    String? empId,
    String? employeeName,
    int? locationID,
    String? locationName,
    int? centerID,
    String? roleName,
    String? shortCode,
    int? storeID,
    String? storeName,
    int? areaLocationID,
  }) {
    if (_storeName != null) {
      this._storeName = storeName;
    }
    if (_shortCode != null) {
      this._shortCode = shortCode;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (password != null) {
      this._password = password;
    }
    if (email != null) {
      this._email = email;
    }
    if (employeeID != null) {
      this._employeeID = employeeID;
    }
    if (empId != null) {
      this._empId = empId;
    }
    if (employeeName != null) {
      this._employeeName = employeeName;
    }
    if (locationID != null) {
      this._locationID = locationID;
    }
    if (locationName != null) {
      this._locationName = locationName;
    }
    if (centerID != null) {
      this._centerID = centerID;
    }
    if (roleName != null) {
      this._roleName = roleName;
    }
    if (roleName != null) {
      this._storeID = storeID;
    }
    if (areaLocationID != null) {
      this._areaLocationID = areaLocationID;
    }
  }
  String? get storeName => _storeName;
  set storeName(String? storeName) => _storeName = storeName;
  int? get areaLocationID => _areaLocationID;
  set areaLocationID(int? areaLocationID) => _areaLocationID = areaLocationID;
  int? get storeID => _storeID;
  set storeID(int? storeID) => _storeID = storeID;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get shortCode => _shortCode;
  set shortCode(String? shortCode) => _shortCode = shortCode;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get email => _email;
  set email(String? email) => _email = email;
  int? get employeeID => _employeeID;
  set employeeID(int? employeeID) => _employeeID = employeeID;
  String? get empId => _empId;
  set empId(String? empId) => _empId = empId;
  String? get employeeName => _employeeName;
  set employeeName(String? employeeName) => _employeeName = employeeName;
  int? get locationID => _locationID;
  set locationID(int? locationID) => _locationID = locationID;
  String? get locationName => _locationName;
  set locationName(String? locationName) => _locationName = locationName;
  int? get centerID => _centerID;
  set centerID(int? centerID) => _centerID = centerID;
  String? get roleName => _roleName;
  set roleName(String? roleName) => _roleName = roleName;

  User.fromJson(Map<String, dynamic> json) {
    _storeName = json['StoreName'];
    _userId = json['UserId'];
    _password = json['Password'];
    _email = json['Email'];
    _employeeID = json['EmployeeID'];
    _empId = json['EmpId'];
    _employeeName = json['EmployeeName'];
    _locationID = json['LocationID'];
    _locationName = json['LocationName'];
    _centerID = json['CenterID'];
    _roleName = json['RoleName'];
    _shortCode = json['ShortCode'];
    _storeID = json['StoreID'];
    _areaLocationID = json['AreaLocationID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StoreName'] = this._storeName;
    data['UserId'] = this._userId;
    data['Password'] = this._password;
    data['Email'] = this._email;
    data['EmployeeID'] = this._employeeID;
    data['EmpId'] = this._empId;
    data['EmployeeName'] = this._employeeName;
    data['LocationID'] = this._locationID;
    data['LocationName'] = this._locationName;
    data['CenterID'] = this._centerID;
    data['RoleName'] = this._roleName;
    data['ShortCode'] = this._shortCode;
    data['ShortCode'] = this._shortCode;
    data['StoreID'] = this._storeID;
    data['AreaLocationID'] = this._areaLocationID;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "StoreName": this._storeName,
      'UserId': this._userId,
      'Password': this._password,
      'Email': this._email,
      'EmployeeID': this._employeeID,
      'EmpId': this._empId,
      'EmployeeName': this._employeeName,
      'LocationID': this._locationID,
      'LocationName': this._locationName,
      'CenterID': _centerID,
      'RoleName': _roleName,
      'ShortCode': _shortCode,
      'StoreID': _storeID,
      'AreaLocationID': _areaLocationID,
    };
  }
}
