class Profile {
  String userId;
  String name;
  String university;
  String level;
  String imageUrl;
  String email;
  String phone;
  DateTime dob;
  List<Achievement> achievements;
  TestStats testStats;

  Profile({
    required this.userId,
    required this.name,
    required this.university,
    required this.level,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.dob,
    required this.achievements,
    required this.testStats,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['userId'],
      name: json['name'],
      university: json['university'],
      level: json['level'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      phone: json['phone'],
      dob: DateTime.parse(json['dob']),
      achievements: (json['achievements'] as List)
          .map((a) => Achievement.fromJson(a))
          .toList(),
      testStats: TestStats.fromJson(json['testStats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'university': university,
      'level': level,
      'imageUrl': imageUrl,
      'email': email,
      'phone': phone,
      'dob': dob.toIso8601String(),
      'achievements': achievements.map((a) => a.toJson()).toList(),
      'testStats': testStats.toJson(),
    };
  }
}

class Achievement {
  String title;
  String description;
  String icon;
  DateTime dateEarned;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.dateEarned,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      dateEarned: DateTime.parse(json['dateEarned']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'dateEarned': dateEarned.toIso8601String(),
    };
  }
}

class TestStats {
  int testsTaken;
  double avgScore;
  int rank;
  int streak;
  List<String> strongSubjects;
  List<String> weakSubjects;

  TestStats({
    required this.testsTaken,
    required this.avgScore,
    required this.rank,
    required this.streak,
    required this.strongSubjects,
    required this.weakSubjects,
  });

  factory TestStats.fromJson(Map<String, dynamic> json) {
    return TestStats(
      testsTaken: json['testsTaken'],
      avgScore: json['avgScore'].toDouble(),
      rank: json['rank'],
      streak: json['streak'],
      strongSubjects: List<String>.from(json['strongSubjects']),
      weakSubjects: List<String>.from(json['weakSubjects']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testsTaken': testsTaken,
      'avgScore': avgScore,
      'rank': rank,
      'streak': streak,
      'strongSubjects': strongSubjects,
      'weakSubjects': weakSubjects,
    };
  }
}
