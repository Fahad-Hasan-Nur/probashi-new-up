class Sales {
  int? _salesId;
  int? _partyId;
  String? _salesDate;
  String? _salesInvoice;
  String? _mobileInvoice;
  num? _totalExcludingVAT;
  bool? _usePercentage;
  num? _discountPercentage;
  num? _discountAmount;
  bool? _vATStatus;
  num? _vATAmount;
  num? _totalIncludingVAT;
  String? _amountInWords;
  num? _paidAmount;
  num? _badDebt;
  num? _dueAmount;
  String? _payStatus;
  String? _paymentNote;
  int? _branchId;
  int? _sRId;
  num? _warehouseId;
  bool? _active;
  bool? _deleted;
  String? _submitDate;
  String? _saveMode;
  String? _documentUrl;
  int? _companyID;
  String? _createdBy;
  String? _createdOn;
  String? _lastModifiedBy;
  String? _lastModifiedOn;
  String? _SRInvoice;
  String? _sync;
  String? _draft;

  Sales(
      {int? salesId,
      int? partyId,
      String? salesDate,
      String? salesInvoice,
      String? mobileInvoice,
      num? totalExcludingVAT,
      bool? usePercentage,
      num? discountPercentage,
      num? discountAmount,
      bool? vATStatus,
      num? vATAmount,
      num? totalIncludingVAT,
      String? amountInWords,
      num? paidAmount,
      num? badDebt,
      num? dueAmount,
      String? payStatus,
      String? paymentNote,
      int? branchId,
      int? sRId,
      int? warehouseId,
      bool? active,
      bool? deleted,
      String? submitDate,
      String? saveMode,
      String? documentUrl,
      int? companyID,
      String? createdBy,
      String? createdOn,
      String? lastModifiedBy,
      String? lastModifiedOn,
      String? SRInvoice,
      String? sync,
      String? draft}) {
    if (salesId != null) {
      this._salesId = salesId;
    }
    if (partyId != null) {
      this._partyId = partyId;
    }
    if (salesDate != null) {
      this._salesDate = salesDate;
    }
    if (salesInvoice != null) {
      this._salesInvoice = salesInvoice;
    }
    if (mobileInvoice != null) {
      this._mobileInvoice = mobileInvoice;
    }
    if (totalExcludingVAT != null) {
      this._totalExcludingVAT = totalExcludingVAT;
    }
    if (usePercentage != null) {
      this._usePercentage = usePercentage;
    }
    if (discountPercentage != null) {
      this._discountPercentage = discountPercentage;
    }
    if (discountAmount != null) {
      this._discountAmount = discountAmount;
    }
    if (vATStatus != null) {
      this._vATStatus = vATStatus;
    }
    if (vATAmount != null) {
      this._vATAmount = vATAmount;
    }
    if (totalIncludingVAT != null) {
      this._totalIncludingVAT = totalIncludingVAT;
    }
    if (amountInWords != null) {
      this._amountInWords = amountInWords;
    }
    if (paidAmount != null) {
      this._paidAmount = paidAmount;
    }
    if (badDebt != null) {
      this._badDebt = badDebt;
    }
    if (dueAmount != null) {
      this._dueAmount = dueAmount;
    }
    if (payStatus != null) {
      this._payStatus = payStatus;
    }
    if (paymentNote != null) {
      this._paymentNote = paymentNote;
    }
    if (branchId != null) {
      this._branchId = branchId;
    }
    if (sRId != null) {
      this._sRId = sRId;
    }
    if (warehouseId != null) {
      this._warehouseId = warehouseId;
    }
    if (active != null) {
      this._active = active;
    }
    if (deleted != null) {
      this._deleted = deleted;
    }
    if (submitDate != null) {
      this._submitDate = submitDate;
    }
    if (saveMode != null) {
      this._saveMode = saveMode;
    }
    if (documentUrl != null) {
      this._documentUrl = documentUrl;
    }
    if (companyID != null) {
      this._companyID = companyID;
    }
    if (createdBy != null) {
      this._createdBy = createdBy;
    }
    if (createdOn != null) {
      this._createdOn = createdOn;
    }
    if (lastModifiedBy != null) {
      this._lastModifiedBy = lastModifiedBy;
    }
    if (lastModifiedOn != null) {
      this._lastModifiedOn = lastModifiedOn;
    }
    if (SRInvoice != null) {
      this._SRInvoice = SRInvoice;
    }
    if (sync != null) {
      this._sync = sync;
    }
    if (draft != null) {
      this._draft = draft;
    }
  }
  String? get SRInvoice => _SRInvoice;
  set SRInvoice(String? SRInvoice) => _SRInvoice = SRInvoice;
  int? get salesId => _salesId;
  set salesId(int? salesId) => _salesId = salesId;
  int? get partyId => _partyId;
  set partyId(int? partyId) => _partyId = partyId;
  String? get salesDate => _salesDate;
  set salesDate(String? salesDate) => _salesDate = salesDate;
  String? get salesInvoice => _salesInvoice;
  set salesInvoice(String? salesInvoice) => _salesInvoice = salesInvoice;
  String? get mobileInvoice => _mobileInvoice;
  set mobileInvoice(String? mobileInvoice) => _mobileInvoice = mobileInvoice;
  num? get totalExcludingVAT => _totalExcludingVAT;
  set totalExcludingVAT(num? totalExcludingVAT) =>
      _totalExcludingVAT = totalExcludingVAT;
  bool? get usePercentage => _usePercentage;
  set usePercentage(bool? usePercentage) => _usePercentage = usePercentage;
  num? get discountPercentage => _discountPercentage;
  set discountPercentage(num? discountPercentage) =>
      _discountPercentage = discountPercentage;
  num? get discountAmount => _discountAmount;
  set discountAmount(num? discountAmount) => _discountAmount = discountAmount;
  bool? get vATStatus => _vATStatus;
  set vATStatus(bool? vATStatus) => _vATStatus = vATStatus;
  num? get vATAmount => _vATAmount;
  set vATAmount(num? vATAmount) => _vATAmount = vATAmount;
  num? get totalIncludingVAT => _totalIncludingVAT;
  set totalIncludingVAT(num? totalIncludingVAT) =>
      _totalIncludingVAT = totalIncludingVAT;
  String? get amountInWords => _amountInWords;
  set amountInWords(String? amountInWords) => _amountInWords = amountInWords;
  num? get paidAmount => _paidAmount;
  set paidAmount(num? paidAmount) => _paidAmount = paidAmount;
  num? get badDebt => _badDebt;
  set badDebt(num? badDebt) => _badDebt = badDebt;
  num? get dueAmount => _dueAmount;
  set dueAmount(num? dueAmount) => _dueAmount = dueAmount;
  String? get payStatus => _payStatus;
  set payStatus(String? payStatus) => _payStatus = payStatus;
  String? get paymentNote => _paymentNote;
  set paymentNote(String? paymentNote) => _paymentNote = paymentNote;
  int? get branchId => _branchId;
  set branchId(int? branchId) => _branchId = branchId;
  int? get sRId => _sRId;
  set sRId(int? sRId) => _sRId = sRId;
  num? get warehouseId => _warehouseId;
  set warehouseId(num? warehouseId) => _warehouseId = warehouseId;
  bool? get active => _active;
  set active(bool? active) => _active = active;
  bool? get deleted => _deleted;
  set deleted(bool? deleted) => _deleted = deleted;
  String? get submitDate => _submitDate;
  set submitDate(String? submitDate) => _submitDate = submitDate;
  String? get saveMode => _saveMode;
  set saveMode(String? saveMode) => _saveMode = saveMode;
  String? get documentUrl => _documentUrl;
  set documentUrl(String? documentUrl) => _documentUrl = documentUrl;
  int? get companyID => _companyID;
  set companyID(int? companyID) => _companyID = companyID;
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
  String? get sync => _sync;
  set sync(String? sync) => _sync = sync;
  String? get draft => _draft;
  set draft(String? draft) => _draft = draft;

  Sales.fromJson(Map<String, dynamic> json) {
    _salesId = json['SalesId'];
    _partyId = json['PartyId'];
    _salesDate = json['SalesDate'];
    _salesInvoice = json['SalesInvoice'];
    _mobileInvoice = json['MobileInvoice'];
    _totalExcludingVAT = json['TotalExcludingVAT'];
    if (json['UsePercentage'] == 1) {
      _usePercentage = true;
    } else if (json['UsePercentage'] == 0) {
      _usePercentage = false;
    } else {
      _usePercentage = json['UsePercentage'];
    }
    _discountPercentage = json['DiscountPercentage'];
    _discountAmount = json['DiscountAmount'];
    if (json['VATStatus'] == 1) {
      _vATStatus = true;
    } else if (json['VATStatus'] == 0) {
      _vATStatus = false;
    } else {
      _vATStatus = json['VATStatus'];
    }
    _vATAmount = json['VATAmount'];
    _totalIncludingVAT = json['TotalIncludingVAT'];
    _amountInWords = json['AmountInWords'];
    _paidAmount = json['PaidAmount'];
    _badDebt = json['BadDebt'];
    _dueAmount = json['DueAmount'];
    _payStatus = json['PayStatus'];
    _paymentNote = json['PaymentNote'];
    _branchId = json['BranchId'];
    _sRId = json['SRId'];
    _warehouseId = json['WarehouseId'];
    if (json['Active'] == 1) {
      _active = true;
    } else if (json['Active'] == 0) {
      _active = false;
    } else {
      _active = json['Active'];
    }
    if (json['Deleted'] == 1) {
      _deleted = true;
    } else if (json['Deleted'] == 0) {
      _deleted = false;
    } else {
      _deleted = json['Deleted'];
    }
    _submitDate = json['SubmitDate'];
    _saveMode = json['SaveMode'];
    _documentUrl = json['DocumentUrl'];
    _companyID = json['CompanyID'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _lastModifiedBy = json['LastModifiedBy'];
    _lastModifiedOn = json['LastModifiedOn'];
    _SRInvoice = json['SRInvoice'];
    _sync = json['Sync'];
    _draft = json['Draft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalesId'] = this._salesId;
    data['PartyId'] = this._partyId;
    data['SalesDate'] = this._salesDate;
    data['SalesInvoice'] = this._salesInvoice;
    data['MobileInvoice'] = this._mobileInvoice;
    data['TotalExcludingVAT'] = this._totalExcludingVAT;
    data['UsePercentage'] = this._usePercentage;
    data['DiscountPercentage'] = this._discountPercentage;
    data['DiscountAmount'] = this._discountAmount;
    data['VATStatus'] = this._vATStatus;
    data['VATAmount'] = this._vATAmount;
    data['TotalIncludingVAT'] = this._totalIncludingVAT;
    data['AmountInWords'] = this._amountInWords;
    data['PaidAmount'] = this._paidAmount;
    data['BadDebt'] = this._badDebt;
    data['DueAmount'] = this._dueAmount;
    data['PayStatus'] = this._payStatus;
    data['PaymentNote'] = this._paymentNote;
    data['BranchId'] = this._branchId;
    data['SRId'] = this._sRId;
    data['WarehouseId'] = this._warehouseId;
    data['Active'] = this._active;
    data['Deleted'] = this._deleted;
    data['SubmitDate'] = this._submitDate;
    data['SaveMode'] = this._saveMode;
    data['DocumentUrl'] = this._documentUrl;
    data['CompanyID'] = this._companyID;
    data['CreatedBy'] = this._createdBy;
    data['CreatedOn'] = this._createdOn;
    data['LastModifiedBy'] = this._lastModifiedBy;
    data['LastModifiedOn'] = this._lastModifiedOn;
    data['SRInvoice'] = this._SRInvoice;
    data['sync'] = this._sync;
    data['Draft'] = this._draft;
    return data;
  }
}
