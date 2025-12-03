
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
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          if (e.code == 'user-not-found') {
            _showErrorSnackBar(context, l10n.userNotFoundPleaseRegister);
            _toggleFormType();
          } else if (e.code == 'email-already-in-use') {
            _showErrorSnackBar(context, "Email already in use. Please log in.");
            _toggleFormType();
          } else {
            _showErrorSnackBar(context, e.message ?? 'Authentication failed');
          }
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
              child: Padding(
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
          ),
        ],
      ),
    );
  }
}

class GlassmorphicAuthForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final selectedLanguage = supportedLanguages.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => supportedLanguages.first,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: 720, // Fixed height
      ),
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8, // Fixed height
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 0,
        linearGradient: kGlassmorphicGradient,
        borderGradient: kGlassmorphicBorderGradient,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    isLogin ? l10n.login : l10n.createAccount,
                    key: ValueKey(isLogin),
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    isLogin
                        ? l10n.welcomeBack
                        : l10n.joinUsToStartYourJourney,
                    key: ValueKey(isLogin),
                    textAlign: TextAlign.center,
                    style: kSubtitleTextStyle,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
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
                  controller: passwordController,
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
                  child: !isLogin
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: kInputDecoration(
                                  l10n.confirmPassword, Icons.lock_reset),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.pleaseConfirmYourPassword;
                                }
                                if (value != passwordController.text) {
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
                      changeLanguage(Locale(newLanguage.code));
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: kButtonBoxDecoration,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => handleAuthAction(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              isLogin ? l10n.login : l10n.signUp,
                              key: ValueKey(isLogin),
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
                        isLogin
                            ? l10n.dontHaveAnAccount
                            : l10n.alreadyHaveAnAccount,
                        key: ValueKey(isLogin),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggleFormType,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          isLogin ? ' ${l10n.signUp}' : ' ${l10n.login}',
                          key: ValueKey(isLogin),
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
      ),
    );
  }
}
