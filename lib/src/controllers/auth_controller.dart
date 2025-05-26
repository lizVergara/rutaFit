import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rutafit/src/theme/app_colors.dart';
import '../models/user_data.dart';
import '../services/hive_service.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rxn<UserData> currentUser = Rxn<UserData>();
  RxBool isLogged = false.obs;
  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final Box session = await Hive.openBox('session');
    final lastUser = session.get('last_user') as String?;
    if (lastUser != null) {
      final user = await HiveService.getUser(lastUser);
      if (user != null) {
        currentUser.value = user;
        isLogged.value = true;
      }
    }
  }

  Future<void> login(String user, String pass) async {
    final users = await HiveService.getUsers();
    final existing =
        users.firstWhereOrNull((u) => u.username == user && u.password == pass);

    if (existing != null) {
      currentUser.value = existing;
      isLogged.value = true;
      await Hive.box('session').put('last_user', existing.username);
      return;
    }

    if (users.length < 2) {
      final newUser = UserData(username: user, password: pass, totalSteps: 0);
      await HiveService.saveUser(newUser);
      currentUser.value = newUser;
      isLogged.value = true;
      await Hive.box('session').put('last_user', newUser.username);
    } else {
      _showMaxDialog(users);
    }
  }

  void logout() async {
    currentUser.value = null;
    isLogged.value = false;
    await Hive.box('session').delete('last_user'); // ⬅️
  }

  void _showMaxDialog(List<UserData> users) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Máximo de usuarios alcanzado',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Ya existen 2 usuarios guardados.\nElimina uno.'),
              const SizedBox(height: 20),
              ...users.map(
                (u) => ListTile(
                  title: Text(u.username),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.dialog(AlertDialog(
                        title: const Text(
                          '¿Esta seguro que desea eliminar al usuario?',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                            'Se eliminarán todos sus datos registrados.'),
                        actions: [
                          TextButton(
                              onPressed: Get.back,
                              child: const Text('Cancelar')),
                          TextButton(
                            onPressed: () async {
                              await HiveService.deleteUser(u.username);
                              Get.back(); // confirm
                              Get.back(); // principal
                            },
                            child: const Text('Eliminar',
                                style: TextStyle(color: Colors.red)),
                          )
                        ],
                      ));
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: Get.back, child: const Text('Cancelar')),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
