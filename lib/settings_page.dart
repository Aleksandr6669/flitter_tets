
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/profile_service.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'styles.dart';
import 'language_selector.dart';
import 'models/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  final void Function(Locale locale) changeLanguage;
  final void Function(bool) onEditModeChange;
  const SettingsPage({super.key, required this.changeLanguage, required this.onEditModeChange});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  final _profileService = ProfileService();
  bool _isEditing = false;
  late final AnimationController _controller;
  StreamSubscription? _profileSubscription;

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController();
  final _positionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _aboutController = TextEditingController();

  String _avatarUrl = '';
  Language _selectedLanguage = supportedLanguages.first;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _subscribeToProfileUpdates();
  }

  @override
  void dispose() {
    _controller.dispose();
    _profileSubscription?.cancel();
    _nameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _positionController.dispose();
    _organizationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _subscribeToProfileUpdates() {
    _profileSubscription = _profileService.getUserProfile().listen((userProfile) {
      if (userProfile.exists) {
        final data = userProfile.data() as Map<String, dynamic>;
        if (!_isEditing) {
          _nameController.text = data['name'] ?? '';
          _lastNameController.text = data['lastName'] ?? '';
          _roleController.text = data['role'] ?? '';
          _positionController.text = data['position'] ?? '';
          _organizationController.text = data['organization'] ?? '';
          _aboutController.text = data['about'] ?? '';
        }
        _avatarUrl = data['avatarUrl'] ?? '';
        if (mounted) {
          setState(() {});
        }
      }
    }, onError: (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      }
    });
  }

  void _setEditing(bool isEditing) {
    setState(() {
      _isEditing = isEditing;
    });
    widget.onEditModeChange(isEditing);
    if (!isEditing) {
      _subscribeToProfileUpdates();
    }
  }

  Future<void> _updateProfile() async {
    try {
      final dataToUpdate = {
        'name': _nameController.text,
        'lastName': _lastNameController.text,
        'role': _roleController.text,
        'position': _positionController.text,
        'organization': _organizationController.text,
        'about': _aboutController.text,
        'avatarUrl': _avatarUrl,
      };
      await _profileService.updateUserProfile(dataToUpdate);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.profileSaved)),
        );
      }
      _setEditing(false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: _buildBody(context, l10n),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
          child: Row(
            children: [
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => _setEditing(false),
                )
              else
                const BackButton(color: Colors.white),
              const Spacer(),
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.white),
                  onPressed: _updateProfile,
                )
              else
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () => _setEditing(true),
                ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildProfileSection(l10n),
                const SizedBox(height: 20),
                _buildInfoSection(l10n),
                const SizedBox(height: 30),
                if (!_isEditing) ...[
                  LanguageSelector(
                    selectedLanguage: _selectedLanguage,
                    onLanguageChange: (language) {
                      if (language != null) {
                        setState(() {
                          _selectedLanguage = language;
                        });
                        widget.changeLanguage(Locale(language.code));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(AppLocalizations l10n) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 280,
      borderRadius: 20,
      blur: 10,
      border: 0,
      linearGradient: kGlassmorphicGradient,
      borderGradient: kGlassmorphicBorderGradient,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: _avatarUrl.isNotEmpty ? NetworkImage(_avatarUrl) : null,
              child: _avatarUrl.isEmpty ? const Icon(Icons.person, size: 40) : null,
            ),
            const SizedBox(height: 20),
            if (_isEditing)
              ...[
                _buildTextField(_nameController, l10n.firstName),
                const SizedBox(height: 10),
                _buildTextField(_lastNameController, l10n.lastName),
                TextButton(
                  onPressed: () { /* TODO: Implement image picker */ },
                  child: Text(l10n.changePhotoButton, style: const TextStyle(color: Colors.blue)),
                ),
              ]
            else
               _buildInfoDisplay('', '${_nameController.text} ${_lastNameController.text}', isFullName: true),
              
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(AppLocalizations l10n) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: _isEditing ? 350 : 300,
      borderRadius: 20,
      blur: 10,
      border: 0,
      linearGradient: kGlassmorphicGradient,
      borderGradient: kGlassmorphicBorderGradient,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? Column(
                children: [
                  _buildTextField(_roleController, l10n.role),
                  const SizedBox(height: 10),
                  _buildTextField(_positionController, l10n.position),
                  const SizedBox(height: 10),
                  _buildTextField(_organizationController, l10n.organization),
                  const SizedBox(height: 10),
                  _buildTextField(_aboutController, l10n.aboutMe, maxLines: 4),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoDisplay(l10n.role, _roleController.text),
                  _buildInfoDisplay(l10n.position, _positionController.text),
                  _buildInfoDisplay(l10n.organization, _organizationController.text),
                  _buildInfoDisplay(l10n.aboutMe, _aboutController.text),
                ],
              ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 12),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        isDense: true,
      ),
    );
  }

    Widget _buildInfoDisplay(String title, String value, {bool isFullName = false}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: isFullName ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isFullName)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          Text(
            value.isEmpty ? '-' : value,
            textAlign: isFullName ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: isFullName ? 22 : 16,
              fontWeight: isFullName ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (!isFullName)
            const Divider(color: Colors.white24, height: 16, thickness: 0.5),
        ],
      ),
    );
  }
}
