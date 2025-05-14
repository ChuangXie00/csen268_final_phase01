import '../model/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<User?> loginUser(String email, String password);
}
