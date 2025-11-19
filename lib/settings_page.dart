
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';

// A data class for languages
class Language {
  final String name;
  final String code;

  const Language({required this.name, required this.code});
}

const List<Language> supportedLanguages = [
  Language(name: 'English', code: 'en'),
  Language(name: 'Français', code: 'fr'),
  Language(name: 'Українська', code: 'uk'),
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.changeLanguage});
  final void Function(Locale locale) changeLanguage;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Language? _selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the selected language based on the current locale
    final locale = Localizations.localeOf(context);
    _selectedLanguage = supportedLanguages.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => supportedLanguages.first,
    );
  }

  void _onLanguageChange(Language? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _selectedLanguage = newLanguage;
      });
      widget.changeLanguage(Locale(newLanguage.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.settingsTitle, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        Text(l10n.language, style: const TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 20),
        _buildGlassmorphicDropdown(context),
      ],
    );
  }

  Widget _buildGlassmorphicDropdown(BuildContext context) {
    return GlassmorphicContainer(
      width: 250,
      height: 60,
      borderRadius: 30,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          Colors.deepPurple.withOpacity(0.4),
          Colors.pink.withOpacity(0.3),
        ],
        stops: const [0.2, 0.8],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Language>(
          value: _selectedLanguage,
          isExpanded: true,
          onChanged: _onLanguageChange,
          dropdownColor: Colors.black.withOpacity(0.7),
          icon: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.arrow_drop_down, color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: supportedLanguages.map<DropdownMenuItem<Language>>((Language language) {
            return DropdownMenuItem<Language>(
              value: language,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(language.name),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
