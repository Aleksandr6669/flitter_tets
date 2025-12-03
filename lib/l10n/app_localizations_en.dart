// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinUsToStartYourJourney => 'Join us to start your journey';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get signUp => 'Sign Up';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? ';

  @override
  String get login => 'Login';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account? ';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get pleaseConfirmYourPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get language => 'Language';

  @override
  String get appTitle => 'Aurora Demo';

  @override
  String get feedTitle => 'Feed Page';

  @override
  String get profileTitle => 'Profile Page';

  @override
  String get settingsTitle => 'Settings Page';

  @override
  String get bottomNavFeed => 'Feed';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get bottomNavSettings => 'Settings';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get verificationCodeSent =>
      'A verification code has been sent to your email.';

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get pleaseEnterTheCode => 'Please enter the 6-digit code.';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get invalidCode => 'Invalid verification code.';

  @override
  String get userNotFound => 'No user found for that email. Please sign up.';

  @override
  String get wrongPassword => 'Wrong password provided. Please try again.';

  @override
  String get emailAlreadyInUse =>
      'This email is already in use. Please log in.';

  @override
  String get authenticationFailed => 'Authentication failed. Please try again.';

  @override
  String get userDisabled =>
      'This user has been disabled. Please contact support.';

  @override
  String get invalidEmail => 'The email address is not valid.';

  @override
  String get weakPassword => 'The password is not strong enough.';

  @override
  String get tooManyRequests => 'Too many requests. Please try again later.';
}
