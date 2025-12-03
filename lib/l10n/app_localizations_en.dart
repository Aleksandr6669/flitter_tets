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
  String get feedTitle => 'Feed';

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

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
  String get wrongPassword =>
      'Wrong password provided for that user. Please try again.';

  @override
  String get emailAlreadyInUse =>
      'The account already exists for that email. Please login.';

  @override
  String get authenticationFailed => 'Authentication failed. Please try again.';

  @override
  String get authenticationSuccess => 'Authentication successful!';

  @override
  String get userDisabled =>
      'This user has been disabled. Please contact support.';

  @override
  String get invalidEmail => 'The email address is not valid.';

  @override
  String get weakPassword => 'The password is too weak.';

  @override
  String get tooManyRequests => 'Too many requests. Please try again later.';

  @override
  String get verifyYourEmail => 'Verify Your Email';

  @override
  String verificationLinkSent(String email) {
    return 'A verification link has been sent to $email. Please check your inbox and follow the instructions to complete the registration.';
  }

  @override
  String get pressButtonToVerify =>
      'Press the button below to complete your email verification.';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String get cancel => 'Cancel';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordResetSuccess =>
      'Your password has been reset successfully. You can now log in with your new password.';

  @override
  String get passwordResetFailed =>
      'Failed to reset password. The link may be invalid or expired.';

  @override
  String resetPasswordLinkSent(Object email) {
    return 'A password reset link has been sent to $email. Please check your inbox.';
  }

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we will send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Link';

  @override
  String get backToLogin => 'Back to Login';
}
