import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../controllers/home_nav_controller.dart';
import '../theme/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<HomeNavController>();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: SalomonBottomBar(
          currentIndex: nav.index.value,
          onTap: nav.changePage,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          itemPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.sync),
              title: const Text("Sync"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.fitness_center),
              title: const Text("Tips"),
            ),
          ],
        ),
      ),
    );
  }
}
