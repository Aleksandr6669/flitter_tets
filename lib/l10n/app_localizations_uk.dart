// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get createAccount => 'Створити акаунт';

  @override
  String get joinUsToStartYourJourney =>
      'Приєднуйтесь, щоб розпочати свою подорож';

  @override
  String get email => 'Електронна пошта';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Підтвердьте пароль';

  @override
  String get signUp => 'Зареєструватися';

  @override
  String get alreadyHaveAnAccount => 'Вже є акаунт? ';

  @override
  String get login => 'Увійти';

  @override
  String get welcomeBack => 'З поверненням!';

  @override
  String get dontHaveAnAccount => 'Немає акаунта? ';

  @override
  String get pleaseEnterYourEmail =>
      'Будь ласка, введіть свою електронну пошту';

  @override
  String get pleaseEnterYourPassword => 'Будь ласка, введіть свій пароль';

  @override
  String get pleaseConfirmYourPassword => 'Будь ласка, підтвердьте свій пароль';

  @override
  String get passwordsDoNotMatch => 'Паролі не співпадають';

  @override
  String get language => 'Мова';

  @override
  String get appTitle => 'Демо Аврора';

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

  @override
  String get enterVerificationCode => 'Введіть код підтвердження';

  @override
  String get verificationCodeSent =>
      'Код підтвердження надіслано на вашу електронну адресу.';

  @override
  String get verificationCode => 'Код підтвердження';

  @override
  String get pleaseEnterTheCode => 'Будь ласка, введіть 6-значний код.';

  @override
  String get verify => 'Перевірити';

  @override
  String get resendCode => 'Надіслати код повторно';

  @override
  String get invalidCode => 'Неправильний код підтвердження.';

  @override
  String get userNotFound =>
      'Користувача з такою електронною поштою не знайдено. Будь ласка, зареєструйтесь.';

  @override
  String get wrongPassword =>
      'Неправильний пароль. Будь ласка, спробуйте ще раз.';

  @override
  String get emailAlreadyInUse =>
      'Ця електронна адреса вже використовується. Будь ласка, увійдіть.';

  @override
  String get authenticationFailed =>
      'Помилка автентифікації. Будь ласка, спробуйте ще раз.';

  @override
  String get userDisabled =>
      'Цього користувача заблоковано. Будь ласка, зверніться до служби підтримки.';

  @override
  String get invalidEmail => 'Неправильний формат електронної пошти.';

  @override
  String get weakPassword => 'Пароль недостатньо надійний.';

  @override
  String get tooManyRequests =>
      'Забагато запитів. Будь ласка, спробуйте пізніше.';

  @override
  String get verifyYourEmail => 'Verify Your Email';

  @override
  String get verificationLinkSent =>
      'A verification link has been sent to your email. Please check your inbox and follow the instructions to complete the registration.';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String get cancel => 'Cancel';
}
