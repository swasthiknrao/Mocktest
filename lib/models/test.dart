class Test {
  final int highestScore;
  final int lowestScore;
  final int duration;
  final int totalQuestions;
  final int maxPoints;
  final String status;
  final String level;
  final String expertise;
  final DateTime date;
  final String location;

  Test({
    required this.highestScore,
    required this.lowestScore,
    required this.duration,
    required this.totalQuestions,
    required this.maxPoints,
    required this.status,
    required this.level,
    required this.expertise,
    required this.date,
    required this.location,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      highestScore: json['highest_score'] ?? 0,
      lowestScore: json['lowest_score'] ?? 0,
      duration: json['duration'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      maxPoints: json['max_points'] ?? 0,
      status: json['status'] ?? 'Pending',
      level: json['level'] ?? 'Level 1',
      expertise: json['expertise'] ?? 'Beginner',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      location: json['location'] ?? 'Unknown',
    );
  }
}
