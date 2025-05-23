import 'package:hive/hive.dart';
import '../model/user.dart';
import 'user_repository.dart';

class HiveUserRepositoryImpl implements UserRepository{
  final Box<User> _userBox = Hive.box<User>('users');

  @override
  Future<void> registerUser(User user) async {
    if(_userBox.containsKey(user.email)) {
      throw Exception('Email already registered');
    }
    await _userBox.put(user.email, user);
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    final user = _userBox.get(email);
    if(user != null && user.password == password) {
      return user;
    }
    return null;
  }

  @override
  Future<User?> getCurrentUser() async {
    final box = await Hive.openBox('userBox');
    final email = box.get('currentUserEmail');
    if (email == null) return null;

    final userList = box.values.whereType<User>().toList();
    try {
      return userList.firstWhere((u) => u.email == email);
    } catch (_) {
      return null;
    }
  }

}