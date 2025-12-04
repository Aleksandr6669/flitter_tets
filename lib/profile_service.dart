import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _userProfileKey = 'userProfile';

  Future<void> saveUserProfile(UserProfile userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    final userProfileJson = jsonEncode(userProfile.toMap());
    await prefs.setString(_userProfileKey, userProfileJson);
    await _firestore.collection('users').doc('profile').set(userProfile.toMap());
  }

  Future<UserProfile?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final userProfileDoc = await _firestore.collection('users').doc('profile').get();
      if (userProfileDoc.exists) {
        final userProfile = UserProfile.fromMap(userProfileDoc.data()!);
        final userProfileJson = jsonEncode(userProfile.toMap());
        await prefs.setString(_userProfileKey, userProfileJson);
        return userProfile;
      } else {
        return await _getLocalUserProfile(prefs);
      }
    } catch (e) {
      return await _getLocalUserProfile(prefs);
    }
  }

  Future<UserProfile?> _getLocalUserProfile(SharedPreferences prefs) async {
    final userProfileJson = prefs.getString(_userProfileKey);
    if (userProfileJson != null) {
      return UserProfile.fromMap(jsonDecode(userProfileJson));
    }
    return null;
  }
}
