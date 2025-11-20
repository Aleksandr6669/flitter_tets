
class Language {
  final String name;
  final String code;
  final String flagCode;

  const Language({required this.name, required this.code, required this.flagCode});
}

const List<Language> supportedLanguages = [
  Language(name: 'English', code: 'en', flagCode: 'gb'),
  Language(name: 'Français', code: 'fr', flagCode: 'fr'),
  Language(name: 'Українська', code: 'uk', flagCode: 'ua'),
];
