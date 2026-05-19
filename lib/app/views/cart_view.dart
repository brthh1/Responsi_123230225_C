import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_item_model.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        title: const Text('Keranjang Belanja Game',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (cartCtrl.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE4EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_cart_outlined,
                      size: 60, color: Color(0xFFE91E8C)),
                ),
                const SizedBox(height: 16),
                const Text('Keranjang masih kosong',
                    style: TextStyle(
                        color: Color(0xFFF48FB1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: cartCtrl.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartCtrl.cartItems[index];
                  return _CartItemCard(item: item, controller: cartCtrl);
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFFE91E8C).withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, -4)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Quantity:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF880E4F))),
                  Obx(() => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE91E8C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cartCtrl.totalQuantity.value}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final CartController controller;

  const _CartItemCard({required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: const Color(0xFFE91E8C).withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.backgroundImage != null
                  ? CachedNetworkImage(
                      imageUrl: item.backgroundImage!,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                          width: 65,
                          height: 65,
                          color: const Color(0xFFFCE4EC)),
                      errorWidget: (context, url, error) => Container(
                        width: 65,
                        height: 65,
                        color: const Color(0xFFFCE4EC),
                        child: const Icon(Icons.sports_esports,
                            color: Color(0xFFE91E8C)),
                      ),
                    )
                  : Container(
                      width: 65,
                      height: 65,
                      color: const Color(0xFFFCE4EC),
                      child: const Icon(Icons.sports_esports,
                          color: Color(0xFFE91E8C))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.gameName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF880E4F)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFB300), size: 14),
                      Text(' ${item.rating ?? "-"}',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFFF48FB1))),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline_rounded,
                      color: Color(0xFFE91E8C)),
                  onPressed: () => controller.decreaseQuantity(item),
                ),
                Text('${item.quantity}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF880E4F))),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      color: Color(0xFFE91E8C)),
                  onPressed: () => controller.increaseQuantity(item),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded,
                      color: Color(0xFFF48FB1)),
                  onPressed: () => controller.deleteItem(item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}