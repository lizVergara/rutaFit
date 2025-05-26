import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/steps_controller.dart';
import '../widgets/ble_sync_button.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = Get.find<StepsController>().steps;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('${steps.value} pasos registrados',
                style: Theme.of(context).textTheme.headlineMedium)),
            const SizedBox(height: 40),
            const BleSyncButton(),
          ],
        ),
      ),
    );
  }
}
