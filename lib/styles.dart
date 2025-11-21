
import 'package:flutter/material.dart';

// Text Styles
const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle kSubtitleTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white70,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle kTextLinkStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle kAppBarTitleTextStyle = TextStyle(
    fontSize: 20, 
    fontWeight: FontWeight.bold, 
    color: Colors.white
);

const TextStyle kPageTitleTextStyle = TextStyle(color: Colors.white);

const TextStyle kSettingsTitleTextStyle =
    TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

const TextStyle kSettingsLanguageTextStyle = TextStyle(color: Colors.white, fontSize: 18);

const TextStyle kDropdownTextStyle = TextStyle(color: Colors.white, fontSize: 16);

// Input Decoration
InputDecoration kInputDecoration(String label, IconData icon) {
  return InputDecoration(
    hintText: label,
    hintStyle: const TextStyle(color: Colors.white54),
    prefixIcon: Icon(icon, color: Colors.white54),
    filled: true,
    fillColor: Colors.white.withOpacity(0.1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
    ),
  );
}

// Gradients
const LinearGradient kButtonGradient = LinearGradient(
  colors: [Color(0xFFDA4453), Color(0xFF89216B)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kGlassmorphicGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.white.withOpacity(0.1),
    Colors.white.withOpacity(0.05),
  ],
);

final LinearGradient kGlassmorphicBorderGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
  ],
);

LinearGradient kAnimatedGradient(double animationValue) {
    return LinearGradient(
        transform: GradientRotation(animationValue * 6.28),
        colors: [
            Colors.deepPurple.withOpacity(0.3),
            Colors.pink.withOpacity(0.2),
            Colors.lightBlue.withOpacity(0.4),
        ],
        stops: const [0.2, 0.5, 0.8],
    );
}

final LinearGradient kAppBarBorderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
);

final LinearGradient kDropdownGradient = LinearGradient(
    colors: [
        Colors.deepPurple.withOpacity(0.4),
        Colors.pink.withOpacity(0.3),
    ],
    stops: const [0.2, 0.8],
);

final LinearGradient kDropdownBorderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
);


// Box Decorations
final BoxDecoration kButtonBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15.0),
  gradient: kButtonGradient,
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ],
);

// Colors
const Color kBottomNavSelectedItemColor = Colors.white;
const Color kBottomNavUnselectedItemColor = Colors.white70;
const Color kDropdownColor = Color.fromARGB(149, 26, 5, 43);
const Color kDropdownIconColor = Colors.white;
