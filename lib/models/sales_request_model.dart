class SalesRequestModel {
  String? _statement;
  String? _tableName;
  String? _operation;
  String? _lastModifiedOn;
  String? _uuId;

  SalesRequestModel(
      {String? TableName,
      String? Statement,
      String? UuId,
      String? Operation,
      String? LastModifiedOn}) {
    if (TableName != null) {
      this._tableName = TableName;
    }
    if (Statement != null) {
      this._statement = Statement;
    }
    if (UuId != null) {
      this._uuId = UuId;
    }
    if (Operation != null) {
      this._operation = Operation;
    }
    if (LastModifiedOn != null) {
      this._lastModifiedOn = LastModifiedOn;
    }
  }

  String? get tableName => _tableName;
  set tableName(String? tableName) => _tableName = tableName;
  String? get statement => _statement;
  set statement(String? statement) => _statement = statement;
  String? get uuId => _uuId;
  set uuId(String? uuId) => _uuId = uuId;
  String? get operation => _operation;
  set operation(String? operation) => _operation = operation;
  String? get lastModifiedOn => _lastModifiedOn;
  set lastModifiedOn(String? lastModifiedOn) =>
      _lastModifiedOn = lastModifiedOn;

  SalesRequestModel.fromJson(Map<String, dynamic> json) {
    _tableName = json['TableName'];
    _statement = json['Statement'];
    _uuId = json['UuId'];
    _operation = json['Operation'];
    _lastModifiedOn = json['LastModifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TableName'] = this._tableName;
    data['Statement'] = this._statement;
    data['UuId'] = this._uuId;
    data['Operation'] = this._operation;
    data['LastModifiedOn'] = this._lastModifiedOn;
    return data;
  }
}
