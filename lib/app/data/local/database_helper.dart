import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static const String _cartKey = 'cart_items';

  Future<List<CartItem>> _getAllItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_cartKey);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => CartItem.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> _saveAllItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString(_cartKey, encoded);
  }

  Future<int> insertCartItem(CartItem item) async {
    final items = await _getAllItems();

    final existingIndex = items.indexWhere(
      (e) => e.gameId == item.gameId && e.username == item.username,
    );

    if (existingIndex != -1) {
      items[existingIndex].quantity += item.quantity;
    } else {
      // Buat id unik dari timestamp
      final newItem = CartItem(
        dbId: DateTime.now().millisecondsSinceEpoch,
        gameId: item.gameId,
        gameName: item.gameName,
        backgroundImage: item.backgroundImage,
        rating: item.rating,
        quantity: item.quantity,
        username: item.username,
      );
      items.add(newItem);
    }

    await _saveAllItems(items);
    return 1;
  }

  Future<List<CartItem>> getCartItemsByUser(String username) async {
    final items = await _getAllItems();
    return items.where((e) => e.username == username).toList();
  }

  Future<int> updateQuantity(int id, int quantity) async {
    final items = await _getAllItems();
    final index = items.indexWhere((e) => e.dbId == id);
    if (index != -1) {
      items[index].quantity = quantity;
      await _saveAllItems(items);
    }
    return 1;
  }

  Future<int> deleteCartItem(int id) async {
    final items = await _getAllItems();
    items.removeWhere((e) => e.dbId == id);
    await _saveAllItems(items);
    return 1;
  }
}