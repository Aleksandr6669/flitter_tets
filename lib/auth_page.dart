
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'l10n/app_localizations.dart';
import 'models/language.dart';
import 'styles.dart';
import 'language_selector.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.changeLanguage});

  final void Function(Locale locale) changeLanguage;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleAuthAction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final l10n = AppLocalizations.of(context)!;

      try {
        if (_isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
        } else {
          // Create user
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
          // Send verification email
          await userCredential.user?.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage;
          switch (e.code) {
            case 'user-not-found':
              errorMessage = l10n.userNotFound;
              break;
            case 'wrong-password':
              errorMessage = l10n.wrongPassword;
              break;
            case 'email-already-in-use':
              errorMessage = l10n.emailAlreadyInUse;
              break;
            case 'user-disabled':
              errorMessage = l10n.userDisabled;
              break;
            case 'invalid-email':
              errorMessage = l10n.invalidEmail;
              break;
            case 'weak-password':
              errorMessage = l10n.weakPassword;
              break;
            case 'too-many-requests':
              errorMessage = l10n.tooManyRequests;
              break;
            default:
              errorMessage = l10n.authenticationFailed;
          }
          _showErrorSnackBar(context, errorMessage);
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: kBackgroundDecoration, // Using style from styles.dart
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: GlassmorphicAuthForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                changeLanguage: widget.changeLanguage,
                isLogin: _isLogin,
                isLoading: _isLoading,
                onToggleFormType: _toggleFormType,
                handleAuthAction: _handleAuthAction,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassmorphicAuthForm extends StatefulWidget {
  const GlassmorphicAuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLogin,
    required this.isLoading,
    required this.onToggleFormType,
    required this.changeLanguage,
    required this.handleAuthAction,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLogin;
  final bool isLoading;
  final VoidCallback onToggleFormType;
  final void Function(Locale locale) changeLanguage;
  final void Function(BuildContext) handleAuthAction;

  @override
  State<GlassmorphicAuthForm> createState() => _GlassmorphicAuthFormState();
}

class _GlassmorphicAuthFormState extends State<GlassmorphicAuthForm> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final selectedLanguage = supportedLanguages.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => supportedLanguages.first,
    );

    final double loginHeight = 550;
    final double registrationHeight = 640;
    final targetHeight = widget.isLogin ? loginHeight : registrationHeight;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: targetHeight),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      builder: (context, height, child) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.9,
            height: height,
            borderRadius: 20,
            blur: 10,
            alignment: Alignment.center,
            border: 0,
            linearGradient: kGlassmorphicGradient,
            borderGradient: kGlassmorphicBorderGradient,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.isLogin ? l10n.login : l10n.createAccount,
                  key: ValueKey(widget.isLogin),
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.isLogin
                      ? l10n.welcomeBack
                      : l10n.joinUsToStartYourJourney,
                  key: ValueKey(widget.isLogin),
                  textAlign: TextAlign.center,
                  style: kSubtitleTextStyle,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: widget.emailController,
                style: const TextStyle(color: Colors.white),
                decoration:
                    kInputDecoration(l10n.email, Icons.email_outlined),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@')) {
                    return l10n.pleaseEnterYourEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: widget.passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration:
                    kInputDecoration(l10n.password, Icons.lock_outline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterYourPassword;
                  }
                  return null;
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  );
                },
                child: !widget.isLogin
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: widget.confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: kInputDecoration(
                                l10n.confirmPassword, Icons.lock_reset),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseConfirmYourPassword;
                              }
                              if (value != widget.passwordController.text) {
                                return l10n.passwordsDoNotMatch;
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              LanguageSelector(
                selectedLanguage: selectedLanguage,
                onLanguageChange: (Language? newLanguage) {
                  if (newLanguage != null) {
                    widget.changeLanguage(Locale(newLanguage.code));
                  }
                },
              ),
              const SizedBox(height: 20),
              Container(
                decoration: kButtonBoxDecoration,
                child: ElevatedButton(
                  onPressed: widget.isLoading ? null : () => widget.handleAuthAction(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: widget.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            widget.isLogin ? l10n.login : l10n.signUp,
                            key: ValueKey(widget.isLogin),
                            style: kButtonTextStyle,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.isLogin
                          ? l10n.dontHaveAnAccount
                          : l10n.alreadyHaveAnAccount,
                      key: ValueKey(widget.isLogin),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onToggleFormType,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        widget.isLogin ? ' ${l10n.signUp}' : ' ${l10n.login}',
                        key: ValueKey(widget.isLogin),
                        style: kTextLinkStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
