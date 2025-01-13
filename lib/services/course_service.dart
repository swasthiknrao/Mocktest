import '../models/course_model.dart';

class CourseService {
  // This would be your actual database implementation
  Future<List<Course>> getSuggestedCourses() async {
    // Simulated database response
    await Future.delayed(const Duration(seconds: 1));

    return [
      Course(
        id: '1',
        title: 'Global Business Trends and Markets',
        description: 'Learn about global business trends and market analysis',
        lessonsCount: 10,
        duration: '8h 20min',
        price: 15000,
        instructor: 'Dr. Sarah Johnson',
        thumbnailUrl: 'assets/images/business.jpg',
        rating: 4.8,
        studentsCount: 1250,
        topics: ['Business', 'Economics'],
      ),
      Course(
        id: '2',
        title: 'Introduction to Data Science',
        description: 'Master the fundamentals of data science',
        lessonsCount: 12,
        duration: '10h 30min',
        price: 12000,
        instructor: 'Prof. Michael Chen',
        thumbnailUrl: 'assets/images/data_science.jpg',
        rating: 4.9,
        studentsCount: 2100,
        topics: ['Data Science', 'Programming'],
      ),
      // Add more courses...
    ];
  }
}
