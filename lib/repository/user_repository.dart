import '../model/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);                   // signup
  Future<User?> loginUser(String email, String password); // login
  // Future<void> updateUser(User user);
  // Future<void> logout();

  Future<User?> getCurrentUser();
}
