class Store {
  int? _id;
  int? _storeAssignID;
  bool? _isRetailStore;
  int? _storeID;
  String? _name;
  String? _description;
  int? _locationID;
  int? _centerID;
  int? _departmentSectionID;
  int? _officeID;
  String? _storeType;

  Store(
      {int? id,
      int? storeAssignID,
      bool? isRetailStore,
      int? storeID,
      String? name,
      String? description,
      int? locationID,
      int? centerID,
      int? departmentSectionID,
      int? officeID,
      String? storeType}) {
    if (id != null) {
      this._id = id;
    }
    if (storeAssignID != null) {
      this._storeAssignID = storeAssignID;
    }
    if (isRetailStore != null) {
      this._isRetailStore = isRetailStore;
    }
    if (storeID != null) {
      this._storeID = storeID;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (locationID != null) {
      this._locationID = locationID;
    }
    if (centerID != null) {
      this._centerID = centerID;
    }
    if (departmentSectionID != null) {
      this._departmentSectionID = departmentSectionID;
    }
    if (officeID != null) {
      this._officeID = officeID;
    }
    if (storeType != null) {
      this._storeType = storeType;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get storeAssignID => _storeAssignID;
  set storeAssignID(int? storeAssignID) => _storeAssignID = storeAssignID;
  bool? get isRetailStore => _isRetailStore;
  set isRetailStore(bool? isRetailStore) => _isRetailStore = isRetailStore;
  int? get storeID => _storeID;
  set storeID(int? storeID) => _storeID = storeID;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get locationID => _locationID;
  set locationID(int? locationID) => _locationID = locationID;
  int? get centerID => _centerID;
  set centerID(int? centerID) => _centerID = centerID;
  int? get departmentSectionID => _departmentSectionID;
  set departmentSectionID(int? departmentSectionID) =>
      _departmentSectionID = departmentSectionID;
  int? get officeID => _officeID;
  set officeID(int? officeID) => _officeID = officeID;
  String? get storeType => _storeType;
  set storeType(String? storeType) => _storeType = storeType;

  Store.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _storeAssignID = json['StoreAssignID'];
    if (json['IsRetailStore'] == 1) {
      _isRetailStore = true;
    } else if (json['IsRetailStore'] == 0) {
      _isRetailStore = false;
    } else {
      _isRetailStore = json['IsRetailStore'];
    }
    _storeID = json['StoreID'];
    _name = json['Name'];
    _description = json['Description'];
    _locationID = json['LocationID'];
    _centerID = json['CenterID'];
    _departmentSectionID = json['DepartmentSectionID'];
    _officeID = json['OfficeID'];
    _storeType = json['StoreType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['StoreAssignID'] = this._storeAssignID;
    data['IsRetailStore'] = this._isRetailStore;
    data['StoreID'] = this._storeID;
    data['Name'] = this._name;
    data['Description'] = this._description;
    data['LocationID'] = this._locationID;
    data['CenterID'] = this._centerID;
    data['DepartmentSectionID'] = this._departmentSectionID;
    data['OfficeID'] = this._officeID;
    data['StoreType'] = this._storeType;
    return data;
  }
}
