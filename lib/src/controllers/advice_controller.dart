import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HealthTip {
  final int id;
  final String title;

  String get url => 'https://www.google.com/search?q=$title';

  HealthTip({required this.id, required this.title});

  factory HealthTip.fromJson(Map<String, dynamic> json) => HealthTip(
        id: int.parse(json['Id'].toString()),
        title: (json['Title'] ?? 'Sin título').toString().trim(),
      );
}

class AdviceController extends GetxController {
  RxList<HealthTip> adviceList = <HealthTip>[].obs;
  RxInt visibleCount = 0.obs;
  RxBool loading = false.obs;

  void _revealSequentially() async {
    for (int i = 0; i < adviceList.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      visibleCount.value = i + 1;
    }
  }

  Future<void> fetchAdvice() async {
    loading.value = true;
    try {
      final res = await http.get(Uri.parse(
          'https://health.gov/myhealthfinder/api/v4/itemlist.json?Type=topic&Lang=es'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final itemNode = data['Result']['Items']['Item'];
        final List<dynamic> items = itemNode is List ? itemNode : [itemNode];
        adviceList.assignAll(
          items.take(10).map((e) => HealthTip.fromJson(e)).toList(),
        );
        // reiniciar animación
        visibleCount.value = 0;
        _revealSequentially();
      } else {
        Get.snackbar('Error', 'No se pudieron cargar los consejos');
      }
    } catch (_) {
      Get.snackbar('Error', 'Error al conectar con el servidor');
    } finally {
      loading.value = false;
    }
  }
}
