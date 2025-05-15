import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../component/app_text_field.dart';
import '../component/selectable_tag_button.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserInfoCubit>();
    final state = cubit.state;

    final weightController = TextEditingController(
      text: state.weight.toString(),
    );
    final heightController = TextEditingController(
      text: state.height.toString(),
    );
    final ageController = TextEditingController(text: state.age.toString());

    final genderOptions = ['Male', 'Female', 'Other'];
    final purposeOptions = [
      'Improve Physique',
      'Boost Energy',
      'Build Strength',
      'Maintain Healthy Life',
      'Improve Mood',
    ];

    if (state.isSuccess) {
      Future.microtask(() => context.go('/home'));
    }

    return Scaffold(
      // appBar: AppBar(title: const Text("Welcome"), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 88,
                  fontWeight: FontWeight.w100,
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Gender', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children:
                    genderOptions.map((gender) {
                      return SelectableTagButton(
                        label: gender,
                        selected: state.gender == gender,
                        onTap:
                            () =>
                                context.read<UserInfoCubit>().setGender(gender),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Weight (kg)',
                controller: weightController,
                keyboardType: TextInputType.number,
                onChanged: cubit.setWeight,
              ),
              AppTextField(
                label: 'Height (cm)',
                controller: heightController,
                keyboardType: TextInputType.number,
                onChanged: cubit.setHeight,
              ),
              AppTextField(
                label: 'Age',
                controller: ageController,
                keyboardType: TextInputType.number,
                onChanged: cubit.setAge,
              ),
              const SizedBox(height: 24),
              Text(
                'Purpose',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    purposeOptions.map((option) {
                      return SelectableTagButton(
                        label: option,
                        selected: state.purposes.contains(option),
                        onTap:
                            () => context.read<UserInfoCubit>().togglePurpose(
                              option,
                            ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 32),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed:
                      state.isSubmitting
                          ? null
                          : () => context.read<UserInfoCubit>().submit(),
                  child:
                      state.isSubmitting
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
