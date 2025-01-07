class VwCurrentStock {
  int? productCategoryID;
  num? productSubCategoryID;
  String? subCategoryName;
  int? productID;
  num? inValue;
  String? barcode;
  String? productName;
  String? arabicName;
  bool? isRetailUnit;
  int? retailUnitID;
  num? quantityPerUnit;
  String? retailUnit;
  num? baseQuantity;
  String? baseUnit;
  num? inQuantity;
  String? unit;
  int? unitID;
  num? vATPercentage;
  num? unitPrice;
  num? jEDSalePrice;
  num? kHMSalePrice;
  num? saleValue;
  num? salePrice;
  num? retailPrice;
  num? totalPurchaseValue;
  num? totalSalesValue;
  int? storeID;
  bool? isRetailStore;
  String? storeName;
  int? branchID;
  String? locationName;
  num? vATAmount;
  num? discountPercentage;
  num? discountAmount;
  num? netPrice;
  num? minimumSalePrice;

  VwCurrentStock(
      {this.productCategoryID,
      this.productSubCategoryID,
      this.subCategoryName,
      this.productID,
      this.inValue,
      this.barcode,
      this.productName,
      this.arabicName,
      this.isRetailUnit,
      this.retailUnitID,
      this.quantityPerUnit,
      this.retailUnit,
      this.baseQuantity,
      this.baseUnit,
      this.inQuantity,
      this.unit,
      this.unitID,
      this.vATPercentage,
      this.unitPrice,
      this.jEDSalePrice,
      this.kHMSalePrice,
      this.saleValue,
      this.salePrice,
      this.retailPrice,
      this.totalPurchaseValue,
      this.totalSalesValue,
      this.storeID,
      this.isRetailStore,
      this.storeName,
      this.branchID,
      this.locationName,
      this.vATAmount,
      this.discountPercentage,
      this.discountAmount,
      this.netPrice,
      this.minimumSalePrice});

  VwCurrentStock.fromJson(Map<String, dynamic> json) {
    productCategoryID = json['ProductCategoryID'];
    productSubCategoryID = json['ProductSubCategoryID'];
    subCategoryName = json['SubCategoryName'];
    productID = json['ProductID'];
    inValue = json['InValue'];
    barcode = json['Barcode'];
    productName = json['ProductName'];
    arabicName = json['ArabicName'];
    if (json['IsRetailUnit'] == 1) {
      isRetailUnit = true;
    } else if (json['IsRetailUnit'] == 0) {
      isRetailUnit = false;
    } else {
      isRetailUnit = json['IsRetailUnit'];
    }
    retailUnitID = json['RetailUnitID'];
    quantityPerUnit = json['QuantityPerUnit'];
    retailUnit = json['RetailUnit'];
    baseQuantity = json['BaseQuantity'];
    baseUnit = json['BaseUnit'];
    inQuantity = json['InQuantity'];
    unit = json['Unit'];
    unitID = json['UnitID'];
    vATPercentage = json['VATPercentage'];
    unitPrice = json['UnitPrice'];
    jEDSalePrice = json['JEDSalePrice'];
    kHMSalePrice = json['KHMSalePrice'];
    saleValue = json['SaleValue'];
    salePrice = json['SalePrice'];
    retailPrice = json['RetailPrice'];
    totalPurchaseValue = json['TotalPurchaseValue'];
    totalSalesValue = json['TotalSalesValue'];
    storeID = json['StoreID'];
    if (json['IsRetailStore'] == 1) {
      isRetailStore = true;
    } else if (json['IsRetailStore'] == 0) {
      isRetailStore = false;
    } else {
      isRetailStore = json['IsRetailStore'];
    }
    storeName = json['StoreName'];
    branchID = json['BranchID'];
    locationName = json['LocationName'];
    vATAmount = json['VATAmount'];
    discountPercentage = json['DiscountPercentage'];
    discountAmount = json['DiscountAmount'];
    netPrice = json['NetPrice'];
    minimumSalePrice = json['MinimumSalePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductCategoryID'] = this.productCategoryID;
    data['ProductSubCategoryID'] = this.productSubCategoryID;
    data['SubCategoryName'] = this.subCategoryName;
    data['ProductID'] = this.productID;
    data['InValue'] = this.inValue;
    data['Barcode'] = this.barcode;
    data['ProductName'] = this.productName;
    data['ArabicName'] = this.arabicName;
    data['IsRetailUnit'] = this.isRetailUnit;
    data['RetailUnitID'] = this.retailUnitID;
    data['QuantityPerUnit'] = this.quantityPerUnit;
    data['RetailUnit'] = this.retailUnit;
    data['BaseQuantity'] = this.baseQuantity;
    data['BaseUnit'] = this.baseUnit;
    data['InQuantity'] = this.inQuantity;
    data['Unit'] = this.unit;
    data['UnitID'] = this.unitID;
    data['VATPercentage'] = this.vATPercentage;
    data['UnitPrice'] = this.unitPrice;
    data['JEDSalePrice'] = this.jEDSalePrice;
    data['KHMSalePrice'] = this.kHMSalePrice;
    data['SaleValue'] = this.saleValue;
    data['SalePrice'] = this.salePrice;
    data['RetailPrice'] = this.retailPrice;
    data['TotalPurchaseValue'] = this.totalPurchaseValue;
    data['TotalSalesValue'] = this.totalSalesValue;
    data['StoreID'] = this.storeID;
    data['IsRetailStore'] = this.isRetailStore;
    data['StoreName'] = this.storeName;
    data['BranchID'] = this.branchID;
    data['LocationName'] = this.locationName;
    data['VATAmount'] = this.vATAmount;
    data['DiscountPercentage'] = this.discountPercentage;
    data['DiscountAmount'] = this.discountAmount;
    data['NetPrice'] = this.netPrice;
    data['MinimumSalePrice'] = this.minimumSalePrice;
    return data;
  }
}
