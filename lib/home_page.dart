import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/feed_page.dart';
import 'package:flutter_application_1/profile_page.dart';
import 'package:flutter_application_1/settings_page.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.changeLanguage});
  final void Function(Locale locale) changeLanguage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _controller;
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _widgetOptions = <Widget>[
      const FeedPage(),
      const ProfilePage(),
      SettingsPage(changeLanguage: widget.changeLanguage),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
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
          SafeArea(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: [
                    // Animated AppBar
                    _buildGlassmorphicAppBar(context),

                    // Main Content
                    Expanded(
                      child: Center(
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ),

                    // Animated Bottom Navigation Bar
                    _buildGlassmorphicBottomNavBar(context),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphicAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 60,
        borderRadius: 30,
        blur: 7,
        alignment: Alignment.center,
        border: 1,
        linearGradient: kAnimatedGradient(_controller.value),
        borderGradient: kAppBarBorderGradient,
        child: Center(
          child: Text(
            l10n.appTitle,
            style: kAppBarTitleTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicBottomNavBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 70,
        borderRadius: 30,
        blur: 7,
        alignment: Alignment.center,
        border: 1,
        linearGradient: kAnimatedGradient(_controller.value),
        borderGradient: kAppBarBorderGradient,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.bottomNavFeed),
            BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.bottomNavProfile),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: l10n.bottomNavSettings),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kBottomNavSelectedItemColor,
          unselectedItemColor: kBottomNavUnselectedItemColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
