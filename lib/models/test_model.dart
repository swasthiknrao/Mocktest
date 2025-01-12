class TestModel {
  final String title;
  final List<Question> questions;

  TestModel({
    required this.title,
    required this.questions,
  });
}

class Question {
  final String id;
  final String questionText;
  final List<Option> options;
  final String correctOptionId;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionId,
  });
}

class Option {
  final String id;
  final String text;

  Option({
    required this.id,
    required this.text,
  });
}
