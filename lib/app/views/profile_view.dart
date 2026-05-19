import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE91E8C), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE91E8C).withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE91E8C),
                child: Icon(Icons.person_rounded, size: 55, color: Colors.white),
              ),
            ),
            const SizedBox(height: 14),
            Obx(() => Text(
                  authCtrl.loggedInUser.value,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF880E4F)),
                )),
            const SizedBox(height: 4),
            const Text('',
                style: TextStyle(color: Color(0xFFF48FB1), fontSize: 13)),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE91E8C).withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _ProfileSection(
                    icon: Icons.favorite_rounded,
                    title: 'Kesan',
                    content:
                        'Belajar Flutter sangat menyenangkan.',
                  ),
                  const Divider(color: Color(0xFFFCE4EC), height: 24),
                  _ProfileSection(
                    icon: Icons.message_rounded,
                    title: 'Pesan',
                    content:
                        'Semoga materi Flutter terus diperbarui mengikuti perkembangan teknologi agar mahasiswa siap menghadapi dunia kerja.',
                  ),
                  const Divider(color: Color(0xFFFCE4EC), height: 24),
                  _ProfileSection(
                    icon: Icons.rate_review_rounded,
                    title: 'Kritik',
                    content:
                        'Waktu pengerjaan responsi terasa kurang karena materi cukup banyak. Akan lebih baik jika ada latihan terbimbing sebelum responsi.',
                  ),
                  const Divider(color: Color(0xFFFCE4EC), height: 24),
                  _ProfileSection(
                    icon: Icons.lightbulb_rounded,
                    title: 'Saran',
                    content:
                        'Tambahkan studi kasus nyata agar mahasiswa lebih mudah memahami penerapan Flutter di industri.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
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
                  shadowColor: const Color(0xFFE91E8C).withOpacity(0.4),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Logout',
                    titleStyle: const TextStyle(
                        color: Color(0xFF880E4F), fontWeight: FontWeight.bold),
                    middleText: 'Apakah kamu yakin ingin logout?',
                    middleTextStyle:
                        const TextStyle(color: Color(0xFFF48FB1)),
                    textConfirm: 'Ya',
                    textCancel: 'Batal',
                    confirmTextColor: Colors.white,
                    buttonColor: const Color(0xFFE91E8C),
                    cancelTextColor: const Color(0xFFE91E8C),
                    onConfirm: () {
                      Get.back();
                      authCtrl.logout();
                    },
                  );
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Logout',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFFE91E8C),
        unselectedItemColor: const Color(0xFFF48FB1),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) Get.back();
        },
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _ProfileSection({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFE91E8C), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF880E4F))),
              const SizedBox(height: 4),
              Text(content,
                  style: const TextStyle(
                      color: Color(0xFFAD1457), fontSize: 13, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}