import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/shared_bottom_nav.dart';
import '../widgets/swipeable_page.dart';

const Color kPrimaryBlue = Color(0xFFAED8D7);
const Color kAccentOrange = Color(0xFFFF5522);
const Color kBackgroundColor = Color(0xFFF2F9FC);
const Color kCardShadow = Color(0x1A000000);

class ExamPrepareScreen extends StatefulWidget {
  const ExamPrepareScreen({super.key});

  @override
  State<ExamPrepareScreen> createState() => _ExamPrepareScreenState();
}

class _ExamPrepareScreenState extends State<ExamPrepareScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  bool _isGovernmentSelected = true;
  bool _isAllExams = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Already on exam prepare screen
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/activity');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/menu');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/stats');
        break;
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: kPrimaryBlue.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? kPrimaryBlue : Colors.grey.shade500,
                size: 20,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: kPrimaryBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isGovernmentSelected = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isGovernmentSelected ? kAccentOrange : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Government Exams',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isGovernmentSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isGovernmentSelected = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isGovernmentSelected ? kAccentOrange : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Private Jobs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_isGovernmentSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Stack(
        children: [
          // Main Search Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  kPrimaryBlue.withOpacity(0.1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryBlue.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Search Icon with Animation
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: 0,
                    end: _searchQuery.isNotEmpty ? 1 : 0,
                  ),
                  builder: (context, double value, child) {
                    return Transform.rotate(
                      angle: value * 0.5,
                      child: Icon(
                        Icons.search_rounded,
                        color: Color.lerp(
                          kAccentOrange,
                          kPrimaryBlue,
                          value,
                        ),
                        size: 24,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                // Search TextField
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Find your perfect exam...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                // Clear Button
                if (_searchQuery.isNotEmpty)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      color: Colors.grey[400],
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          // Bottom Indicator Line
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kAccentOrange,
                    kAccentOrange.withOpacity(_searchQuery.isEmpty ? 0.0 : 0.3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(String title, String courses, Color startColor,
      Color endColor, IconData icon,
      {bool isLarge = false}) {
    return Card(
      elevation: 12,
      shadowColor: startColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [startColor, endColor],
            stops: const [0.2, 0.8],
          ),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Animated Background Pattern
              ...List.generate(3, (index) {
                return Positioned(
                  right: -30 + (index * 20),
                  top: -30 + (index * 20),
                  child: TweenAnimationBuilder(
                    duration: Duration(milliseconds: 1500 + (index * 200)),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.rotate(
                        angle: value * 2 * 3.14,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              // Content Container
              Container(
                padding: EdgeInsets.all(isLarge ? 24 : 16),
                child: isLarge
                    ? _buildLargeCardContent(title, courses, icon)
                    : _buildSmallCardContent(title, courses, icon),
              ),
              // Shine Effect
              Positioned(
                left: -100,
                top: 0,
                bottom: 0,
                width: 100,
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1500),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(value * 200, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0),
                            ],
                          ),
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
    );
  }

  Widget _buildLargeCardContent(String title, String courses, IconData icon) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle_outlined,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$courses Courses',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCardContent(String title, String courses, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_circle_outlined,
                color: Colors.white.withOpacity(0.9),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '$courses Courses',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExamTypeToggle() {
    if (!_isGovernmentSelected) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAllExams = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isAllExams
                        ? [kAccentOrange, kAccentOrange.withOpacity(0.8)]
                        : [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _isAllExams
                          ? kAccentOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    if (_isAllExams)
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Icon(
                          Icons.school_outlined,
                          size: 80,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.library_books_outlined,
                            color: _isAllExams ? Colors.white : kAccentOrange,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'All Exams',
                            style: TextStyle(
                              color:
                                  _isAllExams ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAllExams = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: !_isAllExams
                        ? [kAccentOrange, kAccentOrange.withOpacity(0.8)]
                        : [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: !_isAllExams
                          ? kAccentOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    if (!_isAllExams)
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 80,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            color: !_isAllExams ? Colors.white : kAccentOrange,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'State Exams',
                            style: TextStyle(
                              color:
                                  !_isAllExams ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
        ],
      ),
    );
  }

  Widget _buildMainSection(
      String title, List<String> items, IconData sectionIcon) {
    final Map<String, IconData> itemIcons = {
      // Government Exam Icons
      'SSC Exams': Icons.assignment_outlined,
      'Banking Exams': Icons.account_balance_outlined,
      'Teaching Exams': Icons.school_outlined,
      'Civil Service Exams': Icons.account_balance_wallet_outlined,
      'Railways Exams': Icons.train_outlined,
      'Engineering Requirements': Icons.engineering_outlined,
      'Defence Exams': Icons.security_outlined,
      'State Government Exams': Icons.location_city_outlined,
      'Police Exams': Icons.local_police_outlined,
      'Insurance Exams': Icons.health_and_safety_outlined,
      'Nursing Exams': Icons.medical_services_outlined,
      'Other Government Exams': Icons.more_horiz_outlined,
      'NEET PG Entrance': Icons.healing_outlined,
      'MBA Entrance': Icons.business_center_outlined,
      'CUET': Icons.menu_book_outlined,
      'UGC Entrance': Icons.school_outlined,
      'Accounting & Commerce': Icons.calculate_outlined,
      'Judiciary Exams': Icons.gavel_outlined,
      'Regulatory Body Exams': Icons.policy_outlined,

      // Private Job Icons with unique icons
      'IT/Software': Icons.code_outlined,
      'Marketing': Icons.campaign_outlined,
      'Finance': Icons.trending_up_outlined,
      'HR': Icons.groups_outlined,
      'Sales': Icons.point_of_sale_outlined,
      'Operations': Icons.precision_manufacturing_outlined,
    };

    final allExams = [
      'SSC Exams',
      'Banking Exams',
      'Teaching Exams',
      'Civil Service Exams',
      'Railways Exams',
      'Engineering Requirements',
      'Defence Exams',
      'Police Exams',
      'Insurance Exams',
      'Nursing Exams',
      'NEET PG Entrance',
      'MBA Entrance',
      'CUET',
      'UGC Entrance',
      'Accounting & Commerce',
      'Judiciary Exams',
      'Regulatory Body Exams',
      'Other Government Exams',
      'State Government Exams',
    ];

    final stateExams = [
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chandigarh',
      'Chhattisgarh',
      'Delhi',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jammu and Kashmir',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Mizoram',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
    ];

    // Use the updated list in the build method
    final currentItems = _isGovernmentSelected
        ? (_isAllExams ? allExams : stateExams)
        : [
            'IT/Software',
            'Marketing',
            'Finance',
            'HR',
            'Sales',
            'Operations',
          ];

    // Filter items based on search query
    final filteredItems = currentItems
        .where((item) => item.toLowerCase().contains(_searchQuery))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kCardShadow,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kAccentOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(sectionIcon, color: kAccentOrange, size: 28),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${filteredItems.length} Categories',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSearchBar(),
        const SizedBox(height: 20),
        _buildCategoryLayout(filteredItems, itemIcons),
      ],
    );
  }

  Widget _buildCategoryLayout(
      List<String> items, Map<String, IconData> itemIcons) {
    final List<Color> colors = [
      const Color(0xFF1E88E5),
      const Color(0xFFFF5722),
      const Color(0xFF4CAF50),
      const Color(0xFF9C27B0),
    ];

    // If showing state exams, use a simpler grid layout
    if (!_isAllExams && _isGovernmentSelected) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final stateName = items[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colors[index % colors.length].withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors[index % colors.length].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: colors[index % colors.length],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stateName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
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
      );
    }

    // Keep existing layout for all exams
    return Column(
      children: [
        // Featured Categories (Large Cards)
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length ~/ 2,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildFeaturedCard(
                  items[index],
                  itemIcons[items[index]] ?? Icons.book,
                  colors[index % colors.length],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        // Other Categories (Grid Layout)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items.skip(items.length ~/ 2).map((item) {
            final index = items.indexOf(item);
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 48) / 2,
              child: _buildCompactCard(
                item,
                itemIcons[item] ?? Icons.book,
                colors[index % colors.length],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (title == 'SSC Exams') {
              Navigator.pushNamed(context, '/ssc-exams');
            } else if (title == 'Banking Exams') {
              Navigator.pushNamed(context, '/banking-exams');
            }
          },
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background Pattern
              Positioned(
                right: -40,
                bottom: -40,
                child: Icon(
                  icon,
                  size: 160,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(icon, color: Colors.white, size: 30),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${Random().nextInt(30) + 20} Courses',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to explore courses',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCard(String title, IconData icon, Color color) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  icon,
                  size: 80,
                  color: color.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: color, size: 28),
                    const Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${Random().nextInt(30) + 20} Courses',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwipeablePage(
      currentIndex: 1,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            // Background Design
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                color: const Color.fromRGBO(174, 216, 215, 1),
              ),
            ),
            // Animated Content
            FadeTransition(
              opacity: _fadeAnimation,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom App Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Exam Preparation',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSegmentedControl(),
                    if (_isGovernmentSelected) _buildExamTypeToggle(),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: Container(
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMainSection(
                                  _isGovernmentSelected
                                      ? 'Government Exam Prep'
                                      : 'Private Jobs Prep',
                                  _isGovernmentSelected
                                      ? [
                                          'SSC Exams',
                                          'Banking Exams',
                                          'Teaching Exams',
                                          'Civil Service Exams',
                                          'Railways Exams',
                                          'Engineering Requirements',
                                          'Defence Exams',
                                          'State Government Exams',
                                          'Police Exams',
                                          'Insurance Exams',
                                          'Nursing Exams',
                                          'Other Government Exams',
                                          'NEET PG Entrance',
                                          'MBA Entrance',
                                          'CUET',
                                          'UGC Entrance',
                                          'Accounting & Commerce',
                                          'Judiciary Exams',
                                          'Regulatory Body Exams',
                                        ]
                                      : [
                                          'IT/Software',
                                          'Marketing',
                                          'Finance',
                                          'HR',
                                          'Sales',
                                          'Operations',
                                        ],
                                  _isGovernmentSelected
                                      ? Icons.account_balance
                                      : Icons.business,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
