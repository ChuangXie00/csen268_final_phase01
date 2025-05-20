import 'package:csen268_final_phase01/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'navigation/router.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'model/user.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();

  // Hive.registerAdapter(UserAdapter()); // 注册user.g.dart生成的adapter
  // await Hive.openBox<User>('users'); // 打开User数据的box

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(authenticationBloc),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF3B3B3B), // 深色背景
        primaryColor: const Color(0xFFFF9100), // 橙色主色调
        // cardColor: const Color(0xFF3C3C3C), // 卡片背景
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD5DBDC),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFD5DBDC)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFD5DBDC)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFFD5DBDC)),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFFFF9100)),
          hintStyle: TextStyle(color: Color(0xFFD5DBDC)),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF9100)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD5DBDC)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF9100)),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF9100),
            foregroundColor: Color(0xFF3B3B3B),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Color(0xFFFF9100)),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3B3B3B),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFD5DBDC),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFFD5DBDC)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF3B3B3B),
          selectedIconTheme: IconThemeData(size: 30, color: Color(0xFFFF9100)),
          unselectedIconTheme: IconThemeData(
            size: 30,
            color: Color(0xFFD5DBDC),
          ),
          selectedItemColor: Color(0xFFFF9100),
          unselectedItemColor: Color(0xFFD5DBDC),
        ),
        iconTheme: IconThemeData(color: Color(0xFFFF9100), size: 35),
      ),
    );
  }
}
