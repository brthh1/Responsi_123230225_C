import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class HomeController extends GetxController {
  final games = <Game>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  Future<void> fetchGames() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await http.get(
        Uri.parse('https://jsonfakery.com/games/paginated'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'] ?? data;
        games.value = list.map((e) => Game.fromJson(e)).toList();
      } else {
        errorMessage.value = 'Gagal memuat data (${response.statusCode})';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}