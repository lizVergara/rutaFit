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
