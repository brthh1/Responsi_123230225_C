import 'package:get/get.dart';
import '../models/game_model.dart';
import '../models/cart_item_model.dart';
import '../data/local/database_helper.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../routes/app_pages.dart';

class DetailController extends GetxController {
  final quantity = 1.obs;
  late Game game;

  @override
  void onInit() {
    super.onInit();
    game = Get.arguments as Game;
  }

  void increment() => quantity.value++;

  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  Future<void> addToCart() async {
    final authController = Get.find<AuthController>();
    final username = authController.loggedInUser.value;

    final cartItem = CartItem(
      gameId: game.id,
      gameName: game.name,
      backgroundImage: game.backgroundImage,
      rating: game.rating,
      quantity: quantity.value,
      username: username,
    );

    await DatabaseHelper.instance.insertCartItem(cartItem);

    final cartController = Get.find<CartController>();
    await cartController.loadCart();

    Get.snackbar('Berhasil', '${game.name} ditambahkan ke keranjang',
        snackPosition: SnackPosition.BOTTOM);
    Get.offNamed(Routes.HOME);
  }
}