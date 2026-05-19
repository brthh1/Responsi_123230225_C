import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';
import '../views/cart_view.dart';
import '../views/profile_view.dart';
import '../controllers/home_controller.dart';
import '../controllers/detail_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/auth_controller.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: BindingsBuilder(() => Get.put(AuthController())),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(HomeController());
        // CartController tidak di-put di sini karena sudah permanent di InitialBinding
      }),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailView(),
      binding: BindingsBuilder(() {
        Get.put(DetailController());
      }),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
        // CartController tidak di-put lagi karena sudah permanent
      }),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: BindingsBuilder(() => Get.put(AuthController())),
    ),
  ];
}