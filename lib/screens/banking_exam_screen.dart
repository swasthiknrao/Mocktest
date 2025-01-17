import 'package:flutter/material.dart';
import '../models/test_model.dart';

const Color kPrimaryBlue = Color(0xFF2B4865);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const Color kAccentBlue = Color(0xFF4FC3F7);
const Color kAccentPurple = Color(0xFF9575CD);
const Color kAccentGreen = Color(0xFF81C784);

class BankingExamScreen extends StatefulWidget {
  const BankingExamScreen({super.key});

  @override
  State<BankingExamScreen> createState() => _BankingExamScreenState();
}

class _BankingExamScreenState extends State<BankingExamScreen>
    with SingleTickerProviderStateMixin {
  final Set<String> selectedExams = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All Exams';
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<String> categories = [
    'All Exams',
    'Bank PO',
    'Bank SO',
    'Bank Clerk',
    'BSCB',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          // Define unique icons for each category
          final Map<String, IconData> categoryIcons = {
            'All Exams': Icons.dashboard_rounded,
            'Bank PO': Icons.account_balance_rounded,
            'Bank SO': Icons.engineering_rounded,
            'Bank Clerk': Icons.person_rounded,
            'BSCB': Icons.account_balance_wallet_rounded,
            'Others': Icons.more_horiz_rounded,
          };

          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? kPrimaryBlue.withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.2)
                              : kPrimaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          categoryIcons[category],
                          color: isSelected ? Colors.white : kPrimaryBlue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final Map<String, List<Map<String, dynamic>>> examCategories = const {
    'Popular Exams': [
      {
        'title': 'SBI PO',
        'subtitle': 'State Bank of India PO',
        'color': Color(0xFF1E88E5),
      },
      {
        'title': 'IBPS PO',
        'subtitle': 'Institute of Banking Personnel Selection',
        'icon': Icons.business_outlined,
        'color': Color(0xFF43A047),
      },
      {
        'title': 'RBI Grade B',
        'subtitle': 'Reserve Bank of India',
        'icon': Icons.account_balance_wallet_outlined,
        'color': Color(0xFF5E35B1),
      },
      {
        'title': 'SEBI Grade A',
        'subtitle': 'Securities and Exchange Board',
        'icon': Icons.trending_up_outlined,
        'color': Color(0xFFE53935),
      },
    ],
    'SBI Exams': [
      {
        'title': 'SBI Clerk',
        'subtitle': 'Junior Associate',
        'icon': Icons.person_outline,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'SBI CBO',
        'subtitle': 'Circle Based Officer',
        'icon': Icons.location_city_outlined,
        'color': Color(0xFF546E7A),
      },
      {
        'title': 'SBI SO',
        'subtitle': 'Specialist Officer',
        'icon': Icons.engineering_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'SBI Apprentice',
        'subtitle': 'Apprenticeship Program',
        'icon': Icons.school_outlined,
        'color': Color(0xFF00ACC1),
      },
    ],
    'IBPS Exams': [
      {
        'title': 'IBPS Clerk',
        'subtitle': 'Clerical Cadre',
        'icon': Icons.person_outline,
        'color': Color(0xFF8E24AA),
      },
      {
        'title': 'IBPS SO',
        'subtitle': 'Specialist Officer',
        'icon': Icons.engineering_outlined,
        'color': Color(0xFFC0CA33),
      },
      {
        'title': 'IBPS RRB Officer Scale-1',
        'subtitle': 'Regional Rural Banks',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'IBPS RRB Office Assistant',
        'subtitle': 'Regional Rural Banks',
        'icon': Icons.support_agent_outlined,
        'color': Color(0xFFFF7043),
      },
    ],
    'Other Public Sector Banks': [
      {
        'title': 'Bank of India PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF26A69A),
      },
      {
        'title': 'Bank of Baroda PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFFD81B60),
      },
      {
        'title': 'Canara Bank PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF7B1FA2),
      },
      {
        'title': 'Union Bank LBO',
        'subtitle': 'Lateral Banking Officer',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF5D4037),
      },
      {
        'title': 'UCO Bank LBO',
        'subtitle': 'Lateral Banking Officer',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'Central Bank Apprentice',
        'subtitle': 'Apprenticeship Program',
        'icon': Icons.school_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'Indian Bank Apprentice',
        'subtitle': 'Apprenticeship Program',
        'icon': Icons.school_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'Indian Bank SO',
        'subtitle': 'Specialist Officer',
        'icon': Icons.engineering_outlined,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'Syndicate Bank Clerk',
        'subtitle': 'Clerical Position',
        'icon': Icons.person_outline,
        'color': Color(0xFF9E9D24),
        'bgIcon': Icons.person,
      },
    ],
    'Private Banks': [
      {
        'title': 'HDFC Bank',
        'subtitle': 'Various Positions',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFFC2185B),
      },
      {
        'title': 'Axis Bank CSO',
        'subtitle': 'Chief Security Officer',
        'icon': Icons.security_outlined,
        'color': Color(0xFF1565C0),
      },
      {
        'title': 'South Indian Bank PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF4527A0),
      },
      {
        'title': 'South Indian Bank Clerk',
        'subtitle': 'Clerical Position',
        'icon': Icons.person_outline,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'Karnataka Bank PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF283593),
      },
      {
        'title': 'Karnataka Bank Clerk',
        'subtitle': 'Clerical Position',
        'icon': Icons.person_outline,
        'color': Color(0xFF1565C0),
      },
    ],
    'Cooperative Banks': [
      {
        'title': 'OSCB Assistant Manager',
        'subtitle': 'Odisha State Cooperative Bank',
        'icon': Icons.business_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'OSCB Banking Assistant',
        'subtitle': 'Odisha State Cooperative Bank',
        'icon': Icons.support_agent_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'BSCB Assistant Manager',
        'subtitle': 'Bihar State Cooperative Bank',
        'icon': Icons.business_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'BSCB Assistant Multipurpose',
        'subtitle': 'Bihar State Cooperative Bank',
        'icon': Icons.support_agent_outlined,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'MP Cooperative Bank Manager',
        'subtitle': 'Madhya Pradesh Cooperative Bank',
        'icon': Icons.business_outlined,
        'color': Color(0xFFC2185B),
      },
      {
        'title': 'MP Cooperative Bank Clerk',
        'subtitle': 'Madhya Pradesh Cooperative Bank',
        'icon': Icons.person_outline,
        'color': Color(0xFF1565C0),
      },
      {
        'title': 'APCOB Manager',
        'subtitle': 'Andhra Pradesh Cooperative Bank',
        'icon': Icons.business_outlined,
        'color': Color(0xFF4527A0),
      },
      {
        'title': 'APCOB Staff Assistant',
        'subtitle': 'Andhra Pradesh Cooperative Bank',
        'icon': Icons.support_agent_outlined,
        'color': Color(0xFF2E7D32),
      },
    ],
    'Development Banks': [
      {
        'title': 'SIDBI Assistant Manager',
        'subtitle': 'Small Industries Development Bank',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'NABARD Development Assistant',
        'subtitle': 'National Bank for Agriculture',
        'icon': Icons.agriculture_outlined,
        'color': Color(0xFF8BC34A),
        'bgIcon': Icons.agriculture,
      },
      {
        'title': 'NHB Assistant Manager',
        'subtitle': 'National Housing Bank',
        'icon': Icons.home_work_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'EXIM Bank Management Trainee',
        'subtitle': 'Export Import Bank',
        'icon': Icons.import_export_outlined,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'Bank Note Press Dewas',
        'subtitle': 'Various Positions',
        'icon': Icons.print_outlined,
        'color': Color(0xFF3F51B5),
        'bgIcon': Icons.print,
      },
      {
        'title': 'IDBI Junior Assistant Manager',
        'subtitle': 'Assistant Manager Position',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF00BCD4),
        'bgIcon': Icons.business_center,
      },
    ],
    'Certification Exams': [
      {
        'title': 'JAIIB',
        'subtitle': 'Junior Associate Indian Institute of Bankers',
        'icon': Icons.school_outlined,
        'color': Color(0xFFC2185B),
      },
      {
        'title': 'CAIIB',
        'subtitle': 'Certified Associate Indian Institute of Bankers',
        'icon': Icons.school_outlined,
        'color': Color(0xFF1565C0),
      },
    ],
    'Other Exams': [
      {
        'title': 'IIFCL Assistant Manager',
        'subtitle': 'India Infrastructure Finance Company',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF4527A0),
      },
      {
        'title': 'IDBI Executive',
        'subtitle': 'Industrial Development Bank of India',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'IDBI Assistant Manager',
        'subtitle': 'Industrial Development Bank of India',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'EPFO Assistant',
        'subtitle': 'Employees Provident Fund Organisation',
        'icon': Icons.account_balance_wallet_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'EPFO SSA',
        'subtitle': 'Social Security Assistant',
        'icon': Icons.security_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'EPFO Stenographer',
        'subtitle': 'Stenographer Position',
        'icon': Icons.record_voice_over_outlined,
        'color': Color(0xFF2E7D32),
      },
      {
        'title': 'ECGC PO',
        'subtitle': 'Export Credit Guarantee Corporation',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF795548),
        'bgIcon': Icons.business_center,
      },
      {
        'title': 'Indian Bank SO',
        'subtitle': 'Specialist Officer',
        'icon': Icons.engineering_outlined,
        'color': Color(0xFF607D8B),
        'bgIcon': Icons.engineering,
      },
      {
        'title': 'OSCB Junior Manager',
        'subtitle': 'Odisha State Cooperative Bank',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF009688),
        'bgIcon': Icons.account_balance,
      },
    ],
    'Regional Banks': [
      {
        'title': 'TMB Bank Clerk',
        'subtitle': 'Tamilnad Mercantile Bank',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF1E88E5),
      },
      {
        'title': 'Nainital Bank PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF43A047),
      },
      {
        'title': 'TJSB Bank Trainee Officer',
        'subtitle': 'Thane Janata Sahakari Bank',
        'icon': Icons.school_outlined,
        'color': Color(0xFF5E35B1),
      },
      {
        'title': 'Akola Bank Travel Junior Clerk',
        'subtitle': 'Junior Clerk Position',
        'icon': Icons.person_outline,
        'color': Color(0xFFE53935),
      },
      {
        'title': 'RSCB',
        'subtitle': 'Rajasthan State Cooperative Bank',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF795548),
        'bgIcon': Icons.account_balance,
      },
      {
        'title': 'National Bank Clerk',
        'subtitle': 'Clerical Position',
        'icon': Icons.person_outline,
        'color': Color(0xFF607D8B),
        'bgIcon': Icons.person,
      },
      {
        'title': 'UCO Bank LBO',
        'subtitle': 'Lateral Banking Officer',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF009688),
        'bgIcon': Icons.business_center,
      },
    ],
    'Security & Support': [
      {
        'title': 'Indian Bank Security Guard',
        'subtitle': 'Security Position',
        'icon': Icons.security_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'Bank Note Press Dewas',
        'subtitle': 'Various Positions',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF546E7A),
      },
    ],
    'State Cooperative Banks': [
      {
        'title': 'PSCB Clerk Cum DEO',
        'subtitle': 'Punjab State Cooperative Bank',
        'icon': Icons.person_outline,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'HPSCB Junior Clerk',
        'subtitle': 'Himachal Pradesh State Cooperative Bank',
        'icon': Icons.person_outline,
        'color': Color(0xFF00ACC1),
      },
      {
        'title': 'HRCO Bank Clerk',
        'subtitle': 'Haryana State Cooperative Bank',
        'icon': Icons.person_outline,
        'color': Color(0xFF8E24AA),
      },
    ],
    'Additional Banking Posts': [
      {
        'title': 'Syndicate Bank PO',
        'subtitle': 'Probationary Officer',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFFC0CA33),
      },
      {
        'title': 'BOB Acquisition Officer',
        'subtitle': 'Bank of Baroda',
        'icon': Icons.business_center_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'Central Bank of India Sub Staff',
        'subtitle': 'Support Staff Position',
        'icon': Icons.support_outlined,
        'color': Color(0xFFFF7043),
      },
      {
        'title': 'Agricultural Field Officer – Scale I',
        'subtitle': 'Agriculture Specialist',
        'icon': Icons.agriculture_outlined,
        'color': Color(0xFF4CAF50),
        'bgIcon': Icons.agriculture,
      },
      {
        'title': 'Current Affairs',
        'subtitle': 'Banking & Finance Updates',
        'icon': Icons.newspaper_outlined,
        'color': Color(0xFF9C27B0),
        'bgIcon': Icons.newspaper,
      },
    ],
  };

  Map<String, List<Map<String, dynamic>>> get filteredExamCategories {
    Map<String, List<Map<String, dynamic>>> filtered = {};

    examCategories.forEach((category, exams) {
      final filteredExams = exams.where((exam) {
        final title = exam['title'].toString().toLowerCase();
        final subtitle = exam['subtitle'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();

        bool matchesCategory = true;
        if (_selectedCategory != 'All Exams') {
          if (_selectedCategory == 'Bank PO') {
            matchesCategory = title.contains('po') ||
                subtitle.contains('probationary officer');
          } else if (_selectedCategory == 'Bank SO') {
            matchesCategory =
                title.contains('so') || subtitle.contains('specialist officer');
          } else if (_selectedCategory == 'Bank Clerk') {
            matchesCategory =
                title.contains('clerk') || subtitle.contains('clerical');
          } else if (_selectedCategory == 'BSCB') {
            matchesCategory = title.contains('bscb') ||
                subtitle.contains('state cooperative bank');
          } else if (_selectedCategory == 'Others') {
            matchesCategory = !title.contains('po') &&
                !title.contains('so') &&
                !title.contains('clerk') &&
                !title.contains('bscb');
          }
        }

        return (title.contains(query) || subtitle.contains(query)) &&
            matchesCategory;
      }).toList();

      if (filteredExams.isNotEmpty) {
        filtered[category] = filteredExams;
      }
    });

    return filtered;
  }

  Widget _buildCategory(String category, List<Map<String, dynamic>> exams) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        if (category == 'Popular Exams')
          _buildPopularExams(exams)
        else
          _buildExamGrid(exams),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPopularExams(List<Map<String, dynamic>> exams) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 300),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(50 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedExams.contains(exam['title'])) {
                          selectedExams.remove(exam['title']);
                        } else {
                          selectedExams.add(exam['title']);
                        }
                      });
                    },
                    child: Container(
                      width: 300,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            exam['color'] as Color,
                            (exam['color'] as Color).withOpacity(0.8),
                            Color.lerp(
                                exam['color'] as Color, kAccentBlue, 0.3)!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: (exam['color'] as Color).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Animated background pattern
                          ...List.generate(3, (i) {
                            return Positioned(
                              right: -20 - (i * 20),
                              bottom: -20 - (i * 20),
                              child: TweenAnimationBuilder(
                                duration: Duration(seconds: 2 + i),
                                tween: Tween<double>(begin: 0, end: 1),
                                builder: (context, double value, child) {
                                  return Transform.rotate(
                                    angle: value * 2 * 3.14,
                                    child: Icon(
                                      exam['icon'] as IconData,
                                      size: 120 - (i * 20),
                                      color: Colors.white
                                          .withOpacity(0.1 - (i * 0.02)),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    exam['icon'] as IconData,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  exam['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  exam['subtitle'] as String,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 16,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildExamGrid(List<Map<String, dynamic>> exams) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return _buildCompactCard(
          exams[index]['title'],
          exams[index]['subtitle'],
          exams[index]['icon'],
          exams[index]['color'],
        );
      },
    );
  }

  Widget _buildCompactCard(
      String title, String subtitle, IconData icon, Color color) {
    final bool isSelected = selectedExams.contains(title);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: color, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedExams.remove(title);
                } else {
                  selectedExams.add(title);
                }
              });
            },
            child: Stack(
              children: [
                // Animated background icon
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: TweenAnimationBuilder(
                    duration: const Duration(seconds: 2),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.rotate(
                        angle: value * 2 * 3.14,
                        child: Icon(
                          icon,
                          size: 60,
                          color: color.withOpacity(0.1),
                        ),
                      );
                    },
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.1),
                              color.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Selection indicator
                if (isSelected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        // Animated gradient circles
        Positioned(
          top: -100,
          right: -100,
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.rotate(
                angle: value * 2 * 3.14,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        kPrimaryBlue.withOpacity(0.2),
                        kAccentBlue.withOpacity(0.2),
                        kAccentPurple.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 50,
          left: -50,
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 4),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.rotate(
                angle: -value * 2 * 3.14,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        kAccentGreen.withOpacity(0.15),
                        kAccentBlue.withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'Banking Exams',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search banking exams...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
                _buildCategoryFilter(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredExamCategories.length,
                    itemBuilder: (context, index) {
                      final category =
                          filteredExamCategories.keys.elementAt(index);
                      final exams = filteredExamCategories[category]!;
                      return _buildCategory(category, exams);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
