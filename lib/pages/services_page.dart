import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/section_title.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Services',
      body: SingleChildScrollView(
        child: PageBody(
          maxWidth: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionTitle(
                title: 'What we do',
                subtitle:
                    'Programmes designed around people — not one-size-fits-all activities.',
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoCol = constraints.maxWidth > 560;
                  final items = SampleData.services;
                  return Column(
                    children: List.generate(items.length, (i) {
                      final card = _serviceCard(items[i], context);
                      if (twoCol && i.isOdd) {
                        return SizedBox.shrink();
                      }
                      if (twoCol && i % 2 == 0) {
                        if (i + 1 < items.length) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(child: card),
                                const SizedBox(width: 16),
                                Expanded(child: _serviceCard(items[i + 1], context)),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: card,
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: card,
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(ServiceItem s, BuildContext context) {
    return CalmCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientImage(
            gradient: s.gradient,
            imagePath: s.imagePath,
            height: 96,
            borderRadius: 24,
            icon: s.icon,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  s.description,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    height: 1.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lavender,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.support_agent,
                          size: 16, color: AppColors.lavenderText),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Who it's for: ${s.forWho}",
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            height: 1.4,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.contact),
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Enquire'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}