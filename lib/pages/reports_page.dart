import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';
import '../widgets/team_table.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  static const Map<String, double> _departments = {
    'HR': 80,
    'Finance': 100,
    'Sales': 45,
    'Management': 0,
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Reports',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle(
                title: 'Department Performance',
                subtitle: 'Average course completion by department.',
              ),
              const SizedBox(height: 14),
              CalmCard(
                child: Column(
                  children: _departments.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 96,
                            child: Text(
                              e.key,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                value: e.value / 100,
                                minHeight: 12,
                                backgroundColor: AppColors.lavender,
                                valueColor:
                                    const AlwaysStoppedAnimation(
                                        AppColors.deepBlue),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 40,
                            child: Text(
                              '${e.value.toStringAsFixed(0)}%',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Individual Performance',
                subtitle: 'Progress and status for every learner.',
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 720,
                  child: const TeamProgressTable(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _notify(context, 'Exporting PDF report…'),
                      icon: const Icon(Icons.picture_as_pdf_outlined,
                          size: 18),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      label: const Text('Export PDF'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: YellowButton(
                      label: 'Export CSV',
                      icon: Icons.table_chart_outlined,
                      expand: true,
                      onPressed: () => _notify(context, 'Exporting CSV report…'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _notify(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.deepBlue,
      ),
    );
  }
}