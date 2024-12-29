
import 'package:flutter/material.dart';
import 'package:myapp/Profile.dart';
import 'package:myapp/Report.dart';
import 'package:myapp/change_password.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/pages/auth/welcome_screen.dart';
import 'package:myapp/transaction_page.dart';
import 'package:myapp/widgets/bottom_navigation_bar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Management',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/home': (context) => const MainScreen(initialIndex: 0),
        '/transactions': (context) => MainScreen(initialIndex: 1),
        '/reports': (context) => MainScreen(initialIndex: 2),
        '/profile': (context) => MainScreen(initialIndex: 3),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, required this.initialIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pages = [
    
      const HomePage(),
      const TransactionPage(),
      const ReportsPage(),
      ProfileScreen(), // We'll create this class in Profile.dart
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Budget Manager',
          style:
              TextStyle(color: Colors.purple[700], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: _pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onPageChanged,
      ),
    );
  }
}
