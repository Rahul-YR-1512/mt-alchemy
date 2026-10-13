import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/course_card.dart';
import '../widgets/section_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _mood = -1;
  final List<Map<String, String>> _moods = const [
    {'emoji': '😊', 'label': 'Great'},
    {'emoji': '🙂', 'label': 'Good'},
    {'emoji': '😐', 'label': 'Okay'},
    {'emoji': '😟', 'label': 'Stressed'},
    {'emoji': '😔', 'label': 'Drained'},
  ];

  void _onMoodTap(int i) {
    setState(() => _mood = i);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Thanks for sharing. We\'ll help you feel ${_moods[i]['label']!.toLowerCase()}.',
        ),
        backgroundColor: AppColors.deepBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'MT Alchemy',
      body: SingleChildScrollView(
        child: PageBody(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _hero(context),
              const SizedBox(height: 24),
              _moodCard(),
              const SizedBox(height: 28),
              const SectionTitle(
                title: 'What We Do',
                subtitle:
                    'Human-centred programmes for individuals and teams.',
              ),
              const SizedBox(height: 14),
              _whatWeDoGrid(),
              const SizedBox(height: 28),
              SectionTitle(
                title: 'Popular courses',
                subtitle: 'Learn at your own pace.',
                trailing: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.upskilling),
                  child: const Text('See all'),
                ),
              ),
              const SizedBox(height: 14),
              _coursesRow(),
              const SizedBox(height: 28),
              _impactBanner(),
              const SizedBox(height: 20),
              _ctaCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepBlue, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/hero_home.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.deepBlue.withValues(alpha: 0.94),
                      AppColors.purple.withValues(alpha: 0.84),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTagSmall(),
                  const SizedBox(height: 16),
                  Text(
                    'Elevate your value: Master human intelligence in a rapidly evolving AI-driven world',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'We don\'t just run activities. We shift mindsets, behaviours, and team culture.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      YellowButton(
                        label: 'I\'m an Individual',
                        icon: Icons.person_outline,
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.register,
                            arguments: false),
                      ),
                      WhiteButton(
                        label: 'I\'m an Employer',
                        icon: Icons.business_center_outlined,
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.employerDashboard),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodCard() {
    return CalmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling today?',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your well-being matters. Check in with yourself.',
            style: GoogleFonts.inter(
              fontSize: 12.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_moods.length, (i) {
              final selected = _mood == i;
              return GestureDetector(
                onTap: () => _onMoodTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 58,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.yellow : AppColors.lavender,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.yellowDark
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(_moods[i]['emoji']!,
                          style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 4),
                      Text(
                        _moods[i]['label']!,
                        style: GoogleFonts.inter(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _whatWeDoGrid() {
    final services = [
      ('Well-being Assessment', Icons.health_and_safety_outlined),
      ('EQ & Mindfulness', Icons.self_improvement_outlined),
      ('Leadership & Communication', Icons.groups_outlined),
      ('Team Building', Icons.handshake_outlined),
      ('CSR & ESG', Icons.volunteer_activism_outlined),
      ('Customized Programmes', Icons.category_outlined),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 560 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, i) {
            final s = services[i];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.services),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.deepBlue.withValues(alpha: 0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: AppColors.lavender,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(s.$2,
                          color: AppColors.deepBlue, size: 20),
                    ),
                    const Spacer(),
                    Text(
                      s.$1,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _coursesRow() {
    return SizedBox(
      height: 372,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: SampleData.courses.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final course = SampleData.courses[i];
          return SizedBox(
            width: 280,
            child: CourseCard(
              course: course,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.courseDetail,
                arguments: course,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _impactBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.deepBlue],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_outlined,
              color: AppColors.yellow, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1,100+ participants impacted',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Across Malaysia and the region.',
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaCard(BuildContext context) {
    return CalmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s build a thriving workplace together',
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Talk to us about your people-development goals — no obligation.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          YellowButton(
            label: 'Get a Free Consultation',
            icon: Icons.chat_bubble_outline,
            onPressed: () => Navigator.pushNamed(context, Routes.contact),
          ),
        ],
      ),
    );
  }
}

/// Small white pill used inside the hero.
class AppTagSmall extends StatelessWidget {
  const AppTagSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.yellow, size: 14),
          const SizedBox(width: 6),
          Text(
            'Human intelligence, reimagined',
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}