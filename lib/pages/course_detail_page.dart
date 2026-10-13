import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  void _enrol(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          'Confirm enrolment',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Pay RM${course.price.toStringAsFixed(0)} to enrol in this course?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              AppState.instance.enrol(course);
              Navigator.pop(dialogContext);
              Navigator.pushNamed(context, Routes.coursePlayer,
                  arguments: course);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellow,
              foregroundColor: AppColors.deepBlue,
            ),
            child: Text('Pay RM${course.price.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Course Detail',
      bottomNavigationBar: _bottomBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            PageBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${course.rating} (${course.ratingCount} reviews)',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    course.description,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      height: 1.55,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      AppTag(
                          label: course.instructor,
                          icon: Icons.person_outline),
                      AppTag(
                          label: '${course.hours} hours',
                          icon: Icons.schedule),
                      AppTag(
                          label: '${course.moduleCount} modules',
                          icon: Icons.view_agenda_outlined),
                      AppTag(label: course.level, icon: Icons.signal_cellular_alt),
                      if (course.certificate)
                        AppTag(
                          label: 'Certificate',
                          icon: Icons.workspace_premium_outlined),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'What you\'ll learn',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...course.objectives.map(
                    (o) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppColors.greenSoft,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check,
                                size: 15, color: AppColors.green),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              o,
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                height: 1.45,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Curriculum',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CalmCard(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: List.generate(course.modules.length, (i) {
                        final m = course.modules[i];
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 34,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.lavender,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${i + 1}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.deepBlue,
                                  ),
                                ),
                              ),
                              title: Text(
                                m.title,
                                style: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                              trailing: Icon(
                                i < course.moduleCount && !m.locked
                                    ? Icons.play_circle_outline
                                    : Icons.lock_outline,
                                color: m.locked
                                    ? AppColors.textMuted
                                    : AppColors.deepBlue,
                                size: 20,
                              ),
                            ),
                            if (i < course.modules.length - 1)
                              const Divider(height: 1, indent: 16, endIndent: 16),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: course.gradient,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTag(
            label: course.category,
            background: Colors.white.withValues(alpha: 0.9),
            textColor: AppColors.deepBlue,
          ),
          const SizedBox(height: 14),
          Text(
            course.tagline,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  'RM${course.price.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepBlue,
                  ),
                ),
              ],
            ),
            const Spacer(),
            YellowButton(
              label: 'Enrol Now',
              icon: Icons.shopping_bag_outlined,
              onPressed: () => _enrol(context),
            ),
          ],
        ),
      ),
    );
  }
}