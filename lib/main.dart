
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_application_1/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

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
      ],
      home: AuthPage(changeLanguage: _changeLanguage),
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
                  isLogin: _isLogin,
                  onToggleFormType: _toggleFormType,
                  changeLanguage: widget.changeLanguage,
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 650,
      ),
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: isLogin
            ? MediaQuery.of(context).size.height * 0.7
            : MediaQuery.of(context).size.height * 0.8,
        borderRadius: 20,
        blur: 26,
        alignment: Alignment.center,
        border: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<Locale>(
                    icon: const Icon(Icons.language, color: Colors.white),
                    color: Colors.black,
                    onSelected: (Locale newLocale) {
                      changeLanguage(newLocale);
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
                      const PopupMenuItem<Locale>(
                        value: Locale('en'),
                        child: Text('EN', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem<Locale>(
                        value: Locale('fr'),
                        child: Text('FR', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem<Locale>(
                        value: Locale('uk'),
                        child: Text('UA', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Text(
                  isLogin ? l10n.login : l10n.createAccount,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isLogin
                      ? l10n.welcomeBack
                      : l10n.joinUsToStartYourJourney,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration:
                      _inputDecoration(l10n.email, Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
                      _inputDecoration(l10n.password, Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.pleaseEnterYourPassword;
                    }
                    return null;
                  },
                ),
                if (!isLogin) ...[
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration(
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
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDA4453), Color(0xFF89216B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      isLogin ? l10n.login : l10n.signUp,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? l10n.dontHaveAnAccount
                          : l10n.alreadyHaveAnAccount,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: onToggleFormType,
                      child: Text(
                        isLogin ? l10n.signUp : l10n.login,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
    );
  }
}
