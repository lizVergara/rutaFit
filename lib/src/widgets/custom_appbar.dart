import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _height = 80.0;

  CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final auth = AuthController.to;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10,
      centerTitle: true,
      title: Obx(
        () => Text(
          'Hola, ${auth.currentUser.value?.username ?? ''}',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: AppColors.primary),
          onPressed: auth.logout,
        ),
      ],
    );
  }
}
