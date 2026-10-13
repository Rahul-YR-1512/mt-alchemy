import 'package:flutter/material.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MtAlchemyApp());
}

class MtAlchemyApp extends StatelessWidget {
  const MtAlchemyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MT Alchemy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: Routes.home,
      onGenerateRoute: generateRoute,
    );
  }
}