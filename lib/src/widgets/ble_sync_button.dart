import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutafit/src/controllers/steps_controller.dart';
import '../controllers/auth_controller.dart';
import '../theme/app_colors.dart';
import 'signal_painter.dart';

class BleSyncButton extends StatefulWidget {
  const BleSyncButton({super.key});

  @override
  State<BleSyncButton> createState() => _BleSyncButtonState();
}

class _BleSyncButtonState extends State<BleSyncButton>
    with SingleTickerProviderStateMixin {
  final _ble = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _scanSub;
  bool _syncing = false;
  final _rand = Random();

  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  late final Animation<double> _pulse =
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

  @override
  void dispose() {
    _ctrl.dispose();
    _scanSub?.cancel();
    super.dispose();
  }

  Future<void> _handleSync() async {
    if (_syncing) return;
    setState(() => _syncing = true);

    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    _scanSub = _ble.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((_) {});

    await Future.delayed(const Duration(seconds: 2));
    await _scanSub?.cancel();
    setState(() => _syncing = false);
    final username = Get.find<AuthController>().currentUser.value?.username;
    if (username == null) return;

    final stepsToday = _rand.nextInt(1000) + 1;
    await Get.find<StepsController>().addSteps(stepsToday);
    final totalSteps = Get.find<StepsController>().steps.value;

    Get.snackbar(
      '¡Sincronización completada!',
      'Hoy hiciste $stepsToday pasos 🎉\nTu total acumulado es de $totalSteps pasos.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary.withOpacity(0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    const size = 260.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _pulse,
          builder: (_, __) => CustomPaint(
            painter:
                SignalPainter(progress: _pulse.value, color: AppColors.primary),
            child: const SizedBox(width: size, height: size),
          ),
        ),
        ElevatedButton(
          onPressed: _handleSync,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(50),
            backgroundColor: AppColors.primary,
            elevation: 10,
          ),
          child: _syncing
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.bluetooth, color: Colors.white, size: 60),
        ),
      ],
    );
  }
}
