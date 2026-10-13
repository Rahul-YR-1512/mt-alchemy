import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';
import '../widgets/stat_card.dart';
import '../widgets/team_table.dart';

class EmployerDashboardPage extends StatelessWidget {
  const EmployerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Employer Dashboard',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.deepBlue, AppColors.purple],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.business_center_outlined,
                        color: AppColors.yellow, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organization',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          Text(
                            'ABC Sdn Bhd',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _stats(),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Quick actions'),
              const SizedBox(height: 12),
              _quickActions(context),
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Team Progress',
                subtitle: 'Track assigned learning across the team.',
              ),
              const SizedBox(height: 12),
              _scrollableTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stats() {
    final stats = [
      ('4', 'Total Employees', Icons.groups_outlined, AppColors.deepBlue),
      ('3', 'Active Learners', Icons.school_outlined, AppColors.purple),
      ('3', 'Courses Assigned', Icons.menu_book_outlined, AppColors.amber),
      ('25%', 'Completion Rate', Icons.trending_up, AppColors.green),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: columns == 4 ? 1.05 : 1.2,
          children: stats
              .map((s) => StatCard(
                    value: s.$1,
                    label: s.$2,
                    icon: s.$3,
                    color: s.$4,
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _quickActions(BuildContext context) {
    final actions = [
      ('Add Employee', Icons.person_add_alt,
          () => Navigator.pushNamed(context, Routes.addEmployee)),
      ('Assign Course', Icons.assignment_turned_in_outlined,
          () => Navigator.pushNamed(context, Routes.assignCourse)),
      ('View Reports', Icons.bar_chart_outlined,
          () => Navigator.pushNamed(context, Routes.reports)),
      ('Purchase Courses', Icons.storefront_outlined,
          () => Navigator.pushNamed(context, Routes.store)),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: actions
              .map((a) => CalmCard(
                    onTap: a.$3,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: AppColors.lavender,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(a.$2,
                              color: AppColors.deepBlue, size: 22),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          a.$1,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _scrollableTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 720,
        child: const TeamProgressTable(),
      ),
    );
  }
}