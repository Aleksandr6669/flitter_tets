import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/profile_service.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'styles.dart';

class SettingsPage extends StatefulWidget {
  final void Function(Locale locale) changeLanguage;
  const SettingsPage({super.key, required this.changeLanguage});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  final _profileService = ProfileService();
  bool _isEditing = false;
  bool _isLoading = false;
  late final AnimationController _controller;

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController();
  final _positionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _aboutController = TextEditingController();

  String _avatarUrl = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _loadProfileData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _positionController.dispose();
    _organizationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData({bool cancelEditing = false}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userProfile = await _profileService.getUserProfile();
      if (userProfile.exists) {
        final data = userProfile.data() as Map<String, dynamic>;
        _nameController.text = data['name'] ?? '';
        _lastNameController.text = data['lastName'] ?? '';
        _roleController.text = data['role'] ?? '';
        _positionController.text = data['position'] ?? '';
        _organizationController.text = data['organization'] ?? '';
        _aboutController.text = data['about'] ?? '';
        _avatarUrl = data['avatarUrl'] ?? '';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          if (cancelEditing) {
            _isEditing = false;
          }
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

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
      setState(() {
        _isEditing = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(_isEditing ? l10n.editProfile : l10n.bottomNavSettings, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: _isEditing ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => _loadProfileData(cancelEditing: true),
                ) : null,
              automaticallyImplyLeading: !_isEditing,
              actions: _isEditing
                  ? [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        onPressed: _updateProfile,
                      ),
                    ]
                  : [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                      ),
                    ],
            ),
            body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildBody(context, l10n),
          );
        });
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildProfileSection(l10n),
          const SizedBox(height: 20),
          _buildInfoSection(l10n),
          const SizedBox(height: 30),
          _buildLanguageSwitcher(l10n),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileSection(AppLocalizations l10n) {
    return GlassmorphicContainer(
        width: double.infinity,
        height: 280,
        borderRadius: 20,
        blur: 7,
        border: 1,
        linearGradient: kAnimatedGradient(_controller.value),
        borderGradient: kAppBarBorderGradient,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
        ));
  }

  Widget _buildInfoSection(AppLocalizations l10n) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: _isEditing ? 350 : 300,
      borderRadius: 20,
      blur: 7,
      border: 1,
      linearGradient: kAnimatedGradient(_controller.value),
      borderGradient: kAppBarBorderGradient,
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

  Widget _buildLanguageSwitcher(AppLocalizations l10n) {
    final String currentLanguageName;
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        currentLanguageName = 'Русский';
        break;
      case 'uk':
        currentLanguageName = 'Українська';
        break;
      default:
        currentLanguageName = 'English';
    }

    return TextButton.icon(
      onPressed: () => _showLanguagePicker(context),
      icon: const Icon(Icons.language, color: Colors.white70),
      label: Text(currentLanguageName, style: const TextStyle(color: Colors.white, fontSize: 16)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassmorphicContainer(
          width: double.infinity,
          height: 220,
          borderRadius: 20,
          blur: 7,
          border: 1,
          linearGradient: kAnimatedGradient(_controller.value),
          borderGradient: kAppBarBorderGradient,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                  title: const Text('English', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    widget.changeLanguage(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Text('🇷🇺', style: TextStyle(fontSize: 24)),
                  title: const Text('Русский', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    widget.changeLanguage(const Locale('ru'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Text('🇺🇦', style: TextStyle(fontSize: 24)),
                  title: const Text('Українська', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    widget.changeLanguage(const Locale('uk'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isFullName)
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        Text(
          value.isEmpty ? '-' : value, 
          style: TextStyle(
            color: Colors.white, 
            fontSize: isFullName ? 22 : 16,
            fontWeight: isFullName ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (!isFullName)
          const Divider(color: Colors.white24, height: 16, thickness: 0.5),
      ],
    );
  }
}
