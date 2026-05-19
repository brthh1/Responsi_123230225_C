import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/game_model.dart';
import '../routes/app_pages.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Obx(() => Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text('Hi, ${authCtrl.loggedInUser.value}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(Routes.CART),
          ),
        ],
      ),
      body: Obx(() {
        if (homeCtrl.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFFE91E8C)),
                SizedBox(height: 12),
                Text('Memuat data game...',
                    style: TextStyle(color: Color(0xFFE91E8C))),
              ],
            ),
          );
        }

        if (homeCtrl.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: Color(0xFFE91E8C), size: 48),
                const SizedBox(height: 8),
                Text(homeCtrl.errorMessage.value,
                    style: const TextStyle(color: Color(0xFFE91E8C))),
                const SizedBox(height: 12),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E8C)),
                    onPressed: homeCtrl.fetchGames,
                    child: const Text('Coba Lagi')),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: const Color(0xFFE91E8C),
          onRefresh: homeCtrl.fetchGames,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: homeCtrl.games.length,
            itemBuilder: (context, index) {
              final game = homeCtrl.games[index];
              return _GameCard(game: game);
            },
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFE91E8C),
        unselectedItemColor: const Color(0xFFF48FB1),
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 1) Get.toNamed(Routes.PROFILE);
        },
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final Game game;
  const _GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shadowColor: const Color(0xFFE91E8C).withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Get.toNamed(Routes.DETAIL, arguments: game),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: game.backgroundImage != null
                  ? CachedNetworkImage(
                      imageUrl: game.backgroundImage!,
                      width: 100,
                      height: 90,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 100,
                        height: 90,
                        color: const Color(0xFFFCE4EC),
                        child: const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFE91E8C))),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 100,
                        height: 90,
                        color: const Color(0xFFFCE4EC),
                        child: const Icon(Icons.sports_esports,
                            size: 36, color: Color(0xFFE91E8C)),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 90,
                      color: const Color(0xFFFCE4EC),
                      child: const Icon(Icons.sports_esports,
                          size: 36, color: Color(0xFFE91E8C)),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF880E4F)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text('Released: ${game.released ?? "-"}',
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFFF48FB1))),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFB300), size: 16),
                        const SizedBox(width: 4),
                        Text('${game.rating ?? "-"}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF880E4F),
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFF48FB1)),
            ),
          ],
        ),
      ),
    );
  }
}