import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/bottom_nav_bar.dart';
import '../cubit/user_info_cubit.dart';
import 'home_page.dart';
import 'log_page.dart';
import 'personal_info_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  // 提供外部回调函数用于子页面控制 index
  static void Function()? onBackFromInfo;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // 去掉 const，包裹 PersonalInfoPage 为 BlocProvider
  final List<Widget> _pages = [
    const HomePage(),
    const LogPage(),
    BlocProvider(
      create: (_) => UserInfoCubit(),
      child: const PersonalInfoPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();

    // 注册回调函数供PersonalInfoPage调用
    AppShell.onBackFromInfo = () {
      setState(() {
        _currentIndex = 0; // 返回HomePage
      });
    };
  }

  @override
  void dispose() {
    AppShell.onBackFromInfo = null; //清除回调
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 当前为PersonalInfoPage时,判断是否隐藏NavigationBar
    final bool showNavBar = _currentIndex != 2;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: showNavBar
          ? BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            )
          : null, // 隐藏BottomNavigationBar
    );
  }
}
