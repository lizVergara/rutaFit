import 'package:get/get.dart';
import '../models/health_tip.dart';
import '../services/advice_service.dart';

class AdviceController extends GetxController {
  RxList<HealthTip> adviceList = <HealthTip>[].obs;
  RxBool loading = false.obs;

  Future<void> fetchAdvice() async {
    loading.value = true;
    try {
      adviceList.assignAll(await AdviceService.fetchTips());
    } catch (_) {
      Get.snackbar('Error', 'No se pudieron cargar los consejos');
    } finally {
      loading.value = false;
    }
  }
}
