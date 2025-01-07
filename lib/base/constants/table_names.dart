class TableNames {
  static const CURRENT_STOCK_TABLE = 'curent_stock';
  static const PARTY_TABLE = 'party';
  static const SALE_DETAILS_TABLE = 'sale_details';
  static const SALES_TABLE = 'sales';
  static const STORE_TABLE = 'store';
  static const USER_TABLE = 'user';
}

class CurrentStockTableColumn {
  static const PRODUCT_CATEGORY_ID = 'ProductCategoryID';
  static const PRODUCT_SUB_CATEGORYID = 'ProductSubCategoryID';
  static const SUB_CATEGORY_NAME = 'SubCategoryName';
  static const PRODUCT_ID = 'ProductID';
  static const IN_VALUE = 'InValue';
  static const BARCODE = 'Barcode';
  static const PRODUCT_NAME = 'ProductName';
  static const ARABIC_NAME = 'ArabicName';
  static const IS_RETAIL_UNIT = 'IsRetailUnit';
  static const RETAIL_UNIT_ID = 'RetailUnitID';
  static const QUANTITY_PER_UNIT = 'QuantityPerUnit';
  static const RETAIL_UNIT = 'RetailUnit';
  static const BASE_QUANTITY = 'BaseQuantity';
  static const BASE_UNIT = 'BaseUnit';
  static const IN_QUANTITY = 'InQuantity';
  static const UNIT = 'Unit';
  static const UNIT_ID = 'UnitID';
  static const VAT_PERCENTAGE = 'VATPercentage';
  static const UNIT_PRICE = 'UnitPrice';
  static const JED_SALE_PRICE = 'JEDSalePrice';
  static const KHM_SALE_PRICE = 'KHMSalePrice';
  static const SALE_VALUE = 'SaleValue';
  static const SALE_PRICE = 'SalePrice';
  static const RETAIL_PRICE = 'RetailPrice';
  static const TOTAL_PURCHASE_VALUE = 'TotalPurchaseValue';
  static const TOTAL_SALES_VALUE = 'TotalSalesValue';
  static const STORE_ID = 'StoreID';
  static const IS_RETAIL_STORE = 'IsRetailStore';
  static const STORE_NAME = 'StoreName';
  static const BRANCH_ID = 'BranchID';
  static const LOCATION_NAME = 'LocationName';
  static const VAT_AMOUNT = 'VATAmount';
  static const DISCOUNT_PERCENTAGE = 'DiscountPercentage';
  static const DISCOUNT_AMOUNT = 'DiscountAmount';
  static const NET_PRICE = 'NetPrice';
  static const MINIMUM_SALE_PRICE = 'MinimumSalePrice';
}

class UserTableColumn {
  static const USER_ID = 'UserId';
  static const PASSWORD = 'Password';
  static const EMAIL = 'Email';
  static const EMPLOYEE_ID = 'EmployeeID';
  static const EMP_ID = 'EmpID';
  static const EMPLOYEE_NAME = 'EmployeeName';
  static const LOCATION_ID = 'LocationID';
  static const LOCATION_NAME = 'LocationName';
  static const CENTER_ID = 'CenterID';
  static const ROLE_NAME = 'RoleName';
  static const SHORT_CODE = 'ShortCode';
}

class StoreTableColumn {
  static const STORE_ASSIGN_ID = 'StoreAssignID';
  static const IS_RETAIL_STORE = 'IsRetailStore';
  static const STORE_ID = 'StoreID';
  static const NAME = 'Name';
  static const DESCRIPTION = 'Description';
  static const LOCATION_ID = 'LocationID';
  static const CENTER_ID = 'CenterID';
  static const DEPARTMENT_SECTION_ID = 'DepartmentSectionID';
  static const OFFICE_ID = 'OfficeID';
  static const STORE_TYPE = 'StoreType';
}

class PartyTableColumn {
  static const PARTY_ID = 'PartyId';
  static const USERNAME = 'Username';
  static const email = 'Email';
  static const CONTACT_PERSON = 'ContactPerson';
  static const CONTACT_NUMBER = 'ContactNumber';
  static const IS_TAX_EXEMPT = 'IsTaxExempt';
  static const BUILDING_NUMBER = 'BuildingNumber';
  static const STREET_NAME = 'StreetName';
  static const DISTRICT_NAME = 'DistrictName';
  static const CITY_NAME = 'CityName';
  static const COUNTRY = 'Country';
  static const POSTAL_CODE = 'PostalCode';
  static const ADDITIONAL_NUMBER = 'AdditionalNumber';
  static const VAT_NUMBER = 'VATNumber';
  static const TIN_NUMBER = 'TINNumber';
  static const LOCATION_ID = 'LocationId';
  static const AREA_ID = 'AreaId';
  static const STORE_ASSIGN_ID = 'StoreAssignId';
  static const PARTY_ROLE_ID = 'PartyRoleId';
  static const ACTIVE = 'Active';
  static const DR = 'Dr';
  static const CR = 'CR';
  static const ADDRESS = 'Address';
  static const OPENING_BALANCE_DATE = 'OpeningBalanceDate';
  static const OPENING_BALANCE = 'OpeningBalance';
  static const DESCRIPTION = 'Description';
  static const IS_SUPERVISOR = 'IsSupervisor';
  static const CREATED_BY = 'CreatedBy';
  static const CREATED_ON = 'CreatedOn';
  static const LAST_MODIFIED_BY = 'LastModifiedBy';
  static const LAST_MODIFIED_ON = 'LastModifiedOn';
  static const DUE_BALANCE = 'DueBalance';
}

class SalesTableColumn {
  static const SALES_ID = 'SalesId';
  static const PARTY_ID = 'PartyId';
  static const SALES_DATE = 'SalesDate';
  static const SALES_INVOICE = 'SalesInvoice';
  static const TOTAL_EXCLUDING_VAT = 'TotalExcludingVAT';
  static const USE_PERCENTAGE = 'UsePercentage';
  static const DISCOUNT_PERCENTAGE = 'DiscountPercentage';
  static const DISCOUNT_AMOUNT = 'DiscountAmount';
  static const VAT_STATUS = 'VATStatus';
  static const VAT_AMOUNT = 'VATAmount';
  static const TOTAL_INCLUDING_VAT = 'TotalIncludingVAT';
  static const AMOUNT_IN_WORDS = 'AmountInWords';
  static const PAID_AMOUNT = 'PaidAmount';
  static const BAD_DEBT = 'BadDebt';
  static const DUE_AMOUNT = 'DueAmount';
  static const PAY_STATUS = 'PayStatus';
  static const PAYMENT_NOTE = 'PaymentNote';
  static const BRANCH_ID = 'BranchId';
  static const SR_ID = 'SRId';
  static const WAREHOUSE_ID = 'WarehouseId';
  static const ACTIVE = 'Active';
  static const DELETED = 'Deleted';
  static const SUBMIT_DATE = 'SubmitDate';
  static const SAVE_MODE = 'SaveMode';
  static const DOCUMENT_URL = 'DocumentUrl';
  static const COMPANY_ID = 'CompanyID';
  static const CREATED_BY = 'CreatedBy';
  static const CREATED_ON = 'CreatedOn';
  static const LAST_MODIFIED_BY = 'LastModifiedBy';
  static const LAST_MODIFIED_ON = 'LastModifiedOn';
  static const SR_INVOICE = 'SRInvoice';
  static const SYNC = 'Sync';
  static const DRAFT = 'Draft';
}

class SaleDetailsTableColumn {
  static const SALES_DETAILS_ID = 'SalesDetailsId';
  static const PRODUCT_NAME = 'ProductName';
  static const PARTY_ID = 'PartyId';
  static const VAT_STATUS = 'VATStatus';
  static const WAREHOUSE_ID = 'WarehouseId';
  static const SALES_ID = 'SalesId';
  static const SALES_INVOICE = 'SalesInvoice';
  static const CATEGORY_ID = 'CategoryID';
  static const SUBCATEGORY_ID = 'SubCategoryID';
  static const PRODUCT_ID = 'ProductId';
  static const UNIT_ID = 'UnitId';
  static const UNITS = 'Units';
  static const UNIT_PRICE_INCLUDING_VAT = 'UnitPriceIncludingVAT';
  static const DISCOUNT_AMOUNT = 'DiscountAmount';
  static const VAT_RATE = 'VATRate';
  static const VAT_AMOUNT = 'VATAmount';
  static const UNIT_PRIC_EEXCLUDING_VAT = 'UnitPriceExcludingVAT';
  static const QUANTITY = 'Quantity';
  static const QUANTITY_IN_WORDS = 'QuantityInWords';
  static const ITEM_SUBTOTAL_EXCLUDING_VAT = 'ItemSubtotalExcludingVAT';
  static const ITEM_SUBTOTAL_INCLUDING_VAT = 'ItemSubtotalIncludingVAT';
  static const CALCULATE_ITEM_DISCOUNT = 'CalculateItemDiscount';
  static const RETURN_QUANTITY = 'ReturnQuantity';
  static const DELETED = 'Deleted';
  static const CREATED_BY = 'CreatedBy';
  static const CREATED_ON = 'CreatedOn';
  static const LAST_MODIFIED_BY = 'LastModifiedBy';
  static const LAST_MODIFIED_ON = 'LastModifiedOn';
  static const SR_INVOICE = 'SRInvoice';
}
