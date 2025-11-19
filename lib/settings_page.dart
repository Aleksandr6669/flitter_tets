
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(l10n.settingsTitle, style: const TextStyle(color: Colors.white)),
    );
  }
}
