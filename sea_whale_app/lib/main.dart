import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/shop_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SeaWhaleApp());
}

class SeaWhaleApp extends StatelessWidget {
  const SeaWhaleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShopProvider()),
      ],
      child: MaterialApp(
        title: 'Sea Whale Transport',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.luxuryDarkTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
