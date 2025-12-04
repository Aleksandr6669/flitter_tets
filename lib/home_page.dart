import 'dart:async';

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
import 'package:flutter_application_1/profile_service.dart';
import 'styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.changeLanguage});
  final void Function(Locale locale) changeLanguage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _widgetIndex = 0;
  late final AnimationController _controller;
  late final AnimationController _navBarAnimationController;
  late final Animation<Offset> _navBarAnimation;

  bool _isSettingsInEditMode = false;
  bool _showStories = true;

  final _profileService = ProfileService();
  StreamSubscription? _profileSubscription;

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

    _loadProfileSettings();
  }

  void _loadProfileSettings() {
    _profileSubscription = _profileService.getUserProfile().listen((userProfile) {
      if (mounted && userProfile.exists) {
        final data = userProfile.data() as Map<String, dynamic>;
        // Use a default value of true if the setting doesn't exist.
        final showStories = data['showStories'] as bool? ?? true;
        if (showStories != _showStories) {
          setState(() {
            _showStories = showStories;
          });
        }
      }
    });
  }

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

  void _handleShowStoriesChange(bool show) {
    setState(() {
      _showStories = show;
    });
    _profileService.updateUserProfile({'showStories': show});
  }

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _controller.dispose();
    _navBarAnimationController.dispose();
    _profileSubscription?.cancel();
    super.dispose();
  }

  void _onItemTapped(int navBarIndex) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_showStories) {
        _widgetIndex = navBarIndex;
      } else {
        _widgetIndex = navBarIndex + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final navItems = _getNavItems(context);

    final List<Widget> widgetOptions = <Widget>[
      const FeedPage(),
      const CoursesPage(),
      const TestsPage(),
      const ProgressPage(),
      SettingsPage(
        changeLanguage: widget.changeLanguage,
        onEditModeChange: _handleSettingsEditModeChange,
        initialShowStories: _showStories,
        onShowStoriesChanged: _handleShowStoriesChange,
      ),
    ];

    int navBarIndex;
    if (_showStories) {
      navBarIndex = _widgetIndex;
    } else {
      navBarIndex = _widgetIndex > 0 ? _widgetIndex - 1 : 0;
    }

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
          IndexedStack(
            index: _widgetIndex,
            children: widgetOptions,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _navBarAnimation,
              child: _buildLiquidBottomNavBar(context, navItems, navBarIndex),
            ),
          )
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getNavItems(BuildContext context) {
    return [
      if (_showStories) {'icon': Icons.home, 'label': l10n.bottomNavFeed},
      {'icon': Icons.school, 'label': l10n.bottomNavCourses},
      {'icon': Icons.assignment, 'label': l10n.bottomNavTests},
      {'icon': Icons.show_chart, 'label': l10n.bottomNavProgress},
      {'icon': Icons.settings, 'label': l10n.bottomNavSettings},
    ];
  }

  Widget _buildLiquidBottomNavBar(
      BuildContext context, List<Map<String, dynamic>> navItems, int navBarIndex) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GlassmorphicContainer(
              width: double.infinity,
              height: 50,
              borderRadius: 25,
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
                selectedIndex: navBarIndex,
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
