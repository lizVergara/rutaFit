import 'package:get/get.dart';
import '../services/hive_service.dart';
import 'auth_controller.dart';

class StepsController extends GetxController {
  final RxInt steps = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSteps();
    ever(AuthController.to.currentUser, (_) => _loadSteps());
  }

  Future<void> _loadSteps() async {
    final user = AuthController.to.currentUser.value;
    steps.value = user?.totalSteps ?? 0;
  }

  Future<void> addSteps(int newSteps) async {
    final user = AuthController.to.currentUser.value;
    if (user != null) {
      steps.value = await HiveService.addSteps(user.username, newSteps);
    }
  }
}
