// lib/cubit/user_info_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../model/user.dart';
import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(const UserInfoState());

  void setGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void togglePurpose(String purpose) {
    final updated = Set<String>.from(state.purposes);
    updated.contains(purpose) ? updated.remove(purpose) : updated.add(purpose);
    emit(state.copyWith(purposes: updated));
  }

  void setWeight(String value) {
    emit(state.copyWith(weight: double.tryParse(value) ?? 0));
  }

  void setHeight(String value) {
    emit(state.copyWith(height: double.tryParse(value) ?? 0));
  }

  void setAge(String value) {
    emit(state.copyWith(age: int.tryParse(value) ?? 0));
  }

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final box = Hive.box<User>('users');
      final email = box.keys.first;
      final user = box.get(email);
      if (user == null) throw Exception("User not found");

      final updatedUser = User(
        email: user.email,
        password: user.password,
        username: user.username,
        gender: state.gender ?? '',
        weight: state.weight,
        height: state.height,
        age: state.age,
        purpose: state.purposes.join(','),
      );

      await box.put(email, updatedUser);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
