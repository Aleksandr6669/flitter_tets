
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flag/flag.dart';
import 'models/language.dart';
import 'styles.dart';

class LanguageSelector extends StatelessWidget {
  final Language selectedLanguage;
  final void Function(Language?) onLanguageChange;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 50,
      borderRadius: 25,
      blur: 10,
      alignment: Alignment.center,
      border: 0,
      linearGradient: kGlassmorphicGradient,
      borderGradient: kGlassmorphicBorderGradient, 
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Language>(
          value: selectedLanguage,
          onChanged: onLanguageChange,
          dropdownColor: kDropdownColor,
          borderRadius: BorderRadius.circular(25),
          style: kDropdownTextStyle,
          items: supportedLanguages.map<DropdownMenuItem<Language>>((Language language) {
            return DropdownMenuItem<Language>(
              alignment: Alignment.centerLeft,
              value: language,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flag.fromString(language.flagCode, height: 24, width: 24, fit: BoxFit.fill, borderRadius: 2.0),
                  const SizedBox(width: 16),
                  Text(language.name),
                  const SizedBox(width: 16), // Добавил отступ здесь
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
