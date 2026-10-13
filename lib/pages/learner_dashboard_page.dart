import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';
import '../widgets/stat_card.dart';

class LearnerDashboardPage extends StatelessWidget {
  const LearnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'My Learning',
      body: SingleChildScrollView(
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome, Rahul',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Keep the momentum going.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 18),
              _stats(),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Continue Learning'),
              const SizedBox(height: 12),
              _continueCard(context),
              const SizedBox(height: 24),
              const SectionTitle(title: 'My Orders'),
              const SizedBox(height: 12),
              _ordersCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stats() {
    final stats = [
      ('1', 'Courses Enrolled', Icons.menu_book_outlined, AppColors.deepBlue),
      ('1', 'In Progress', Icons.play_circle_outline, AppColors.purple),
      ('0', 'Certificates', Icons.workspace_premium_outlined,
          AppColors.amber),
      ('3.9', 'Learning Hours', Icons.schedule, AppColors.green),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 560 ? 4 : 2;
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

  Widget _continueCard(BuildContext context) {
    final course = SampleData.courses.first;
    return CalmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppTag(label: course.category),
              const Spacer(),
              Text(
                '65%',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            course.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Up next · Module 3 · Self-Regulation',
            style: GoogleFonts.inter(
              fontSize: 12.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 9,
              backgroundColor: AppColors.lavender,
              valueColor: const AlwaysStoppedAnimation(AppColors.deepBlue),
            ),
          ),
          const SizedBox(height: 16),
          YellowButton(
            label: 'Continue Course',
            icon: Icons.play_arrow_rounded,
            expand: true,
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.coursePlayer,
              arguments: course,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ordersCard(BuildContext context) {
    final orders = AppState.instance.orders;
    return CalmCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          ...orders.map((o) => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.lavender,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.receipt_long_outlined,
                      color: AppColors.deepBlue, size: 20),
                ),
                title: Text(
                  '#${o.id}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Text(
                  'RM${o.amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
                trailing: _statusTag(o.status),
              )),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.download_outlined,
                color: AppColors.deepBlue),
            title: Text(
              'My Digital Products',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: AppColors.deepBlue,
              ),
            ),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.deepBlue),
            onTap: () =>
                Navigator.pushNamed(context, Routes.myDigitalProducts),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(String status) {
    Color bg;
    Color fg;
    switch (status) {
      case 'Paid':
      case 'Completed':
        bg = AppColors.greenSoft;
        fg = AppColors.green;
        break;
      case 'Shipped':
        bg = AppColors.lavender;
        fg = AppColors.lavenderText;
        break;
      default:
        bg = const Color(0xFFFFF3D6);
        fg = AppColors.amber;
    }
    return AppTag(label: status, background: bg, textColor: fg);
  }
}