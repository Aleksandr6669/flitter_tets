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
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get alreadyHaveAnAccount => 'Vous avez déjà un compte ? ';

  @override
  String get login => 'Se connecter';

  @override
  String get welcomeBack => 'Content de vous revoir !';

  @override
  String get dontHaveAnAccount => 'Vous n\'avez pas de compte ? ';

  @override
  String get pleaseEnterYourEmail => 'Veuillez entrer votre email';

  @override
  String get pleaseEnterYourPassword => 'Veuillez entrer votre mot de passe';

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
  String get feedTitle => 'Fil';

  @override
  String get profileTitle => 'Profil';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get bottomNavFeed => 'Fil';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Paramètres';

  @override
  String get enterVerificationCode => 'Entrez le code de vérification';

  @override
  String get verificationCodeSent =>
      'Un code de vérification a été envoyé à votre email.';

  @override
  String get verificationCode => 'Code de vérification';

  @override
  String get pleaseEnterTheCode => 'Veuillez entrer le code à 6 chiffres.';

  @override
  String get verify => 'Vérifier';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String get invalidCode => 'Code de vérification invalide.';

  @override
  String get userNotFound =>
      'Utilisateur non trouvé pour cet email. Veuillez vous inscrire.';

  @override
  String get wrongPassword => 'Mauvais mot de passe. Veuillez réessayer.';

  @override
  String get emailAlreadyInUse =>
      'Cet email est déjà utilisé. Veuillez vous connecter.';

  @override
  String get authenticationFailed =>
      'Échec de l\'authentification. Veuillez réessayer.';

  @override
  String get userDisabled =>
      'Cet utilisateur a été désactivé. Veuillez contacter le support.';

  @override
  String get invalidEmail => 'Adresse email invalide.';

  @override
  String get weakPassword => 'Le mot de passe est trop faible.';

  @override
  String get tooManyRequests =>
      'Trop de requêtes. Veuillez réessayer plus tard.';

  @override
  String get verifyYourEmail => 'Vérifiez votre email';

  @override
  String verificationLinkSent(String email) {
    return 'Un lien de vérification a été envoyé à $email. Veuillez vérifier votre boîte de réception et suivre les instructions pour terminer l\'inscription.';
  }

  @override
  String get resendEmail => 'Renvoyer l\'email';

  @override
  String get cancel => 'Annuler';
}
