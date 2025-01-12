import '../models/quote.dart';

class QuoteService {
  static final List<Quote> _quotes = [
    Quote(
        text:
            "Education is not preparation for life; education is life itself.",
        author: "John Dewey"),
    Quote(
        text:
            "The only person who is educated is the one who has learned how to learn and change.",
        author: "Carl Rogers"),
    Quote(
        text:
            "Live as if you were to die tomorrow. Learn as if you were to live forever.",
        author: "Mahatma Gandhi"),
    Quote(
        text:
            "The beautiful thing about learning is that no one can take it away from you.",
        author: "B.B. King"),
    Quote(
        text:
            "Education is the most powerful weapon which you can use to change the world.",
        author: "Nelson Mandela"),
  ];

  Quote getDailyQuote() {
    // Get a quote based on the day of the year
    final dayOfYear = DateTime.now().difference(DateTime(2024, 1, 1)).inDays;
    return _quotes[dayOfYear % _quotes.length];
  }
}
