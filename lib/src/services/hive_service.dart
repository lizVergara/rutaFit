import 'package:hive/hive.dart';
import '../models/user_data.dart';

class HiveService {
  static const _boxName = 'users';
  static Future<Box<UserData>> _box() async =>
      await Hive.openBox<UserData>(_boxName);

  static Future<List<UserData>> getUsers() async =>
      (await _box()).values.toList();

  static Future<UserData?> getUser(String username) async =>
      (await _box()).get(username);

  static Future<void> saveUser(UserData user) async =>
      (await _box()).put(user.username, user);

  static Future<void> deleteUser(String username) async =>
      (await _box()).delete(username);

  static Future<int> addSteps(String username, int newSteps) async {
    final box = await _box();
    final user = box.get(username);
    if (user == null) return 0;
    user.totalSteps += newSteps;
    await user.save();
    return user.totalSteps;
  }
}
