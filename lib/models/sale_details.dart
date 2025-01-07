class SaleDetails {
  int? _salesDetailsId;
  int? _partyId;
  bool? _vATStatus;
  int? _warehouseId;
  int? _salesId;
  String? _salesInvoice;
  String? _mobileInvoice;
  int? _categoryID;
  int? _subCategoryID;
  int? _productId;
  String? _productName;
  int? _unitId;
  String? _units;
  num? _unitPriceIncludingVAT;
  num? _discountAmount;
  num? _vATRate;
  num? _vATAmount;
  num? _unitPriceExcludingVAT;
  num? _quantity;
  String? _quantityInWords;
  num? _itemSubtotalExcludingVAT;
  num? _itemSubtotalIncludingVAT;
  num? _calculateItemDiscount;
  num? _returnQuantity;
  bool? _deleted;
  String? _createdBy;
  String? _createdOn;
  String? _lastModifiedBy;
  String? _lastModifiedOn;
  String? _SRInvoice;

  SaleDetails(
      {int? salesDetailsId,
      String? productName,
      int? partyId,
      bool? vATStatus,
      int? warehouseId,
      int? salesId,
      String? salesInvoice,
      String? mobileInvoice,
      int? categoryID,
      int? subCategoryID,
      int? productId,
      int? unitId,
      String? units,
      num? unitPriceIncludingVAT,
      num? discountAmount,
      num? vATRate,
      num? vATAmount,
      num? unitPriceExcludingVAT,
      num? quantity,
      String? quantityInWords,
      num? itemSubtotalExcludingVAT,
      num? itemSubtotalIncludingVAT,
      num? calculateItemDiscount,
      num? returnQuantity,
      bool? deleted,
      String? createdBy,
      String? createdOn,
      String? lastModifiedBy,
      String? lastModifiedOn,
      String? SRInvoice}) {
    if (productName != String) {
      this._productName = productName;
    }

    if (salesDetailsId != int) {
      this._salesDetailsId = salesDetailsId;
    }

    if (partyId != int) {
      this._partyId = partyId;
    }
    if (vATStatus != num) {
      this._vATStatus = vATStatus;
    }
    if (warehouseId != int) {
      this._warehouseId = warehouseId;
    }
    if (salesId != int) {
      this._salesId = salesId;
    }
    if (salesInvoice != num) {
      this._salesInvoice = salesInvoice;
    }
    if (mobileInvoice != num) {
      this._mobileInvoice = mobileInvoice;
    }
    if (categoryID != int) {
      this._categoryID = categoryID;
    }
    if (subCategoryID != int) {
      this._subCategoryID = subCategoryID;
    }
    if (productId != int) {
      this._productId = productId;
    }
    if (unitId != int) {
      this._unitId = unitId;
    }
    if (units != num) {
      this._units = units;
    }
    if (unitPriceIncludingVAT != num) {
      this._unitPriceIncludingVAT = unitPriceIncludingVAT;
    }
    if (discountAmount != num) {
      this._discountAmount = discountAmount;
    }
    if (vATRate != num) {
      this._vATRate = vATRate;
    }
    if (vATAmount != num) {
      this._vATAmount = vATAmount;
    }
    if (unitPriceExcludingVAT != num) {
      this._unitPriceExcludingVAT = unitPriceExcludingVAT;
    }
    if (quantity != num) {
      this._quantity = quantity;
    }
    if (quantityInWords != num) {
      this._quantityInWords = quantityInWords;
    }
    if (itemSubtotalExcludingVAT != num) {
      this._itemSubtotalExcludingVAT = itemSubtotalExcludingVAT;
    }
    if (itemSubtotalIncludingVAT != num) {
      this._itemSubtotalIncludingVAT = itemSubtotalIncludingVAT;
    }
    if (calculateItemDiscount != num) {
      this._calculateItemDiscount = calculateItemDiscount;
    }
    if (returnQuantity != num) {
      this._returnQuantity = returnQuantity;
    }
    if (deleted != num) {
      this._deleted = deleted;
    }
    if (createdBy != num) {
      this._createdBy = createdBy;
    }
    if (createdOn != num) {
      this._createdOn = createdOn;
    }
    if (lastModifiedBy != String) {
      this._lastModifiedBy = lastModifiedBy;
    }
    if (lastModifiedOn != String) {
      this._lastModifiedOn = lastModifiedOn;
    }
    if (SRInvoice != String) {
      this._SRInvoice = SRInvoice;
    }
  }

  int? get salesDetailsId => _salesDetailsId;
  set salesDetailsId(int? salesDetailsId) => _salesDetailsId = salesDetailsId;
  String? get SRInvoice => _SRInvoice;
  set SRInvoice(String? SRInvoice) => _SRInvoice = SRInvoice;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get partyId => _partyId;
  set partyId(int? partyId) => _partyId = partyId;
  bool? get vATStatus => _vATStatus;
  set vATStatus(bool? vATStatus) => _vATStatus = vATStatus;
  int? get warehouseId => _warehouseId;
  set warehouseId(int? warehouseId) => _warehouseId = warehouseId;
  int? get salesId => _salesId;
  set salesId(int? salesId) => _salesId = salesId;
  String? get salesInvoice => _salesInvoice;
  set salesInvoice(String? salesInvoice) => _salesInvoice = salesInvoice;
  String? get mobileInvoice => _mobileInvoice;
  set mobileInvoice(String? mobileInvoice) => _mobileInvoice = mobileInvoice;
  int? get categoryID => _categoryID;
  set categoryID(int? categoryID) => _categoryID = categoryID;
  int? get subCategoryID => _subCategoryID;
  set subCategoryID(int? subCategoryID) => _subCategoryID = subCategoryID;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  int? get unitId => _unitId;
  set unitId(int? unitId) => _unitId = unitId;
  String? get units => _units;
  set units(String? units) => _units = units;
  num? get unitPriceIncludingVAT => _unitPriceIncludingVAT;
  set unitPriceIncludingVAT(num? unitPriceIncludingVAT) =>
      _unitPriceIncludingVAT = unitPriceIncludingVAT;
  num? get discountAmount => _discountAmount;
  set discountAmount(num? discountAmount) => _discountAmount = discountAmount;
  num? get vATRate => _vATRate;
  set vATRate(num? vATRate) => _vATRate = vATRate;
  num? get vATAmount => _vATAmount;
  set vATAmount(num? vATAmount) => _vATAmount = vATAmount;
  num? get unitPriceExcludingVAT => _unitPriceExcludingVAT;
  set unitPriceExcludingVAT(num? unitPriceExcludingVAT) =>
      _unitPriceExcludingVAT = unitPriceExcludingVAT;
  num? get quantity => _quantity;
  set quantity(num? quantity) => _quantity = quantity;
  String? get quantityInWords => _quantityInWords;
  set quantityInWords(String? quantityInWords) =>
      _quantityInWords = quantityInWords;
  num? get itemSubtotalExcludingVAT => _itemSubtotalExcludingVAT;
  set itemSubtotalExcludingVAT(num? itemSubtotalExcludingVAT) =>
      _itemSubtotalExcludingVAT = itemSubtotalExcludingVAT;
  num? get itemSubtotalIncludingVAT => _itemSubtotalIncludingVAT;
  set itemSubtotalIncludingVAT(num? itemSubtotalIncludingVAT) =>
      _itemSubtotalIncludingVAT = itemSubtotalIncludingVAT;
  num? get calculateItemDiscount => _calculateItemDiscount;
  set calculateItemDiscount(num? calculateItemDiscount) =>
      _calculateItemDiscount = calculateItemDiscount;
  num? get returnQuantity => _returnQuantity;
  set returnQuantity(num? returnQuantity) => _returnQuantity = returnQuantity;
  bool? get deleted => _deleted;
  set deleted(bool? deleted) => _deleted = deleted;
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

  SaleDetails.fromJson(Map<String, dynamic> json) {
    _productName = json['ProductName'];
    _salesDetailsId = json['SalesDetailsId'];
    _partyId = json['PartyId'];
    if (json['VATStatus'] == 1) {
      _vATStatus = true;
    } else if (json['VATStatus'] == 0) {
      _vATStatus = false;
    } else {
      _vATStatus = json['VATStatus'];
    }
    _warehouseId = json['WarehouseId'];
    _salesId = json['SalesId'];
    _salesInvoice = json['SalesInvoice'];
    _mobileInvoice = json['MobileInvoice'];
    _categoryID = json['CategoryID'];
    _subCategoryID = json['SubCategoryID'];
    _productId = json['ProductId'];
    _unitId = json['UnitId'];
    _units = json['Units'];
    _unitPriceIncludingVAT = json['UnitPriceIncludingVAT'];
    _discountAmount = json['DiscountAmount'];
    _vATRate = json['VATRate'];
    _vATAmount = json['VATAmount'];
    _unitPriceExcludingVAT = json['UnitPriceExcludingVAT'];
    _quantity = json['Quantity'];
    _quantityInWords = json['QuantityInWords'];
    _itemSubtotalExcludingVAT = json['ItemSubtotalExcludingVAT'];
    _itemSubtotalIncludingVAT = json['ItemSubtotalIncludingVAT'];
    _calculateItemDiscount = json['CalculateItemDiscount'];
    _returnQuantity = json['ReturnQuantity'];
    if (json['Deleted'] == 1) {
      _deleted = true;
    } else if (json['Deleted'] == 0) {
      _deleted = false;
    } else {
      _deleted = json['Deleted'];
    }
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _lastModifiedBy = json['LastModifiedBy'];
    _lastModifiedOn = json['LastModifiedOn'];
    _SRInvoice = json['SRInvoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductName'] = this._productName;
    data['SalesDetailsId'] = this._salesDetailsId;
    data['PartyId'] = this._partyId;
    data['VATStatus'] = this._vATStatus;
    data['WarehouseId'] = this._warehouseId;
    data['SalesId'] = this._salesId;
    data['SalesInvoice'] = this._salesInvoice;
    data['MobileInvoice'] = this._mobileInvoice;
    data['CategoryID'] = this._categoryID;
    data['SubCategoryID'] = this._subCategoryID;
    data['ProductId'] = this._productId;
    data['UnitId'] = this._unitId;
    data['Units'] = this._units;
    data['UnitPriceIncludingVAT'] = this._unitPriceIncludingVAT;
    data['DiscountAmount'] = this._discountAmount;
    data['VATRate'] = this._vATRate;
    data['VATAmount'] = this._vATAmount;
    data['UnitPriceExcludingVAT'] = this._unitPriceExcludingVAT;
    data['Quantity'] = this._quantity;
    data['QuantityInWords'] = this._quantityInWords;
    data['ItemSubtotalExcludingVAT'] = this._itemSubtotalExcludingVAT;
    data['ItemSubtotalIncludingVAT'] = this._itemSubtotalIncludingVAT;
    data['CalculateItemDiscount'] = this._calculateItemDiscount;
    data['ReturnQuantity'] = this._returnQuantity;
    data['Deleted'] = this._deleted;
    data['CreatedBy'] = this._createdBy;
    data['CreatedOn'] = this._createdOn;
    data['LastModifiedBy'] = this._lastModifiedBy;
    data['LastModifiedOn'] = this._lastModifiedOn;
    data['SRInvoice'] = this._SRInvoice;

    return data;
  }
}
