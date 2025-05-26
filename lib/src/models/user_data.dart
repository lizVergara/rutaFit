import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  int totalSteps;

  UserData({
    required this.username,
    required this.password,
    this.totalSteps = 0,
  });
}
