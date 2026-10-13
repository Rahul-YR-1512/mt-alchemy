import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Insights',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle(
                title: 'Insights & stories',
                subtitle: 'Articles, guides and videos on EQ, leadership and well-being.',
              ),
              const SizedBox(height: 14),
              ...SampleData.articles.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _articleCard(context, a),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _articleCard(BuildContext context, InsightArticle a) {
    Color typeColor;
    IconData typeIcon;
    switch (a.type) {
      case 'Guide':
        typeColor = AppColors.green;
        typeIcon = Icons.menu_book_outlined;
      case 'Video':
        typeColor = AppColors.purple;
        typeIcon = Icons.play_circle_outline;
      default:
        typeColor = AppColors.deepBlue;
        typeIcon = Icons.article_outlined;
    }
    return CalmCard(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening: ${a.title}'),
          backgroundColor: AppColors.deepBlue,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppTag(label: a.type, icon: typeIcon, textColor: typeColor),
              const Spacer(),
              Text(
                '${a.readMins} min read',
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            a.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            a.summary,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              height: 1.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AppTag(label: a.category),
              const Spacer(),
              Text(
                a.date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}