// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get joinUsToStartYourJourney =>
      'Rejoignez-nous pour commencer votre voyage';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmez le mot de passe';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get alreadyHaveAnAccount => 'Vous avez déjà un compte? ';

  @override
  String get login => 'Connexion';

  @override
  String get welcomeBack => 'Content de vous revoir!';

  @override
  String get dontHaveAnAccount => 'Vous n\'avez pas de compte? ';

  @override
  String get pleaseEnterYourEmail => 'Veuillez saisir votre email';

  @override
  String get pleaseEnterYourPassword => 'Veuillez saisir votre mot de passe';

  @override
  String get pleaseConfirmYourPassword =>
      'Veuillez confirmer votre mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get language => 'Langue';

  @override
  String get appTitle => 'Démo Aurora';

  @override
  String get feedTitle => 'Page de fil d\'actualité';

  @override
  String get profileTitle => 'Page de profil';

  @override
  String get settingsTitle => 'Page des paramètres';

  @override
  String get bottomNavFeed => 'Fil';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Paramètres';

  @override
  String get enterVerificationCode => 'Saisir le code de vérification';

  @override
  String get verificationCodeSent =>
      'Un code de vérification a été envoyé à votre adresse e-mail.';

  @override
  String get verificationCode => 'Code de vérification';

  @override
  String get pleaseEnterTheCode => 'Veuillez saisir le code à 6 chiffres.';

  @override
  String get verify => 'Vérifier';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String get invalidCode => 'Code de vérification invalide.';
}
