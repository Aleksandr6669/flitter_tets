// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get createAccount => 'Створити аккаунт';

  @override
  String get joinUsToStartYourJourney =>
      'Приєднуйтесь до нас, щоб почати свою подорож';

  @override
  String get email => 'Електронна пошта';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Підтвердіть пароль';

  @override
  String get signUp => 'Зареєструватися';

  @override
  String get alreadyHaveAnAccount => 'Вже є аккаунт? ';

  @override
  String get login => 'Увійти';

  @override
  String get welcomeBack => 'З поверненням!';

  @override
  String get dontHaveAnAccount => 'Немає аккаунта? ';

  @override
  String get pleaseEnterYourEmail =>
      'Будь ласка, введіть свою електронну пошту';

  @override
  String get pleaseEnterYourPassword => 'Будь ласка, введіть свій пароль';

  @override
  String get pleaseConfirmYourPassword => 'Будь ласка, підтвердіть свій пароль';

  @override
  String get passwordsDoNotMatch => 'Паролі не співпадають';

  @override
  String get language => 'Мова';

  @override
  String get appTitle => 'Аврора Демо';

  @override
  String get feedTitle => 'Сторінка стрічки';

  @override
  String get profileTitle => 'Сторінка профілю';

  @override
  String get settingsTitle => 'Сторінка налаштувань';

  @override
  String get bottomNavFeed => 'Стрічка';

  @override
  String get bottomNavProfile => 'Профіль';

  @override
  String get bottomNavSettings => 'Налаштування';
}
