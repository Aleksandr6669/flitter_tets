
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flag/flag.dart';
import 'models/language.dart';
import 'styles.dart';
import 'language_selector.dart';

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
        Text(l10n.settingsTitle, style: kSettingsTitleTextStyle),
        const SizedBox(height: 40),
        Text(l10n.language, style: kSettingsLanguageTextStyle),
        const SizedBox(height: 20),
        LanguageSelector(
          selectedLanguage: _selectedLanguage!,
          onLanguageChange: _onLanguageChange,
        ),
      ],
    );
  }
}
