import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rutafit/src/widgets/custom_appbar.dart';
import '../controllers/home_nav_controller.dart';
import '../controllers/steps_controller.dart';
import '../widgets/custom_navbar.dart';
import 'sync_screen.dart';
import 'advice_screen.dart';
import 'placeholder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeNavController());
    Get.put(StepsController());
    final nav = Get.find<HomeNavController>();

    final pages = [
      const SyncScreen(),
      const AdviceScreen(),
      const PlaceholderScreen(),
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() => pages[nav.index.value]),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
