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
      border: 1,
      linearGradient: kGlassmorphicGradient,
      borderGradient: kGlassmorphicBorderGradient,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Language>(
            value: selectedLanguage,
            onChanged: onLanguageChange,
            dropdownColor: kDropdownColor,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down, color: kDropdownIconColor),
            ),
            style: kDropdownTextStyle,
            items: supportedLanguages.map<DropdownMenuItem<Language>>((Language language) {
              return DropdownMenuItem<Language>(
                value: language,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Flag.fromString(language.flagCode, height: 20, width: 24, fit: BoxFit.fill, borderRadius: 2.0),
                      const SizedBox(width: 10),
                      Text(language.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
