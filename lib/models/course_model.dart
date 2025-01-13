class Course {
  final String id;
  final String title;
  final String description;
  final int lessonsCount;
  final String duration;
  final double price;
  final String instructor;
  final String thumbnailUrl;
  final double rating;
  final int studentsCount;
  final List<String> topics;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.lessonsCount,
    required this.duration,
    required this.price,
    required this.instructor,
    required this.thumbnailUrl,
    required this.rating,
    required this.studentsCount,
    required this.topics,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      lessonsCount: json['lessonsCount'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      instructor: json['instructor'],
      thumbnailUrl: json['thumbnailUrl'],
      rating: json['rating'].toDouble(),
      studentsCount: json['studentsCount'],
      topics: List<String>.from(json['topics']),
    );
  }
}
