import '../models/test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TestService {
  Future<Test> getDailyTest() async {
    try {
      // Replace this with your actual API call
      final response =
          await http.get(Uri.parse('your_api_endpoint/daily-test'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Test.fromJson(data);
      } else {
        throw Exception('Failed to load daily test');
      }
    } catch (e) {
      // Return default test data in case of error
      return Test(
        highestScore: 0,
        lowestScore: 0,
        duration: 30,
        totalQuestions: 0,
        maxPoints: 0,
        status: 'Not Started',
        level: '1',
        expertise: 'Beginner',
        date: DateTime.now(),
        location: 'Unknown',
      );
    }
  }

  Future<List<Test>> getAllTests() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Test(
        highestScore: 85,
        lowestScore: 65,
        duration: 45,
        totalQuestions: 30,
        maxPoints: 100,
        status: 'completed',
        level: '1',
        expertise: 'Beginner',
        date: DateTime.now().subtract(const Duration(days: 1)),
        location: 'Test Center 1',
      ),
    ];
  }

  Future<List<Test>> getRecentTests() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Test(
        highestScore: 92,
        lowestScore: 75,
        duration: 60,
        totalQuestions: 40,
        maxPoints: 100,
        status: 'completed',
        level: '2',
        expertise: 'Intermediate',
        date: DateTime.now().subtract(const Duration(days: 2)),
        location: 'Test Center 2',
      ),
    ];
  }

  Future<void> createTest(Test test) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement actual API call to create test
  }
}
