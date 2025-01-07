import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:probashi/models/party.dart';
import '../../models/sales.dart';
import '/models/current_stock.dart';
import 'package:sqflite/sqflite.dart';
import '/base/constants/table_names.dart';

class DatabaseHelper {
  static const _dbName = 'probashiDb1.db';
  static const _dbVersion = 6;
  static const columnId = 'id';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initiateDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE ${TableNames.CURRENT_STOCK_TABLE}(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      ${CurrentStockTableColumn.PRODUCT_CATEGORY_ID} INTEGER ,
      ${CurrentStockTableColumn.PRODUCT_SUB_CATEGORYID} INTEGER  NULL,
      ${CurrentStockTableColumn.SUB_CATEGORY_NAME} TEXT  NULL,
      ${CurrentStockTableColumn.PRODUCT_ID} INTEGER ,
      ${CurrentStockTableColumn.IN_VALUE} REAL  NULL,
      ${CurrentStockTableColumn.BARCODE} TEXT NULL,
      ${CurrentStockTableColumn.PRODUCT_NAME} TEXT NULL,
      ${CurrentStockTableColumn.ARABIC_NAME} TEXT NULL,
      ${CurrentStockTableColumn.IS_RETAIL_UNIT} BOOL  NULL,
      ${CurrentStockTableColumn.RETAIL_UNIT_ID} INTEGER NULL,
      ${CurrentStockTableColumn.QUANTITY_PER_UNIT} REAL NULL,
      ${CurrentStockTableColumn.RETAIL_UNIT} TEXT NULL,
      ${CurrentStockTableColumn.BASE_QUANTITY} REAL  NULL,
      ${CurrentStockTableColumn.BASE_UNIT} TEXT NULL,
      ${CurrentStockTableColumn.IN_QUANTITY} REAL NULL,
      ${CurrentStockTableColumn.UNIT} TEXT NULL,
      ${CurrentStockTableColumn.UNIT_ID} INTEGER  NULL,
      ${CurrentStockTableColumn.VAT_PERCENTAGE} REAL NULL,
      ${CurrentStockTableColumn.UNIT_PRICE} REAL NULL,
      ${CurrentStockTableColumn.JED_SALE_PRICE} REAL NULL,
      ${CurrentStockTableColumn.KHM_SALE_PRICE} REAL NULL,
      ${CurrentStockTableColumn.SALE_PRICE} REAL NULL,
      ${CurrentStockTableColumn.SALE_VALUE} REAL NULL,
      ${CurrentStockTableColumn.RETAIL_PRICE} REAL  NULL,
      ${CurrentStockTableColumn.TOTAL_PURCHASE_VALUE} REAL NULL,
      ${CurrentStockTableColumn.TOTAL_SALES_VALUE} REAL NULL,
      ${CurrentStockTableColumn.STORE_ID} INTEGER NULL,
      ${CurrentStockTableColumn.IS_RETAIL_STORE} BOOL  NULL,
      ${CurrentStockTableColumn.STORE_NAME} TEXT NULL,
      ${CurrentStockTableColumn.BRANCH_ID} INTEGER NULL,
      ${CurrentStockTableColumn.LOCATION_NAME} TEXT NULL,
      ${CurrentStockTableColumn.VAT_AMOUNT} REAL NULL,
      ${CurrentStockTableColumn.DISCOUNT_PERCENTAGE} REAL  NULL,
      ${CurrentStockTableColumn.DISCOUNT_AMOUNT} REAL NULL,
      ${CurrentStockTableColumn.NET_PRICE} REAL NULL,
      ${CurrentStockTableColumn.MINIMUM_SALE_PRICE} REAL NULL
      )
    
      ''');

      await db.execute('''
      CREATE TABLE ${TableNames.PARTY_TABLE}(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PartyTableColumn.ACTIVE} TEXT  NULL  ,
      ${PartyTableColumn.ADDITIONAL_NUMBER} REAL,
      ${PartyTableColumn.ADDRESS} TEXT ,
      ${PartyTableColumn.AREA_ID} INTEGER ,
      ${PartyTableColumn.BUILDING_NUMBER} REAL  NULL,
      ${PartyTableColumn.CITY_NAME} TEXT NULL,
      ${PartyTableColumn.CONTACT_NUMBER} TEXT NULL,
      ${PartyTableColumn.CONTACT_PERSON} TEXT NULL,
      ${PartyTableColumn.COUNTRY} TEXT NULL,
      ${PartyTableColumn.CR} TEXT NULL,
      ${PartyTableColumn.CREATED_BY} TEXT NULL,
         ${PartyTableColumn.CREATED_ON} TEXT  NULL  ,
      ${PartyTableColumn.DESCRIPTION} TEXT,
      ${PartyTableColumn.DISTRICT_NAME} TEXT ,
      ${PartyTableColumn.DR} TEXT ,
      ${PartyTableColumn.IS_SUPERVISOR} TEXT  NULL,
      ${PartyTableColumn.IS_TAX_EXEMPT} TEXT NULL,
      ${PartyTableColumn.LAST_MODIFIED_BY} TEXT NULL,
      ${PartyTableColumn.LAST_MODIFIED_ON} TEXT NULL,
      ${PartyTableColumn.LOCATION_ID} INTEGER NULL,
      ${PartyTableColumn.OPENING_BALANCE} TEXT NULL,
      ${PartyTableColumn.OPENING_BALANCE_DATE} TEXT NULL,
         ${PartyTableColumn.PARTY_ID} INTEGER  NULL  ,
      ${PartyTableColumn.PARTY_ROLE_ID} INTEGER,
      ${PartyTableColumn.POSTAL_CODE} TEXT ,
      ${PartyTableColumn.STORE_ASSIGN_ID} INTEGER ,
      ${PartyTableColumn.STREET_NAME} TEXT  NULL,
      ${PartyTableColumn.TIN_NUMBER} TEXT NULL,
      ${PartyTableColumn.USERNAME} TEXT NULL,
      ${PartyTableColumn.VAT_NUMBER} TEXT NULL,
      ${PartyTableColumn.email} TEXT NULL,
      ${PartyTableColumn.DUE_BALANCE} TEXT NULL


      )

      ''');

      await db.execute('''
      CREATE TABLE ${TableNames.SALES_TABLE}(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      ${SalesTableColumn.ACTIVE} BOOL  NULL  ,
      ${SalesTableColumn.AMOUNT_IN_WORDS} REAL,
      ${SalesTableColumn.BAD_DEBT} REAL ,
      ${SalesTableColumn.BRANCH_ID} INTEGER ,
      ${SalesTableColumn.COMPANY_ID} INTEGER  NULL,
      ${SalesTableColumn.CREATED_BY} TEXT NULL,
      ${SalesTableColumn.CREATED_ON} TEXT NULL,
      ${SalesTableColumn.DELETED} BOOL NULL,
      ${SalesTableColumn.DISCOUNT_AMOUNT} REAL NULL,
      ${SalesTableColumn.DISCOUNT_PERCENTAGE} REAL NULL,
      ${SalesTableColumn.DOCUMENT_URL} TEXT NULL,
      ${SalesTableColumn.DUE_AMOUNT} REAL  NULL  ,
      ${SalesTableColumn.LAST_MODIFIED_BY} TEXT,
      ${SalesTableColumn.LAST_MODIFIED_ON} TEXT ,
      ${SalesTableColumn.PAID_AMOUNT} REAL ,
      ${SalesTableColumn.PARTY_ID} INTEGER  NULL,
      ${SalesTableColumn.PAYMENT_NOTE} TEXT NULL,
      ${SalesTableColumn.PAY_STATUS} TEXT NULL,
      ${SalesTableColumn.SALES_DATE} TEXT NULL,
      ${SalesTableColumn.SALES_ID} INTEGER NULL,
      ${SalesTableColumn.SALES_INVOICE} TEXT NULL,
      ${SalesTableColumn.SAVE_MODE} TEXT NULL,
      ${SalesTableColumn.SR_ID} INTEGER  NULL  ,
      ${SalesTableColumn.SUBMIT_DATE} TEXT,
      ${SalesTableColumn.TOTAL_EXCLUDING_VAT} REAL ,
      ${SalesTableColumn.TOTAL_INCLUDING_VAT} REAL ,
      ${SalesTableColumn.USE_PERCENTAGE} BOOL  NULL,
      ${SalesTableColumn.VAT_AMOUNT} REAL NULL,
      ${SalesTableColumn.VAT_STATUS} BOOL NULL,
      ${SalesTableColumn.WAREHOUSE_ID} INTEGER NULL,
      ${SalesTableColumn.SR_INVOICE} varchar(500) NULL,
      ${SalesTableColumn.SYNC} TEXT NULL,
      ${SalesTableColumn.DRAFT} TEXT NULL

      )

      ''');

      await db.execute('''
      CREATE TABLE ${TableNames.SALE_DETAILS_TABLE}(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      ${SaleDetailsTableColumn.CALCULATE_ITEM_DISCOUNT} REAL  NULL  ,
      ${SaleDetailsTableColumn.CATEGORY_ID} INTEGER,
      ${SaleDetailsTableColumn.CREATED_BY} TEXT ,
      ${SaleDetailsTableColumn.CREATED_ON} TEXT ,
      ${SaleDetailsTableColumn.DELETED} BOOL  NULL,
      ${SaleDetailsTableColumn.DISCOUNT_AMOUNT} REAL NULL,
      ${SaleDetailsTableColumn.ITEM_SUBTOTAL_EXCLUDING_VAT} REAL NULL,
      ${SaleDetailsTableColumn.ITEM_SUBTOTAL_INCLUDING_VAT} REAL NULL,
      ${SaleDetailsTableColumn.LAST_MODIFIED_BY} TEXT  NULL  ,
      ${SaleDetailsTableColumn.LAST_MODIFIED_ON} TEXT ,
      ${SaleDetailsTableColumn.PARTY_ID} INTEGER ,
      ${SaleDetailsTableColumn.PRODUCT_ID} INTEGER  NULL,
      ${SaleDetailsTableColumn.PRODUCT_NAME} TEXT NULL,
      ${SaleDetailsTableColumn.QUANTITY} REAL NULL,
      ${SaleDetailsTableColumn.QUANTITY_IN_WORDS} TEXT NULL,
      ${SaleDetailsTableColumn.RETURN_QUANTITY} REAL NULL,
      ${SaleDetailsTableColumn.SALES_DETAILS_ID} INTEGER NULL,
      ${SaleDetailsTableColumn.SALES_ID} INTEGER NULL,
      ${SaleDetailsTableColumn.SALES_INVOICE} TEXT  NULL  ,
      ${SaleDetailsTableColumn.SUBCATEGORY_ID} INTEGER,
      ${SaleDetailsTableColumn.UNITS} TEXT ,
      ${SaleDetailsTableColumn.UNIT_ID} INTEGER ,
      ${SaleDetailsTableColumn.UNIT_PRICE_INCLUDING_VAT} REAL  NULL,
      ${SaleDetailsTableColumn.UNIT_PRIC_EEXCLUDING_VAT} REAL NULL,
      ${SaleDetailsTableColumn.VAT_AMOUNT} TEREALXT NULL,
      ${SaleDetailsTableColumn.VAT_RATE} REAL NULL,
      ${SaleDetailsTableColumn.VAT_STATUS} BOOL  NULL,
      ${SaleDetailsTableColumn.WAREHOUSE_ID} INTEGER NULL,
      ${SaleDetailsTableColumn.SR_INVOICE} TEXT NULL

      )

      ''');

      await db.execute('''
      CREATE TABLE ${TableNames.STORE_TABLE}(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      ${StoreTableColumn.CENTER_ID} INTEGER NOT NULL  ,
      ${StoreTableColumn.DEPARTMENT_SECTION_ID} INTEGER,
      ${StoreTableColumn.DESCRIPTION} TEXT ,
      ${StoreTableColumn.IS_RETAIL_STORE} BOOL ,
      ${StoreTableColumn.LOCATION_ID} INTEGER  NULL,
      ${StoreTableColumn.NAME} TEXT NULL,
      ${StoreTableColumn.OFFICE_ID} INTEGER NULL,
      ${StoreTableColumn.STORE_ASSIGN_ID} INTEGER NULL,
      ${StoreTableColumn.STORE_ID} INTEGER NULL,
      ${StoreTableColumn.STORE_TYPE} TEXT NULL
      
      )
    
      ''');
    });
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllSalesByUser(
      String userName) async {
    Database db = await instance.database;
    return await db.query(TableNames.SALES_TABLE,
        where: 'CreatedBy = ?', whereArgs: [userName]);
  }

  Future<int> update(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> truncate(String table) async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<List<Map<String, dynamic>>> selectCategory(String table) async {
    Database db = await instance.database;
    return await db.query(table, distinct: true, columns: ['SubCategoryName']);
  }

  Future<List<Map<String, dynamic>>> getProductBySubCategory(
      String table, String subCategoryName) async {
    Database db = await instance.database;
    return await db.query(table,
        where: 'SubCategoryName = ?', whereArgs: [subCategoryName]);
  }

  Future<List<Map<String, dynamic>>> getSaleDetailsBySales(
      String table, String SRInvoice) async {
    Database db = await instance.database;
    return await db
        .query(table, where: 'SRInvoice = ?', whereArgs: [SRInvoice]);
  }

  Future<List<Map<String, dynamic>>> getProductById(String id) async {
    Database db = await instance.database;
    return await db.query(TableNames.CURRENT_STOCK_TABLE,
        where: 'ProductID = ?', whereArgs: [id]);
  }

  productUpdate(VwCurrentStock ob) async {
    Database db = await instance.database;
    return await db.update(TableNames.CURRENT_STOCK_TABLE, ob.toJson(),
        where: 'ProductID = ?', whereArgs: [ob.productID]);
  }

  partyUpdate(Party ob) async {
    Database db = await instance.database;
    return await db.update(TableNames.PARTY_TABLE, ob.toJson(),
        where: 'PartyId = ?', whereArgs: [ob.partyId]);
  }

  Future<int> deleteSale(String id, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'SRInvoice = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllNonSynced() async {
    Database db = await instance.database;
    return await db
        .query(TableNames.SALES_TABLE, where: 'Sync = ?', whereArgs: ['false']);
  }

  Future<int> deleteSaleDetails(String id, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'SRInvoice = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getPartyById(int id) async {
    Database db = await instance.database;
    return await db
        .query(TableNames.PARTY_TABLE, where: 'PartyId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getSalesDeatailBySales(String id) async {
    Database db = await instance.database;
    return await db.query(TableNames.SALE_DETAILS_TABLE,
        where: 'SRInvoice = ?', whereArgs: [id]);
  }

  getSalesById(String srInvoice) async {
    Database db = await instance.database;
    return await db.query(TableNames.SALES_TABLE,
        where: 'SRInvoice = ?', whereArgs: [srInvoice]);
  }

  salesUpdate(Sales ob) async {
    Database db = await instance.database;
    return await db.update(TableNames.SALES_TABLE, ob.toJson(),
        where: 'SRInvoice = ?', whereArgs: [ob.SRInvoice]);
  }
}
