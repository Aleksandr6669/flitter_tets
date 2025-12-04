import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/profile_service.dart';
import 'package:flutter_application_1/user_profile.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _profileService = ProfileService();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _roleController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _specialtyController;
  late final TextEditingController _aboutMeController;
  late final TextEditingController _skillsController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _roleController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _specialtyController = TextEditingController();
    _aboutMeController = TextEditingController();
    _skillsController = TextEditingController();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _dateOfBirthController.dispose();
    _specialtyController.dispose();
    _aboutMeController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final userProfile = await _profileService.getUserProfile();
    if (userProfile != null) {
      _firstNameController.text = userProfile.firstName;
      _lastNameController.text = userProfile.lastName;
      _roleController.text = userProfile.role;
      _dateOfBirthController.text = userProfile.dateOfBirth;
      _specialtyController.text = userProfile.specialty;
      _aboutMeController.text = userProfile.aboutMe;
      _skillsController.text = userProfile.skills.join(', ');
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final userProfile = UserProfile(
        avatarUrl: '', // We'll handle avatar uploads later
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        role: _roleController.text,
        dateOfBirth: _dateOfBirthController.text,
        specialty: _specialtyController.text,
        aboutMe: _aboutMeController.text,
        skills: _skillsController.text.split(', ').map((e) => e.trim()).toList(),
      );

      await _profileService.saveUserProfile(userProfile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.profileSaved)),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(l10n.editProfileButton, style: kAppBarTitleTextStyle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          borderRadius: 15,
          blur: 10,
          border: 1,
          linearGradient: kGlassmorphicGradient,
          borderGradient: kGlassmorphicBorderGradient,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: kInputDecoration(l10n.firstName, Icons.person_outline),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterFirstName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: kInputDecoration(l10n.lastName, Icons.person_outline),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterLastName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _roleController,
                    decoration: kInputDecoration(l10n.role, Icons.work_outline),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _dateOfBirthController,
                    decoration: kInputDecoration(l10n.dateOfBirth, Icons.calendar_today_outlined),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _specialtyController,
                    decoration: kInputDecoration(l10n.specialty, Icons.school_outlined),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _aboutMeController,
                    decoration: kInputDecoration(l10n.aboutMe, Icons.info_outline),
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _skillsController,
                    decoration: kInputDecoration(l10n.skillsHint, Icons.lightbulb_outline),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: kButtonBoxDecoration,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: kElevatedButtonStyle,
                      child: Text(l10n.saveChanges, style: kButtonTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
