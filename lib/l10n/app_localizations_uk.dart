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
      'Приєднуйтесь до нас, щоб почати свою подорож';

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
  String get dontHaveAnAccount => 'Немає акаунту? ';

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
  String get feedTitle => 'Стрічка';

  @override
  String get profileTitle => 'Профіль';

  @override
  String get settingsTitle => 'Налаштування';

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
      'Код підтвердження надіслано на вашу електронну пошту.';

  @override
  String get verificationCode => 'Код підтвердження';

  @override
  String get pleaseEnterTheCode => 'Будь ласка, введіть 6-значний код.';

  @override
  String get verify => 'Підтвердити';

  @override
  String get resendCode => 'Надіслати код ще раз';

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
      'Ця електронна пошта вже використовується. Будь ласка, увійдіть.';

  @override
  String get authenticationFailed =>
      'Помилка автентифікації. Будь ласка, спробуйте ще раз.';

  @override
  String get authenticationSuccess => 'Автентифікація успішна!';

  @override
  String get userDisabled =>
      'Цього користувача було вимкнено. Будь ласка, зверніться до служби підтримки.';

  @override
  String get invalidEmail => 'Неправильна адреса електронної пошти.';

  @override
  String get weakPassword => 'Пароль занадто слабкий.';

  @override
  String get tooManyRequests =>
      'Забагато запитів. Будь ласка, спробуйте ще раз пізніше.';

  @override
  String get verifyYourEmail => 'Підтвердьте свою електронну пошту';

  @override
  String verificationLinkSent(String email) {
    return 'Посилання для підтвердження надіслано на адресу $email. Перевірте свою поштову скриньку та дотримуйтесь інструкцій, щоб завершити реєстрацію.';
  }

  @override
  String get pressButtonToVerify =>
      'Натисніть кнопку нижче, щоб завершити підтвердження електронної пошти.';

  @override
  String get resendEmail => 'Надіслати електронний лист повторно';

  @override
  String get cancel => 'Скасувати';

  @override
  String get forgotPassword => 'Забули пароль?';

  @override
  String get resetPassword => 'Скинути пароль';

  @override
  String get newPassword => 'Новий пароль';

  @override
  String get confirmNewPassword => 'Підтвердьте новий пароль';

  @override
  String get passwordResetSuccess =>
      'Пароль успішно скинуто. Тепер ви можете увійти з новим паролем.';

  @override
  String get passwordResetFailed =>
      'Не вдалося скинути пароль. Посилання може бути недійсним або застарілим.';

  @override
  String resetPasswordLinkSent(Object email) {
    return 'Посилання для скидання пароля надіслано на адресу $email. Будь ласка, перевірте свою поштову скриньку.';
  }

  @override
  String get resetPasswordInstructions =>
      'Введіть свою електронну адресу, і ми надішлемо вам посилання для відновлення доступу до вашого облікового запису.';

  @override
  String get sendResetLink => 'Надіслати посилання для скидання';

  @override
  String get backToLogin => 'Повернутися до входу';
}
