
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/profile_service.dart';
import 'package:flutter_application_1/widgets/profile_list_tile.dart';

class SettingsPage extends StatefulWidget {
  final void Function(Locale locale) changeLanguage;
  const SettingsPage({super.key, required this.changeLanguage});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _profileService = ProfileService();
  bool _isEditing = false;
  bool _isLoading = false;

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
    _loadProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _positionController.dispose();
    _organizationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isEditing
              ? _buildEditView(context)
              : _buildViewMode(context),
    );
  }

  Widget _buildViewMode(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          expandedHeight: 250.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _avatarUrl.isNotEmpty
                      ? NetworkImage(_avatarUrl)
                      : null,
                  child: _avatarUrl.isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
                const SizedBox(height: 16.0),
                Text(
                  '${_nameController.text} ${_lastNameController.text}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: Text(
                l10n.editProfile,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSection([
                  ProfileListTile(
                    icon: Icons.camera_alt,
                    title: l10n.changePhotoButton,
                    onTap: () {
                      // TODO: Implement image picker
                    },
                  ),
                ]),
                const SizedBox(height: 20),
                _buildSection([
                  ProfileListTile(
                    icon: Icons.person,
                    title: l10n.role,
                    subtitle: _roleController.text,
                  ),
                  ProfileListTile(
                    icon: Icons.work,
                    title: l10n.position,
                    subtitle: _positionController.text,
                  ),
                   ProfileListTile(
                    icon: Icons.business,
                    title: l10n.organization,
                    subtitle: _organizationController.text,
                  ),
                ]),
                 const SizedBox(height: 20),
                _buildSection([
                   ProfileListTile(
                    icon: Icons.info_outline,
                    title: l10n.aboutMe,
                    subtitle: _aboutController.text,
                  ),
                ]),
                const SizedBox(height: 20),
                _buildSection([
                  ProfileListTile(
                    icon: Icons.language,
                    title: l10n.language,
                    subtitle: Localizations.localeOf(context).languageCode == 'ru' ? 'Русский' : 'English',
                    onTap: () => _showLanguagePicker(context),
                  )
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) {
        return Wrap(
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
          ],
        );
      },
    );
  }


  Widget _buildEditView(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: AppBar(
         backgroundColor: Colors.black,
        title: Text(l10n.editProfile, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            setState(() {
              _isEditing = false;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _updateProfile,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
               radius: 50,
               backgroundImage: _avatarUrl.isNotEmpty
                   ? NetworkImage(_avatarUrl)
                   : null,
               child: _avatarUrl.isEmpty
                   ? const Icon(Icons.person, size: 50)
                   : null,
             ),
             TextButton(
               onPressed: () {
                 // TODO: Implement image picker
               },
               child: Text(l10n.changePhotoButton, style: const TextStyle(color: Colors.blue)),
             ),
            const SizedBox(height: 20),
            _buildTextField(_nameController, l10n.firstName),
            const SizedBox(height: 10),
            _buildTextField(_lastNameController, l10n.lastName),
            const SizedBox(height: 20),
            _buildTextField(_roleController, l10n.role),
             const SizedBox(height: 10),
            _buildTextField(_positionController, l10n.position),
             const SizedBox(height: 10),
            _buildTextField(_organizationController, l10n.organization),
             const SizedBox(height: 10),
            _buildTextField(_aboutController, l10n.aboutMe, maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: children
            .map((e) => Column(
                  children: [
                    Container(color: Colors.grey[900], child: e),
                    if (children.last != e)
                      const Divider(
                        color: Colors.grey,
                        height: 0.5,
                        indent: 50,
                      )
                  ],
                ))
            .toList(),
      ),
    );
  }

   Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
         labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
