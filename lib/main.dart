import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flag/flag.dart';
import 'package:flutter_application_1/auth_wrapper.dart';
import 'verification_page.dart';
import 'models/language.dart';
import 'styles.dart';
import 'language_selector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ru');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Auth',
      theme: ThemeData.dark(),
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('uk'),
        Locale('ru'),
      ],
      home: AuthWrapper(changeLanguage: _changeLanguage),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.changeLanguage});
  final void Function(Locale locale) changeLanguage;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLogin = true;

  void _toggleFormType() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GlassmorphicAuthForm(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  changeLanguage: widget.changeLanguage,
                  isLogin: _isLogin,
                  onToggleFormType: _toggleFormType,
                ),
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
    required this.onToggleFormType,
    required this.changeLanguage,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLogin;
  final VoidCallback onToggleFormType;
  final void Function(Locale locale) changeLanguage;

  @override
  State<GlassmorphicAuthForm> createState() => _GlassmorphicAuthFormState();
}

class _GlassmorphicAuthFormState extends State<GlassmorphicAuthForm> {
  bool _isLoading = false;

  void _handleAuthAction() async {
    if (widget.formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (widget.isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: widget.emailController.text,
            password: widget.passwordController.text,
          );
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: widget.emailController.text,
            password: widget.passwordController.text,
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage;
          if (e.code == 'user-not-found') {
            errorMessage = AppLocalizations.of(context)!.userNotFoundPleaseRegister;
          } else {
            errorMessage = e.message ?? 'Authentication failed';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
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
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final selectedLanguage = supportedLanguages.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => supportedLanguages.first,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: widget.isLogin ? 650 : 720,
      ),
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: widget.isLogin
            ? MediaQuery.of(context).size.height * 0.7
            : MediaQuery.of(context).size.height * 0.8,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 0,
        linearGradient: kGlassmorphicGradient,
        borderGradient: kGlassmorphicBorderGradient,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.isLogin ? l10n.login : l10n.createAccount,
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.isLogin
                      ? l10n.welcomeBack
                      : l10n.joinUsToStartYourJourney,
                  textAlign: TextAlign.center,
                  style: kSubtitleTextStyle,
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
                if (!widget.isLogin) ...[
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
                    onPressed: _isLoading ? null : _handleAuthAction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            widget.isLogin ? l10n.login : l10n.signUp,
                            style: kButtonTextStyle,
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.isLogin
                          ? l10n.dontHaveAnAccount
                          : l10n.alreadyHaveAnAccount,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: widget.onToggleFormType,
                      child: Text(
                        widget.isLogin ? ' ${l10n.signUp}' : ' ${l10n.login}',
                        style: kTextLinkStyle,
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
