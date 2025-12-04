import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/courses_page.dart';
import 'package:flutter_application_1/feed_page.dart';
import 'package:flutter_application_1/progress_page.dart';
import 'package:flutter_application_1/settings_page.dart';
import 'package:flutter_application_1/tests_page.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/liquid_nav_bar.dart';
import 'styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.changeLanguage});
  final void Function(Locale locale) changeLanguage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _controller;
  late final AnimationController _navBarAnimationController;
  late final Animation<Offset> _navBarAnimation;
  late final List<Widget> _widgetOptions;
  bool _isSettingsInEditMode = false;

  void _handleSettingsEditModeChange(bool isEditing) {
    setState(() {
      _isSettingsInEditMode = isEditing;
      if (_isSettingsInEditMode) {
        _navBarAnimationController.forward();
      } else {
        _navBarAnimationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _navBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _navBarAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(CurvedAnimation(
      parent: _navBarAnimationController,
      curve: Curves.easeInOut,
    ));

    _widgetOptions = <Widget>[
      const FeedPage(),
      const CoursesPage(),
      const TestsPage(),
      const ProgressPage(),
      SettingsPage(changeLanguage: widget.changeLanguage, onEditModeChange: _handleSettingsEditModeChange),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _navBarAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _widgetOptions.elementAt(_selectedIndex),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _navBarAnimation,
              child: _buildLiquidBottomNavBar(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLiquidBottomNavBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final navItems = [
      {'icon': Icons.home, 'label': l10n.bottomNavFeed},
      {'icon': Icons.school, 'label': l10n.bottomNavCourses},
      {'icon': Icons.assignment, 'label': l10n.bottomNavTests},
      {'icon': Icons.show_chart, 'label': l10n.bottomNavProgress},
      {'icon': Icons.settings, 'label': l10n.bottomNavSettings},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        height: 70,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GlassmorphicContainer(
              width: double.infinity,
              height: 70,
              borderRadius: 35,
              blur: 7,
              alignment: Alignment.center,
              border: 1,
              linearGradient: kAnimatedGradient(_controller.value),
              borderGradient: kAppBarBorderGradient,
              child: const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: LiquidNavBar(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: navItems,
                selectedItemColor: kBottomNavSelectedItemColor,
                unselectedItemColor: kBottomNavUnselectedItemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
