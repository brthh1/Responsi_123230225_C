import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../data/local/database_helper.dart';  
import '../controllers/auth_controller.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final totalQuantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    final authController = Get.find<AuthController>();
    final username = authController.loggedInUser.value;
    if (username.isNotEmpty) {
      final items = await DatabaseHelper.instance.getCartItemsByUser(username);
      cartItems.value = items;
      _calcTotal();
    }
  }

  void _calcTotal() {
    totalQuantity.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> increaseQuantity(CartItem item) async {
    final newQty = item.quantity + 1;
    await DatabaseHelper.instance.updateQuantity(item.dbId!, newQty);
    await loadCart();
  }

  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      final newQty = item.quantity - 1;
      await DatabaseHelper.instance.updateQuantity(item.dbId!, newQty);
      await loadCart();
    }
  }

  Future<void> deleteItem(CartItem item) async {
    await DatabaseHelper.instance.deleteCartItem(item.dbId!);
    await loadCart();
  }
}