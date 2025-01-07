class ResponseData {
  String? tableName;
  String? operation;
  String? uuId;
  String? sqlInfoMessage;
  String? lastRowAffectedId;

  ResponseData(
      {this.tableName,
      this.operation,
      this.uuId,
      this.sqlInfoMessage,
      this.lastRowAffectedId});

  ResponseData.fromJson(Map<String, dynamic> json) {
    tableName = json['tableName'];
    operation = json['operation'];
    uuId = json['uuId'];
    sqlInfoMessage = json['sqlInfoMessage'];
    lastRowAffectedId = json['lastRowAffectedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableName'] = this.tableName;
    data['operation'] = this.operation;
    data['uuId'] = this.uuId;
    data['sqlInfoMessage'] = this.sqlInfoMessage;
    data['lastRowAffectedId'] = this.lastRowAffectedId;
    return data;
  }
}
