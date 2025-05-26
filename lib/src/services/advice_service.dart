import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/health_tip.dart';

class AdviceService {
  static const _endpoint =
      'https://health.gov/myhealthfinder/api/v4/itemlist.json?Type=topic&Lang=es';

  static Future<List<HealthTip>> fetchTips({int limit = 10}) async {
    final res = await http.get(Uri.parse(_endpoint));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');

    final data = jsonDecode(res.body);
    final node = data['Result']['Items']['Item'];
    final items = node is List ? node : [node];

    return items.take(limit).map((e) => HealthTip.fromJson(e)).toList();
  }
}
