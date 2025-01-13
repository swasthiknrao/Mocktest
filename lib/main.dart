import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/profile_provider.dart';
import 'models/test_model.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/create_test_screen.dart';
import 'screens/daily_practice_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/exam_prepare_screen.dart';
import 'screens/learn_screen.dart';

import 'screens/menu_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/ssc_exam_screen.dart';
import 'screens/test_screen.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: MaterialApp(
        title: 'Mock Test App',
        theme: ThemeData(
          primaryColor: const Color(0xFF1A73E8),
          scaffoldBackgroundColor: const Color(0xFFF2F9FC),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/create-test': (context) => const CreateTestScreen(),
          '/daily-practice': (context) => const DailyPracticeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/exam-prepare': (context) => const ExamPrepareScreen(),
          '/learn': (context) => const LearnScreen(),
          '/stats': (context) => const StatsScreen(),
          '/ssc-exams': (context) => const SSCExamScreen(),
          '/test': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments as TestModel;
            return TestScreen(test: args);
          },
        },
      ),
    );
  }
}
