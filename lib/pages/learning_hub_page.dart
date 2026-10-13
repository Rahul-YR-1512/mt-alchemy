import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/course_card.dart';

class LearningHubPage extends StatefulWidget {
  const LearningHubPage({super.key});

  @override
  State<LearningHubPage> createState() => _LearningHubPageState();
}

class _LearningHubPageState extends State<LearningHubPage> {
  static const _filters = [
    'All',
    'Emotional Intelligence',
    'Mindfulness',
    'Leadership',
    'Communication',
  ];
  String _filter = 'All';
  String _query = '';

  List<Course> get _visible {
    return SampleData.courses.where((c) {
      final matchesFilter = _filter == 'All' || c.category == _filter;
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          c.title.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final courses = _visible;
    return AppScaffold(
      title: 'Upskilling',
      body: SingleChildScrollView(
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Learn. Apply. Grow.',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Practical courses in emotional intelligence, mindfulness, leadership and communication.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search courses',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final f = _filters[i];
                    final selected = f == _filter;
                    return ChoiceChip(
                      label: Text(f),
                      selected: selected,
                      showCheckmark: false,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : AppColors.deepBlue,
                      ),
                      backgroundColor: AppColors.lavender,
                      selectedColor: AppColors.deepBlue,
                      shape: const StadiumBorder(),
                      onSelected: (_) => setState(() => _filter = f),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              if (courses.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'No courses match your search.',
                      style: GoogleFonts.inter(color: AppColors.textMuted),
                    ),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth > 640 ? 2 : 1;
                    if (columns == 1) {
                      return Column(
                        children: courses
                            .map((c) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 16),
                                  child: CourseCard(
                                    course: c,
                                    onTap: () => _open(c),
                                  ),
                                ))
                            .toList(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, i) => CourseCard(
                        course: courses[i],
                        onTap: () => _open(courses[i]),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _open(Course c) {
    Navigator.pushNamed(context, Routes.courseDetail, arguments: c);
  }
}