//import 'package:flu_go_jwt/services/auth/hive/hive_registrar.g.dart';
/* import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart'; */

/* class AuthLocalStorage {
  static const String _boxName = 'auth';
  static const String _productKey = 'product-key';

  // no es future ni supabase ni firebase para que usa solo el singeton
  // get o current?
  static AuthResponse? getSession() {
    final box = Hive.box<AuthResponse>(_boxName);
    return box.get(_productKey);
  }

  //static AuthResponse

  //static User? getUser() {}

  // Guardar o actualizar
  static Future<void> saveSession(AuthResponse session) async {
    final box = Hive.box<AuthResponse>(_boxName);
    await box.put(_productKey, session);
  }
  // !manejar para todos los errores

  static Future<void> deleteSession() async {
    final box = Hive.box<AuthResponse>(_boxName);
    await box.delete(_productKey);
  }
}
 */
// box.isOpen

/* class ProductLocalStorageExample {
  static const String _boxName = 'products';

  // Inizializa Hive y abre la caja
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    await Hive.openBox(_boxName);
  }

  // Obtener todos los productos
  List<String> getAllProducts() {
    final box = Hive.box<String>(_boxName);
    return box.values.toList();
  }

  // Agregar un producto
  Future<void> addProduct(String product) async {
    final box = Hive.box<String>(_boxName);
    await box.add(product); // (index)
  }

  // Update a producto
  Future<void> updateProduct(int index, String product) async {
    final box = Hive.box<String>(_boxName);
    // hay varios put
    await box.putAt(index, product); // (index)
  }

  // Eliminar un producto
  Future<void> deleteProduct(int index) async {
    final box = Hive.box<String>(_boxName);
    await box.delete(index);
  }

} */
  // ! como manejar los try catch

/*
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  Product({required this.name, required this.price});
}
 */


// ! usa estatic y no estaic por que ?
/*
import 'package:hive/hive.dart';
import '../models/product.dart';

class ProductService {
  static const String _boxName = 'productBox';
  static const String _productKey = 'product_key';

  /// Inicializar Hive
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<Product>(_boxName);
  }

  /// Obtener el producto
  Product? getProduct() {
    final box = Hive.box<Product>(_boxName);
    return box.get(_productKey);
  }

  /// Guardar o actualizar el producto
  Future<void> saveProduct(Product product) async {
    final box = Hive.box<Product>(_boxName);
    await box.put(_productKey, product);
  }

  /// Eliminar el producto
  Future<void> deleteProduct() async {
    final box = Hive.box<Product>(_boxName);
    await box.delete(_productKey);
  }
}

 */