
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'l10n/app_localizations.dart';
import 'styles.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _timer;
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!_isEmailVerified) {
      _sendVerificationEmail();
      _timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (_isEmailVerified) {
      _timer?.cancel();
    }
  }

  Future<void> _sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: kBackgroundDecoration,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 400,
                  borderRadius: 20,
                  blur: 10,
                  alignment: Alignment.center,
                  border: 0,
                  linearGradient: kGlassmorphicGradient,
                  borderGradient: kGlassmorphicBorderGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.verifyYourEmail,
                          textAlign: TextAlign.center,
                          style: kTitleTextStyle,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          l10n.verificationLinkSent,
                          textAlign: TextAlign.center,
                          style: kSubtitleTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: kButtonBoxDecoration,
                          child: ElevatedButton(
                            onPressed: _sendVerificationEmail,
                            style: kElevatedButtonStyle,
                            child: Text(l10n.resendEmail, style: kButtonTextStyle),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () => FirebaseAuth.instance.signOut(),
                          child: Text(
                            l10n.cancel,
                            style: kTextLinkStyle.copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
