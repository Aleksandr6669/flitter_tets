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

  @override
  String get userNotFound =>
      'Aucun utilisateur trouvé pour cet e-mail. Veuillez vous inscrire.';

  @override
  String get wrongPassword => 'Mot de passe incorrect. Veuillez réessayer.';

  @override
  String get emailAlreadyInUse =>
      'Cet e-mail est déjà utilisé. Veuillez vous connecter.';

  @override
  String get authenticationFailed =>
      'L\'authentification a échoué. Veuillez réessayer.';

  @override
  String get userDisabled =>
      'Cet utilisateur a été désactivé. Veuillez contacter le support.';

  @override
  String get invalidEmail => 'L\'adresse e-mail n\'est pas valide.';

  @override
  String get weakPassword => 'Le mot de passe n\'est pas assez fort.';

  @override
  String get tooManyRequests =>
      'Trop de demandes. Veuillez réessayer plus tard.';
}
