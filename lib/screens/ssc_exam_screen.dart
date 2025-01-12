import 'package:flutter/material.dart';
import '../models/test_model.dart';

const Color kPrimaryBlue = Color(0xFF2B4865);
const Color kBackgroundColor = Color(0xFFF5F5F5);

class SSCExamScreen extends StatefulWidget {
  const SSCExamScreen({super.key});

  @override
  State<SSCExamScreen> createState() => _SSCExamScreenState();
}

class _SSCExamScreenState extends State<SSCExamScreen> {
  // Set to store selected exam titles
  final Set<String> selectedExams = {};
  // Add search controller and query state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Categorized exam data
  final Map<String, List<Map<String, dynamic>>> examCategories = const {
    'Popular Exams': [
      {
        'title': 'SSC CGL',
        'subtitle': 'Combined Graduate Level',
        'icon': Icons.assignment_outlined,
        'color': Color(0xFF1E88E5),
      },
      {
        'title': 'SSC CHSL',
        'subtitle': 'Combined Higher Secondary Level',
        'icon': Icons.school_outlined,
        'color': Color(0xFF43A047),
      },
      {
        'title': 'SSC CPO',
        'subtitle': 'Central Police Organization',
        'icon': Icons.local_police_outlined,
        'color': Color(0xFF5E35B1),
      },
      {
        'title': 'SSC MTS',
        'subtitle': 'Multi Tasking Staff',
        'icon': Icons.work_outline,
        'color': Color(0xFFE53935),
      },
    ],
    'Police & Security': [
      {
        'title': 'SSC GD Constable',
        'subtitle': 'General Duty Constable',
        'icon': Icons.security_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'Delhi Police Constable',
        'subtitle': 'Physical & Written Test',
        'icon': Icons.local_police_outlined,
        'color': Color(0xFF546E7A),
      },
      {
        'title': 'SSC Head Constable AWO',
        'subtitle': 'Assistant Wireless Operator',
        'icon': Icons.settings_input_antenna,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'Delhi Police Driver',
        'subtitle': 'Physical & Driving Test',
        'icon': Icons.drive_eta_outlined,
        'color': Color(0xFF00897B),
      },
    ],
    'Intelligence Bureau': [
      {
        'title': 'IB ACIO',
        'subtitle': 'Assistant Central Intelligence Officer',
        'icon': Icons.security_outlined,
        'color': Color(0xFF8E24AA),
      },
      {
        'title': 'IB Security Assistant',
        'subtitle': 'Intelligence Bureau',
        'icon': Icons.admin_panel_settings_outlined,
        'color': Color(0xFFC0CA33),
      },
    ],
    'Engineering': [
      {
        'title': 'SSC JE CE',
        'subtitle': 'Junior Engineer (Civil)',
        'icon': Icons.architecture_outlined,
        'color': Color(0xFF00ACC1),
      },
      {
        'title': 'SSC JE EE',
        'subtitle': 'Junior Engineer (Electrical)',
        'icon': Icons.electrical_services_outlined,
        'color': Color(0xFFFF7043),
      },
      {
        'title': 'SSC JE ME',
        'subtitle': 'Junior Engineer (Mechanical)',
        'icon': Icons.engineering_outlined,
        'color': Color(0xFF7CB342),
      },
      {
        'title': 'RSMSSB JE',
        'subtitle': 'Rajasthan JE Recruitment',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF8D6E63),
      },
    ],
    'Other Exams': [
      {
        'title': 'SSC Selection Post',
        'subtitle': 'Various Posts',
        'icon': Icons.people_outline,
        'color': Color(0xFF26A69A),
      },
      {
        'title': 'SSC Stenographer',
        'subtitle': 'Grade C & D',
        'icon': Icons.record_voice_over_outlined,
        'color': Color(0xFFD81B60),
      },
      {
        'title': 'SSC JHT',
        'subtitle': 'Junior Hindi Translator',
        'icon': Icons.translate_outlined,
        'color': Color(0xFF7B1FA2),
      },
      {
        'title': 'Delhi Police MTS',
        'subtitle': 'Multi Tasking Staff',
        'icon': Icons.work_outline,
        'color': Color(0xFF5D4037),
      },
    ],
    'Special Exams': [
      {
        'title': 'CSIR ASO',
        'subtitle': 'Administrative Staff Officer',
        'icon': Icons.science_outlined,
        'color': Color(0xFF00897B),
      },
      {
        'title': 'SSC Scientific Assistant',
        'subtitle': 'Technical Posts',
        'icon': Icons.biotech_outlined,
        'color': Color(0xFF3949AB),
      },
      {
        'title': 'Supreme Court Junior Court',
        'subtitle': 'Assistant & Other Posts',
        'icon': Icons.gavel_outlined,
        'color': Color(0xFF6D4C41),
      },
      {
        'title': 'Delhi Forest Guard',
        'subtitle': 'Physical & Written Test',
        'icon': Icons.forest_outlined,
        'color': Color(0xFF2E7D32),
      },
    ],
    'Research & Education': [
      {
        'title': 'ICMR Assistant',
        'subtitle': 'Research & Technical Posts',
        'icon': Icons.health_and_safety_outlined,
        'color': Color(0xFFC2185B),
      },
      {
        'title': 'NBE NTA',
        'subtitle': 'National Testing Agency',
        'icon': Icons.school_outlined,
        'color': Color(0xFF1565C0),
      },
      {
        'title': 'Delhi University',
        'subtitle': 'Non-Teaching Posts',
        'icon': Icons.account_balance_outlined,
        'color': Color(0xFF4527A0),
      },
    ],
    'Study Material': [
      {
        'title': 'Current Affairs',
        'subtitle': 'Daily Updates & News',
        'icon': Icons.newspaper_outlined,
        'color': Color(0xFF00ACC1),
      },
    ],
  };

  // Add method to filter exams based on search query
  Map<String, List<Map<String, dynamic>>> get filteredExamCategories {
    if (_searchQuery.isEmpty) {
      return examCategories;
    }

    Map<String, List<Map<String, dynamic>>> filtered = {};

    examCategories.forEach((category, exams) {
      final filteredExams = exams.where((exam) {
        final title = exam['title'].toString().toLowerCase();
        final subtitle = exam['subtitle'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || subtitle.contains(query);
      }).toList();

      if (filteredExams.isNotEmpty) {
        filtered[category] = filteredExams;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: selectedExams.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(right: 16, bottom: 16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: 0.5 + (0.5 * value),
                              child: Opacity(
                                opacity: value,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.8,
                                  ),
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Header
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: kPrimaryBlue.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${selectedExams.length}',
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryBlue,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Exams Selected',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Scrollable content
                                      Flexible(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...selectedExams.map((exam) {
                                                final examData = examCategories
                                                    .values
                                                    .expand((exams) => exams)
                                                    .firstWhere(
                                                      (e) => e['title'] == exam,
                                                      orElse: () => examCategories[
                                                          'Popular Exams']![0],
                                                    );
                                                return AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: (examData['color']
                                                            as Color)
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        examData['icon']
                                                            as IconData,
                                                        color: examData['color']
                                                            as Color,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              exam,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              examData[
                                                                      'subtitle']
                                                                  as String,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Action button
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/test',
                                              arguments: TestModel(
                                                title: 'SSC Practice Test',
                                                questions: [
                                                  Question(
                                                    id: '1',
                                                    questionText:
                                                        'Sample Question 1?',
                                                    correctOptionId: 'a',
                                                    options: [
                                                      Option(
                                                          id: 'a',
                                                          text: 'Option A'),
                                                      Option(
                                                          id: 'b',
                                                          text: 'Option B'),
                                                      Option(
                                                          id: 'c',
                                                          text: 'Option C'),
                                                      Option(
                                                          id: 'd',
                                                          text: 'Option D'),
                                                    ],
                                                  ),
                                                  // Add more sample questions as needed
                                                ],
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF2B4865),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Start Preparation',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryBlue),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Prepare Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${selectedExams.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          // Decorative background elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryBlue.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryBlue.withOpacity(0.15),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar with search
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black87,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Text(
                              'SSC Exams',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search exams...',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 16),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                            if (_searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                color: Colors.grey[400],
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                    _searchController.clear();
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content with Categories
                Expanded(
                  child: filteredExamCategories.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search_off_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No exams found for "$_searchQuery"',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredExamCategories.length,
                          itemBuilder: (context, index) {
                            String category =
                                filteredExamCategories.keys.elementAt(index);
                            List<Map<String, dynamic>> exams =
                                filteredExamCategories.values.elementAt(index);
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
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            child: _buildFeaturedCard(
              exams[index]['title'],
              exams[index]['subtitle'],
              exams[index]['icon'],
              exams[index]['color'],
            ),
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

  Widget _buildFeaturedCard(
      String title, String subtitle, IconData icon, Color color) {
    final bool isSelected = selectedExams.contains(title);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            isSelected ? color : color.withOpacity(0.8),
          ],
          stops: const [0.2, 0.8],
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
          borderRadius: BorderRadius.circular(24),
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
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  icon,
                  size: 120,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Icon(
                      Icons.check,
                      color: color,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCard(
      String title, String subtitle, IconData icon, Color color) {
    final bool isSelected = selectedExams.contains(title);

    return Container(
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
              Positioned(
                right: -15,
                bottom: -15,
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
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
              if (isSelected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
