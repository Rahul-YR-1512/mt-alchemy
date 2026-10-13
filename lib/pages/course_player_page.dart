import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

class CoursePlayerPage extends StatefulWidget {
  final Course course;

  const CoursePlayerPage({super.key, required this.course});

  @override
  State<CoursePlayerPage> createState() => _CoursePlayerPageState();
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  int _currentModule = 3; // 1-based, demo starts at module 3
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Course Player',
      bottomNavigationBar: _bottomBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _video(),
            PageBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _progressCard(),
                  const SizedBox(height: 20),
                  Text(
                    'Modules',
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
                      children: List.generate(5, (i) {
                        final n = i + 1;
                        final isDone = n < 3;
                        final isCurrent = n == 3;
                        return ListTile(
                          onTap: () => setState(() => _currentModule = n),
                          leading: Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppColors.greenSoft
                                  : isCurrent
                                      ? AppColors.yellow
                                      : AppColors.lavender,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: isDone
                                ? const Icon(Icons.check,
                                    size: 18, color: AppColors.green)
                                : Text(
                                    '$n',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: isCurrent
                                          ? AppColors.deepBlue
                                          : AppColors.lavenderText,
                                    ),
                                  ),
                          ),
                          title: Text(
                            _moduleTitle(n),
                            style: GoogleFonts.inter(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          subtitle: Text(
                            isDone
                                ? 'Completed'
                                : isCurrent
                                    ? 'Now playing'
                                    : 'Not started',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: isCurrent
                                  ? AppColors.deepBlue
                                  : AppColors.textMuted,
                            ),
                          ),
                          trailing: Icon(
                            isDone
                                ? Icons.check_circle
                                : isCurrent
                                    ? Icons.play_circle_fill
                                    : Icons.radio_button_unchecked,
                            color: isDone
                                ? AppColors.green
                                : isCurrent
                                    ? AppColors.deepBlue
                                    : AppColors.textMuted,
                            size: 22,
                          ),
                        );
                      }),
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

  String _moduleTitle(int n) {
    const titles = [
      'Introduction to Emotional Intelligence',
      'Self-Awareness',
      'Self-Regulation',
      'Empathy in Action',
      'Building Positive Connections',
    ];
    return titles[n - 1];
  }

  Widget _video() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF141062), AppColors.deepBlue],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Playing module video…'),
                backgroundColor: AppColors.deepBlue,
              ),
            ),
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: AppColors.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: AppColors.deepBlue, size: 40),
            ),
          ),
        ),
      ),
    );
  }

  Widget _progressCard() {
    return CalmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Module 3 · Self-Regulation',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course Progress',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                '65%',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 9,
              backgroundColor: AppColors.lavender,
              valueColor:
                  const AlwaysStoppedAnimation(AppColors.deepBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar() {
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
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() {
                  if (_currentModule > 1) _currentModule--;
                }),
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Previous',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _completed = !_completed);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Module marked complete'),
                      backgroundColor: AppColors.deepBlue,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  foregroundColor: AppColors.deepBlue,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  _completed ? 'Completed ✓' : 'Mark Complete',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() {
                  if (_currentModule < 5) _currentModule++;
                }),
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Next',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}