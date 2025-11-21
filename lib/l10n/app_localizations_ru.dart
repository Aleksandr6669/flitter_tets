// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get joinUsToStartYourJourney =>
      'Присоединяйтесь, чтобы начать свое путешествие';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get alreadyHaveAnAccount => 'Уже есть аккаунт? ';

  @override
  String get login => 'Войти';

  @override
  String get welcomeBack => 'С возвращением!';

  @override
  String get dontHaveAnAccount => 'Нет аккаунта? ';

  @override
  String get pleaseEnterYourEmail =>
      'Пожалуйста, введите свою электронную почту';

  @override
  String get pleaseEnterYourPassword => 'Пожалуйста, введите свой пароль';

  @override
  String get pleaseConfirmYourPassword => 'Пожалуйста, подтвердите свой пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get language => 'Язык';

  @override
  String get appTitle => 'Демо Аврора';

  @override
  String get feedTitle => 'Лента';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get bottomNavFeed => 'Лента';

  @override
  String get bottomNavProfile => 'Профиль';

  @override
  String get bottomNavSettings => 'Настройки';

  @override
  String get enterVerificationCode => 'Введите код подтверждения';

  @override
  String get verificationCodeSent =>
      'Код подтверждения отправлен на вашу электронную почту.';

  @override
  String get verificationCode => 'Код подтверждения';

  @override
  String get pleaseEnterTheCode => 'Пожалуйста, введите 6-значный код.';

  @override
  String get verify => 'Проверить';

  @override
  String get resendCode => 'Отправить код повторно';

  @override
  String get invalidCode => 'Неверный код подтверждения.';
}
