import '../models/test_model.dart';

class MockData {
  static List<TestModel> getMockTests() {
    return [
      TestModel(
        title: 'Mathematics Test',
        questions: [
          Question(
            id: '1',
            questionText: 'What is 2 + 2?',
            options: [
              Option(id: 'a', text: '3'),
              Option(id: 'b', text: '4'),
              Option(id: 'c', text: '5'),
              Option(id: 'd', text: '6'),
            ],
            correctOptionId: 'b',
          ),
          Question(
            id: '2',
            questionText: 'Solve: 3x + 6 = 15',
            options: [
              Option(id: 'a', text: 'x = 3'),
              Option(id: 'b', text: 'x = 4'),
              Option(id: 'c', text: 'x = 5'),
              Option(id: 'd', text: 'x = 6'),
            ],
            correctOptionId: 'a',
          ),
        ],
      ),
      TestModel(
        title: 'Science Quiz',
        questions: [
          Question(
            id: '1',
            questionText: 'What is the chemical symbol for Gold?',
            options: [
              Option(id: 'a', text: 'Ag'),
              Option(id: 'b', text: 'Fe'),
              Option(id: 'c', text: 'Au'),
              Option(id: 'd', text: 'Cu'),
            ],
            correctOptionId: 'c',
          ),
          Question(
            id: '2',
            questionText: 'What is the unit of force?',
            options: [
              Option(id: 'a', text: 'Pascal'),
              Option(id: 'b', text: 'Newton'),
              Option(id: 'c', text: 'Joule'),
              Option(id: 'd', text: 'Watt'),
            ],
            correctOptionId: 'b',
          ),
        ],
      ),
    ];
  }
}
