import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.bluetooth),
      label: const Text('Sincronizar dispositivo'),
      onPressed: () async {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
        await Future.delayed(const Duration(seconds: 2));
        Get.back(); // cerrar loader
        Get.snackbar(
          'Éxito',
          'Sincronización exitosa con el dispositivo BLE',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
