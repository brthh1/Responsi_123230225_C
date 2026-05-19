import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final isPasswordVisible = false.obs;
  final usernameError = ''.obs;
  final passwordError = ''.obs;
  final loggedInUser = ''.obs;

  // Password valid: 3 digit terakhir NIM
  static const String validPassword = '225';

  @override
  void onInit() {
    super.onInit();
    _loadLoggedInUser();
  }

  Future<void> _loadLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('logged_in_user') ?? '';
    loggedInUser.value = user;
  }

  bool validate(String username, String password) {
    bool isValid = true;
    usernameError.value = '';
    passwordError.value = '';

    if (username.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
      isValid = false;
    } else if (username.length < 5) {
      usernameError.value = 'Username minimal 5 karakter';
      isValid = false;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      isValid = false;
    } else if (password != validPassword) {
      passwordError.value = 'Password tidak valid';
      isValid = false;
    }

    return isValid;
  }

  Future<void> login(String username, String password) async {
    if (validate(username, password)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('logged_in_user', username);
      loggedInUser.value = username;
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_in_user');
    loggedInUser.value = '';
    Get.offAllNamed(Routes.LOGIN);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}