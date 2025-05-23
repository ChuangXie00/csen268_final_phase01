import 'package:equatable/equatable.dart';

class UserInfoState extends Equatable {
  final String name;
  final String email;        
  final String? gender;
  final Set<String> purposes;
  final double weight;
  final double height;
  final int age;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const UserInfoState({
    this.name = '',                
    this.email = '',
    this.gender,
    this.purposes = const {},
    this.weight = 0,
    this.height = 0,
    this.age = 0,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  UserInfoState copyWith({
    String? name,                 // copyWith 新增字段
    String? email,
    String? gender,
    Set<String>? purposes,
    double? weight,
    double? height,
    int? age,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return UserInfoState(
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      purposes: purposes ?? this.purposes,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [name, email, gender, purposes, weight, height, age, isSubmitting, isSuccess, error];
}
