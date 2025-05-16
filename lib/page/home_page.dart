import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../component/workout_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 模拟steps和workout time数据
    final stepsToday = 7450;
    final workoutMinutes = 18;
    final recommendations = [
      {'title': 'Push-ups', 'desc': 'Build upper body strength'},
      {'title': 'Plank', 'desc': 'Core stability and endurance'},
      {'title': 'Squats', 'desc': 'Strengthen lower body'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const Text(
                '🏋️ Keep it up!',
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // 今日信息展示(模拟steps和workout time数据)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.directions_walk, color: Colors.orange),
                      const SizedBox(height: 8),
                      Text('$stepsToday Steps', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.timer, color: Colors.orange),
                      const SizedBox(height: 8),
                      Text('$workoutMinutes min', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              const Text(
                '🔥 Recommended for you',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 12),

              // ✅ 卡片推荐列表
              ...recommendations.map((item) => WorkoutCard(
                    title: item['title']!,
                    description: item['desc']!,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: const Color(0xFF3C3C3C),
                          title: Text(item['title']!, style: const TextStyle(color: Colors.white)),
                          content: Text(item['desc']!, style: const TextStyle(color: Colors.white70)),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.pop();        // 关闭弹窗
                                context.push('/start'); // 跳转 StartWorkoutPage
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: const Text('Start'),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
