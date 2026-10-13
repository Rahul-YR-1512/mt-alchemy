import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';

/// Reusable page shell: deep-blue AppBar (MT logo, title, cart, profile)
/// plus the standard navigation Drawer.
class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? bottom;
  final Widget? bottomNavigationBar;
  final bool showCart;
  final bool showProfile;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.bottom,
    this.bottomNavigationBar,
    this.showCart = true,
    this.showProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          child: Builder(
            builder: (context) => _MtLogo(
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        actions: [
          if (showCart)
            ListenableBuilder(
              listenable: AppState.instance,
              builder: (context, _) {
                final count = AppState.instance.cartCount;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      tooltip: 'Cart',
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.cart),
                    ),
                    if (count > 0)
                      Positioned(
                        right: 6,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.yellow,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$count',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.deepBlue,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          if (showProfile)
            IconButton(
              icon: const Icon(Icons.person_outline),
              tooltip: 'Account',
              onPressed: () => Navigator.pushNamed(context, Routes.login),
            ),
          const SizedBox(width: 4),
        ],
        bottom: bottom,
      ),
      drawer: const AppDrawer(),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}

class _MtLogo extends StatelessWidget {
  final VoidCallback onTap;

  const _MtLogo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.yellow,
          shape: BoxShape.circle,
        ),
        child: Text(
          'MT',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.deepBlue,
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<_DrawerEntry> _entries = [
    _DrawerEntry('Home', Icons.home_outlined, Routes.home),
    _DrawerEntry('About', Icons.info_outline, Routes.about),
    _DrawerEntry('Services', Icons.workspaces_outline, Routes.services),
    _DrawerEntry('Upskilling', Icons.school_outlined, Routes.upskilling),
    _DrawerEntry('Store', Icons.storefront_outlined, Routes.store),
    _DrawerEntry('Insights', Icons.article_outlined, Routes.insights),
    _DrawerEntry('Contact', Icons.mail_outline, Routes.contact),
    _DrawerEntry('Cart', Icons.shopping_cart_outlined, Routes.cart),
    _DrawerEntry('Login', Icons.login, Routes.login),
    _DrawerEntry('Register', Icons.person_add_alt, Routes.register),
    _DrawerEntry(
        'Employer Dashboard', Icons.dashboard_outlined,
        Routes.employerDashboard),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.deepBlue, AppColors.purple],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          color: AppColors.yellow,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'MT',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'MT Alchemy',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We don\'t just run activities. We shift mindsets, behaviours, and team culture.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final e = _entries[index];
                  return ListTile(
                    leading: Icon(e.icon, color: AppColors.deepBlue),
                    title: Text(
                      e.label,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, e.route);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerEntry {
  final String label;
  final IconData icon;
  final String route;

  const _DrawerEntry(this.label, this.icon, this.route);
}