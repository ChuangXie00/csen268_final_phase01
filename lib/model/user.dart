import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String gender;
  @HiveField(4)
  final double weight;
  @HiveField(5)
  final double height;
  @HiveField(6)
  final int age;
  @HiveField(7)
  final String purpose; // 多选的purpose通过join(',')存储

  User({
    required this.email,
    required this.password,
    required this.username,
    required this.gender,
    required this.weight,
    required this.height,
    required this.age,
    required this.purpose,
  });
}

