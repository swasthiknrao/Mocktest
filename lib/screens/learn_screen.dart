import 'package:flutter/material.dart';
import '../widgets/swipeable_page.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';

const Color kPrimaryColor = Color(0xFF9FE7E6);
const Color kAccentOrange = Color(0xFFFF5522);
const Color kBackgroundColor = Color(0xFFF2F9FC);
const Color kWhite = Colors.white;
const Color kTextPrimary = Color(0xFF1A1D1E);
const Color kTextSecondary = Color(0xFF6B7280);

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearchExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Offset> _slideAnimation;
  Set<String> _selectedTopics = {'Science'}; // Default selected topic
  final CourseService _courseService = CourseService();
  List<Course> _suggestedCourses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.5),
    ).animate(_animation);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isSearchExpanded = false;
      });
    });

    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final courses = await _courseService.getSuggestedCourses();
      setState(() {
        _suggestedCourses = courses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeablePage(
      currentIndex: 3,
      child: GestureDetector(
        onTap: () {
          if (_isSearchExpanded) {
            setState(() {
              _isSearchExpanded = false;
              _animationController.reverse();
            });
          }
        },
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                RepaintBoundary(
                  child: _buildSuggestedCourse(),
                ),
                RepaintBoundary(
                  child: _buildTopics(),
                ),
                RepaintBoundary(
                  child: _buildFeatureCourses(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isSearchExpanded) {
          setState(() {
            _isSearchExpanded = false;
            _animationController.reverse();
          });
        }
      },
      child: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(175, 216, 216, 1),
            child: Column(
              children: [
                // Profile Row
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Profile section (always visible)
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kPrimaryColor.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: kPrimaryColor,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              'John Nicolas',
                              style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Search icon button
                        if (!_isSearchExpanded)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSearchExpanded = !_isSearchExpanded;
                                if (_isSearchExpanded) {
                                  _animationController.forward();
                                } else {
                                  _animationController.reverse();
                                }
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      _isSearchExpanded
                                          ? Icons.close
                                          : Icons.search,
                                      color: const Color(0xFF757575),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Color(0xFF757575),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (_isSearchExpanded) const SizedBox(height: 20),
                _buildProgressCard(),
              ],
            ),
          ),
          if (_isSearchExpanded)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Color(0xFF757575)),
                            onPressed: () {
                              setState(() {
                                _isSearchExpanded = false;
                                _animationController.reverse();
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 50,
                              minHeight: 50,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search courses...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 15,
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedCourse() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested for you',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _suggestedCourses.length,
                itemBuilder: (context, index) {
                  final course = _suggestedCourses[index];
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(
                      right: index != _suggestedCourses.length - 1 ? 16 : 0,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.play_circle_outline,
                                color: kPrimaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(Icons.book_outlined,
                                '${course.lessonsCount} Lessons'),
                            const SizedBox(width: 16),
                            _buildInfoChip(Icons.access_time, course.duration),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${course.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: kAccentOrange,
                                side: const BorderSide(color: kAccentOrange),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Enroll Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopics() {
    // Default topics list
    final defaultTopics = [
      'Science',
      'Maths',
      'History',
      'Biology',
      'Development',
      'Economics',
      'Accounting',
      'Business',
      'Finance',
    ];

    // Combine default and selected topics, removing duplicates
    final allTopics = {...defaultTopics, ..._selectedTopics}.toList()..sort();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Topics',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => _showAllTopics(context),
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allTopics.map((topic) {
                final isSelected = _selectedTopics.contains(topic);
                return OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        _selectedTopics.remove(topic);
                      } else {
                        _selectedTopics.add(topic);
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isSelected ? kAccentOrange : Colors.grey,
                    backgroundColor: isSelected
                        ? kAccentOrange.withOpacity(0.1)
                        : Colors.white,
                    side: BorderSide(
                      color: isSelected ? kAccentOrange : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(topic),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCourses() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Feature Courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280, // Fixed height for horizontal scroll
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => SizedBox(
                width: 280, // Fixed width for each card
                child: _buildFeatureCourseCard(
                  title: 'User Experience Design Crash...',
                  rating: '4.9 (1,724)',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCourseCard({
    required String title,
    required String rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: kPrimaryColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.favorite_border),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildInfoChip(Icons.book_outlined, '10 Lesson'),
              const SizedBox(width: 16),
              _buildInfoChip(Icons.access_time, '8h 20min'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '₹15,000',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: kAccentOrange,
                  side: const BorderSide(color: kAccentOrange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Enroll Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.fromLTRB(
        16,
        _isSearchExpanded ? 20 : 0,
        16,
        16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your first week\'s progress almost done!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: CustomPaint(
              size: const Size(double.infinity, 150),
              painter: ProgressChartPainter(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Week 1', style: TextStyle(color: Colors.grey.shade600)),
              Text('Week 2', style: TextStyle(color: Colors.grey.shade600)),
              Text('Week 3', style: TextStyle(color: Colors.grey.shade600)),
              Text('Week 4', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showSearch(
      context: context,
      delegate: CourseSearchDelegate(),
    );
  }

  void _showAllTopics(BuildContext context) {
    final allTopics = {
      'Science': [
        'Physics',
        'Chemistry',
        'Biology',
        'Environmental Science',
        'Astronomy',
        'Earth Science',
      ],
      'Mathematics': [
        'Algebra',
        'Geometry',
        'Calculus',
        'Statistics',
        'Trigonometry',
        'Linear Algebra',
      ],
      'Commerce': [
        'Economics',
        'Business Studies',
        'Accounting',
        'Finance',
        'Marketing',
        'Banking',
        'Investment',
      ],
      'Law': [
        'Constitutional Law',
        'Criminal Law',
        'Civil Law',
        'Corporate Law',
        'International Law',
      ],
      'History': [
        'World History',
        'Ancient History',
        'Modern History',
        'Art History',
        'Cultural History',
      ],
      'Technology': [
        'Programming',
        'Web Development',
        'Mobile Development',
        'AI & Machine Learning',
        'Cybersecurity',
        'Cloud Computing',
      ],
      'Languages': [
        'English',
        'Spanish',
        'French',
        'German',
        'Chinese',
        'Japanese',
      ],
      'Arts': [
        'Fine Arts',
        'Music',
        'Dance',
        'Theatre',
        'Photography',
        'Design',
      ],
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'All Topics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: allTopics.length,
                    itemBuilder: (context, index) {
                      final category = allTopics.keys.elementAt(index);
                      final topics = allTopics[category]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kTextPrimary,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: topics.map((topic) {
                              final isSelected =
                                  _selectedTopics.contains(topic);
                              return OutlinedButton(
                                onPressed: () {
                                  setModalState(() {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedTopics.remove(topic);
                                      } else {
                                        _selectedTopics.add(topic);
                                      }
                                    });
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      isSelected ? kAccentOrange : Colors.grey,
                                  backgroundColor: isSelected
                                      ? kAccentOrange.withOpacity(0.1)
                                      : Colors.white,
                                  side: BorderSide(
                                    color: isSelected
                                        ? kAccentOrange
                                        : Colors.grey.shade300,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(topic),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProgressChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw 5 horizontal grid lines
    for (int i = 1; i <= 5; i++) {
      final y = size.height * (i / 6); // Divide height into 6 equal parts
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Draw the green progress line
    final paint = Paint()
      ..color = const Color(0xFF4CAF50) // Material Green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.65,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width * 0.8,
      size.height * 0.4,
    );

    // Draw fill under the line
    final fillPaint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw the gray line
    final grayPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final grayPath = Path();
    grayPath.moveTo(size.width * 0.8, size.height * 0.4);
    grayPath.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.35,
      size.width,
      size.height * 0.3,
    );

    canvas.drawPath(grayPath, grayPaint);

    // Draw the green dot
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      6,
      Paint()..color = const Color(0xFF4CAF50),
    );

    // Draw the completion bubble
    final bubbleRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.8, size.height * 0.2),
        width: 100,
        height: 40,
      ),
      const Radius.circular(20),
    );

    canvas.drawRRect(
      bubbleRect,
      Paint()..color = const Color(0xFF4CAF50),
    );

    // Draw the text in the bubble
    const textSpan = TextSpan(
      text: '65%\nCompleted',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        height: 1.2,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(
      minWidth: 100,
      maxWidth: 100,
    );

    textPainter.paint(
      canvas,
      Offset(
        size.width * 0.8 - 50,
        size.height * 0.2 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CourseSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return ListView(
      children: [
        ListTile(
          title: Text('Results for: $query'),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.history),
          title: Text('Search for: $query'),
        ),
      ],
    );
  }
}
