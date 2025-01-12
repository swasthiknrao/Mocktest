import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/profile.dart';
import 'dart:io';

class ProfileService {
  static const String baseUrl = 'YOUR_API_URL';
  static const bool useMockData = true; // Toggle this when database is ready

  Future<Profile> getProfile(String userId) async {
    if (useMockData) {
      return _getMockProfile(userId);
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/profiles/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Profile.fromJson(data);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> updateProfile(Profile profile) async {
    if (useMockData) {
      await Future.delayed(
          const Duration(seconds: 1)); // Simulate network delay
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/profiles/${profile.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profile.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> getProfileStats(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profiles/$userId/stats'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load profile stats');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<String> uploadImage(File imageFile) async {
    if (useMockData) {
      await Future.delayed(const Duration(seconds: 1));
      return imageFile.path;
    }

    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-image'),
      );

      // Add file to request
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      // Send request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      if (response.statusCode == 200) {
        return data['imageUrl'];
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Mock data method
  Profile _getMockProfile(String userId) {
    return Profile(
      userId: userId,
      name: 'John Doe',
      university: 'Sample University',
      level: 'Advanced',
      imageUrl: 'assets/images/profile.png',
      email: 'john@example.com',
      phone: '+1234567890',
      dob: DateTime(1990, 1, 1),
      achievements: [],
      testStats: TestStats(
        testsTaken: 10,
        avgScore: 85.0,
        rank: 5,
        streak: 3,
        strongSubjects: ['Math', 'Science'],
        weakSubjects: ['History'],
      ),
    );
  }
}
