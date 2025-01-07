import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:probashi/models/sale_details.dart';
import '/models/current_stock.dart';
import '/services/current_stock_service.dart';
import '../../../../../base/constants/table_names.dart';
import '../../../../../base/utils/db_helper.dart';

class CurrentStockController extends GetxController {
  List<VwCurrentStock> products = <VwCurrentStock>[].obs;
  List<VwCurrentStock> filteredProducts = <VwCurrentStock>[].obs;
  List<String> category = <String>[].obs;
  List<String> subCategory = <String>[].obs;
  List<String> filteredSubCategory = <String>[].obs;

  var isVat = "".obs;
  var selectedProduct = VwCurrentStock().obs;
  final _service = Get.put(CurrentStockService());

  Future<List<VwCurrentStock>> getProducts(String storeId) async {
    List<VwCurrentStock> allProducts = await _service.getStockByStore(storeId);
    if (products.isNotEmpty) {
      products.clear();
      for (var item in allProducts) {
        products.add(item);
      }
    } else {
      for (var item in allProducts) {
        products.add(item);
      }
    }

    if (filteredProducts.isNotEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(products);
    } else {
      filteredProducts.addAll(products);
    }
    return allProducts;
  }

  selectProduct(VwCurrentStock ob) {
    selectedProduct = ob as Rx<VwCurrentStock>;
  }

  void runFilter(String keyword) {
    List<VwCurrentStock> results = [];
    if (keyword.isEmpty) {
      results = products;
    } else {
      results = products
          .where((data) =>
              data.productName!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    if (filteredProducts.isNotEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(results);
    } else {
      filteredProducts.addAll(results);
    }
  }

  void runFilterCategory(String keyword) {
    List<String> results = [];
    if (keyword.isEmpty) {
      results = subCategory;
    } else {
      results = subCategory
          .where((data) => data.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    if (filteredSubCategory.isNotEmpty) {
      filteredSubCategory.clear();
      filteredSubCategory.addAll(results);
    } else {
      filteredSubCategory.addAll(results);
    }
  }

  VwCurrentStock getProductById(num id) {
    for (var item in products) {
      if (item.productID == id) {
        return item;
      }
    }
    return VwCurrentStock();
  }

  getSubCategoryByStore(String storeId) async {
    List<String> allSubCategories =
        await _service.getSubCategoryByStore(storeId);
    if (subCategory.isNotEmpty) {
      subCategory.clear();
      subCategory.add("All");
      filteredSubCategory.clear();
      filteredSubCategory.add("All");
      for (var item in allSubCategories) {
        subCategory.add(item);
        filteredSubCategory.add(item);
      }
    } else {
      subCategory.add("All");
      filteredSubCategory.add("All");

      for (var item in allSubCategories) {
        subCategory.add(item);
        filteredSubCategory.add(item);
      }
    }
  }

  getProductBySubCategory(String subCategoryName, String storeId) async {
    List<VwCurrentStock> allProducts =
        await _service.getProductBySubCategory(subCategoryName, storeId);
    if (products.isNotEmpty) {
      products.clear();
      for (var item in allProducts) {
        products.add(item);
      }
    } else {
      for (var item in allProducts) {
        products.add(item);
      }
    }

    if (filteredProducts.isNotEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(products);
    } else {
      filteredProducts.addAll(products);
    }
  }

  getData() async {
    if (await InternetConnectionChecker().hasConnection) {
      List<Map<String, dynamic>> data = await DatabaseHelper.instance
          .queryAll(TableNames.CURRENT_STOCK_TABLE);
      if (data.length == 0) {
        initData();
      } else {
        getLocalData();
      }
    } else {
      getLocalData();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    getData();
  }

  Future<void> initData() async {
    if (await InternetConnectionChecker().hasConnection) {
      DatabaseHelper.instance.truncate(TableNames.CURRENT_STOCK_TABLE);
      Map<String, dynamic> user = GetStorage().read('loginUser');
      List<VwCurrentStock> allProducts =
          await getProducts(user['StoreID'].toString());
      for (VwCurrentStock ob in allProducts) {
        await DatabaseHelper.instance.insert(
          {
            CurrentStockTableColumn.ARABIC_NAME: ob.arabicName,
            CurrentStockTableColumn.BARCODE: ob.barcode,
            CurrentStockTableColumn.BASE_QUANTITY: ob.baseQuantity,
            CurrentStockTableColumn.BASE_UNIT: ob.baseUnit,
            CurrentStockTableColumn.BRANCH_ID: ob.branchID,
            CurrentStockTableColumn.DISCOUNT_AMOUNT: ob.discountAmount,
            CurrentStockTableColumn.DISCOUNT_PERCENTAGE: ob.discountPercentage,
            CurrentStockTableColumn.IN_QUANTITY: ob.inQuantity,
            CurrentStockTableColumn.IN_VALUE: ob.inValue,
            CurrentStockTableColumn.IS_RETAIL_STORE: ob.isRetailStore,
            CurrentStockTableColumn.IS_RETAIL_UNIT: ob.isRetailUnit,
            CurrentStockTableColumn.JED_SALE_PRICE: ob.jEDSalePrice,
            CurrentStockTableColumn.KHM_SALE_PRICE: ob.kHMSalePrice,
            CurrentStockTableColumn.LOCATION_NAME: ob.locationName,
            CurrentStockTableColumn.MINIMUM_SALE_PRICE: ob.minimumSalePrice,
            CurrentStockTableColumn.NET_PRICE: ob.netPrice,
            CurrentStockTableColumn.PRODUCT_CATEGORY_ID: ob.productCategoryID,
            CurrentStockTableColumn.PRODUCT_ID: ob.productID,
            CurrentStockTableColumn.PRODUCT_NAME: ob.productName,
            CurrentStockTableColumn.PRODUCT_SUB_CATEGORYID:
                ob.productSubCategoryID,
            CurrentStockTableColumn.QUANTITY_PER_UNIT: ob.quantityPerUnit,
            CurrentStockTableColumn.RETAIL_PRICE: ob.retailPrice,
            CurrentStockTableColumn.RETAIL_UNIT: ob.retailUnit,
            CurrentStockTableColumn.RETAIL_UNIT_ID: ob.retailUnitID,
            CurrentStockTableColumn.SALE_PRICE: ob.salePrice,
            CurrentStockTableColumn.SALE_VALUE: ob.saleValue,
            CurrentStockTableColumn.STORE_ID: ob.storeID,
            CurrentStockTableColumn.STORE_NAME: ob.storeName,
            CurrentStockTableColumn.SUB_CATEGORY_NAME: ob.subCategoryName,
            CurrentStockTableColumn.TOTAL_PURCHASE_VALUE: ob.totalPurchaseValue,
            CurrentStockTableColumn.TOTAL_SALES_VALUE: ob.totalSalesValue,
            CurrentStockTableColumn.UNIT: ob.unit,
            CurrentStockTableColumn.UNIT_ID: ob.unitID,
            CurrentStockTableColumn.UNIT_PRICE: ob.unitPrice,
            CurrentStockTableColumn.VAT_AMOUNT: ob.vATAmount,
            CurrentStockTableColumn.VAT_PERCENTAGE: ob.vATPercentage,
          },
          TableNames.CURRENT_STOCK_TABLE,
        );
      }
    }
  }

  void getLocalData() async {
    List<Map<String, dynamic>> allProducts =
        await DatabaseHelper.instance.queryAll(TableNames.CURRENT_STOCK_TABLE);
    if (products.isNotEmpty) {
      products.clear();
      for (var item in allProducts) {
        products.add(VwCurrentStock.fromJson(item));
      }
    } else {
      for (var item in allProducts) {
        products.add(VwCurrentStock.fromJson(item));
      }
    }

    if (filteredProducts.isNotEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(products);
    } else {
      filteredProducts.addAll(products);
    }
  }

  void getProductFromLOcal() async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.queryAll(TableNames.CURRENT_STOCK_TABLE);

    if (products.length > 0) {
      products.clear();
    }
    for (var ob in data) {
      products.add(VwCurrentStock.fromJson(ob));
    }
  }

  Future<String> updateStock(String srInvoice) async {
    List<Map<String, dynamic>> details =
        await DatabaseHelper.instance.getSalesDeatailBySales(srInvoice);
    List<SaleDetails> data = [];
    for (var ob in details) {
      data.add(SaleDetails.fromJson(ob));
    }
    for (SaleDetails ob in data) {
      List<Map<String, dynamic>> dataa =
          await DatabaseHelper.instance.getProductById(ob.productId.toString());
      VwCurrentStock product = VwCurrentStock.fromJson(dataa[0]);
      product.inQuantity = (product.inQuantity! + (ob.quantity as num));
      DatabaseHelper.instance.productUpdate(product);
    }
    getLocalData();
    return "";
  }
}
