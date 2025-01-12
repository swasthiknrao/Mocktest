import 'package:flutter/material.dart';
import '../services/test_service.dart';
import '../models/test.dart';
import '../widgets/skeleton_loading.dart';

const Color kPrimaryBlue = Color(0xFFAED8D7);
const Color kAccentOrange = Color(0xFFFF5522);
const Color kBackgroundColor = Color(0xFFF2F9FC);

class DailyPracticeScreen extends StatefulWidget {
  const DailyPracticeScreen({super.key});

  @override
  State<DailyPracticeScreen> createState() => _DailyPracticeScreenState();
}

class _DailyPracticeScreenState extends State<DailyPracticeScreen> {
  final TestService _testService = TestService();
  Test? _dailyTest;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDailyTest();
  }

  Future<void> _loadDailyTest() async {
    try {
      final test = await _testService.getDailyTest();
      setState(() {
        _dailyTest = test;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Blue background box at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              color: const Color.fromRGBO(174, 216, 215, 1),
            ),
          ),
          // Main content
          Column(
            children: [
              // AppBar content
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 8,
                  right: 8,
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color.fromARGB(136, 0, 0, 0)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.black54),
                      onPressed: () {},
                    ),
                  ],
                  title: Column(
                    children: [
                      const Text(
                        'Daily Practice',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${_dailyTest?.location ?? 'Unknown'} • ${_formatDate(_dailyTest?.date)}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
              ),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    if (_isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => Column(
              children: [
                SkeletonLoading(
                  width: index == 1 ? 85 : 40,
                  height: index == 1 ? 85 : 40,
                  borderRadius: index == 1 ? 42.5 : 12,
                ),
                const SizedBox(height: 8),
                SkeletonLoading(
                  width: 60,
                  height: 16,
                ),
                const SizedBox(height: 4),
                SkeletonLoading(
                  width: 40,
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 160),
                    decoration: BoxDecoration(
                      color: kPrimaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.emoji_events_rounded,
                          color: kAccentOrange,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_dailyTest?.highestScore ?? 0}%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Highest Score',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildTimerStat(
                '${_dailyTest!.duration}:00',
                'Duration',
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 160),
                    decoration: BoxDecoration(
                      color: kPrimaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.show_chart_rounded,
                          color: kAccentOrange,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_dailyTest?.lowestScore ?? 0}%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Lowest Score',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '${_dailyTest!.totalQuestions}',
                'Questions',
                Icons.quiz_outlined,
              ),
              _buildStatItem(
                '${_dailyTest!.maxPoints}',
                'Points',
                Icons.stars_outlined,
              ),
              _buildStatItem(
                _dailyTest!.status,
                'Status',
                Icons.pending_outlined,
              ),
              _buildStatItem(
                'Level ${_dailyTest!.level}',
                _dailyTest!.expertise,
                Icons.military_tech_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black54, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTimerStat(String time, String label) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: kAccentOrange,
          width: 4.0,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kAccentOrange.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Hour markers
            ...List.generate(60, (index) {
              final angle =
                  (index * 6) * 3.14159 / 180; // 6 degrees for each minute
              final isHour = index % 5 == 0; // Every 5th mark is an hour
              return Transform.rotate(
                angle: angle,
                child: Center(
                  child: Container(
                    width: isHour ? 2.0 : 0.8,
                    height: isHour ? 20 : 4,
                    margin: const EdgeInsets.only(bottom: 80),
                    decoration: BoxDecoration(
                      color: isHour
                          ? const Color.fromARGB(255, 124, 124, 124)
                          : const Color.fromARGB(100, 124, 124, 124),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              );
            }),
            // Time text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${_getMonth(date.month)} ${date.year}';
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
