import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/app_text_field.dart';
import '../component/app_dropdown.dart';
import '../component/selectable_tag_button.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';
import 'package:go_router/go_router.dart';
import 'app_shell.dart'; // ✅ 导入用于回调

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserInfoCubit>();
    final state = context.watch<UserInfoCubit>().state;

    final weightController = TextEditingController(
      text: state.weight.toString(),
    );
    final heightController = TextEditingController(
      text: state.height.toString(),
    );
    final ageController = TextEditingController(text: state.age.toString());

    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ✅ 返回按钮 → 调用 AppShell 回调切换 index
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            AppShell.onBackFromInfo?.call(); // ✅ 返回到 HomePage
          },
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            // ✅ 顶部头像与用户信息
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.name.isEmpty ? 'cxie2' : state.name,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.email.isEmpty ? 'cxie2@scu.edu' : state.email,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            AppTextField(
              label: 'Gender',
              controller: TextEditingController(text: state.gender),
              onChanged: cubit.setGender,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Age',
              controller: ageController,
              keyboardType: TextInputType.number,
              onChanged: cubit.setAge,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Weight (kg)',
              controller: weightController,
              keyboardType: TextInputType.number,
              onChanged: cubit.setWeight,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Height (cm)',
              controller: heightController,
              keyboardType: TextInputType.number,
              onChanged: cubit.setHeight,
            ),
            const SizedBox(height: 20),
            Text(
              "Purpose",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children:
                  ['lmprove Physique', 'Improve Mood', 'Maintain Healthy Life']
                      .map(
                        (option) => SelectableTagButton(
                          label: option,
                          selected: state.purposes.contains(option),
                          onTap: () => cubit.togglePurpose(option),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                await cubit.submit(); // 写入 Hive
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Info updated!')));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () {
                cubit.logout();
                context.go('/');
              },
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
