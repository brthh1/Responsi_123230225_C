import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/detail_controller.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailController>();
    final game = controller.game;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        title: Text(game.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Background Image
            if (game.backgroundImage != null)
              CachedNetworkImage(
                imageUrl: game.backgroundImage!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 220,
                  color: const Color(0xFFFCE4EC),
                  child: const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFFE91E8C))),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 220,
                  color: const Color(0xFFFCE4EC),
                  child: const Icon(Icons.image_not_supported,
                      size: 64, color: Color(0xFFE91E8C)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF880E4F)),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFB300), size: 20),
                      const SizedBox(width: 4),
                      Text('${game.rating ?? "-"} rating',
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFFAD1457))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE91E8C).withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _InfoRow('Game ID', game.id),
                        _InfoRow('Released', game.released ?? '-'),
                        _InfoRow('Ratings Count', '${game.ratingsCount ?? "-"}'),
                        _InfoRow('Reviews Count', '${game.reviewsCount ?? "-"}'),
                        _InfoRow('Updated At', game.updatedAt ?? '-'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Counter
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE91E8C).withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text('Jumlah:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF880E4F))),
                        const SizedBox(height: 12),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: controller.decrement,
                                  icon: const Icon(Icons.remove_circle_rounded,
                                      color: Color(0xFFE91E8C), size: 38),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFCE4EC),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${controller.quantity.value}',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE91E8C)),
                                  ),
                                ),
                                IconButton(
                                  onPressed: controller.increment,
                                  icon: const Icon(Icons.add_circle_rounded,
                                      color: Color(0xFFE91E8C), size: 38),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E8C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 4,
                        shadowColor:
                            const Color(0xFFE91E8C).withOpacity(0.4),
                      ),
                      onPressed: controller.addToCart,
                      icon: const Icon(Icons.shopping_cart_rounded),
                      label: const Text('Tambah ke Keranjang',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(
                    color: Color(0xFFF48FB1),
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF880E4F),
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }
}