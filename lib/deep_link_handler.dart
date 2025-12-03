
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_application_1/email_verification_landing_page.dart'; // Import the new page

class DeepLinkHandler {
  final BuildContext context;
  StreamSubscription? _sub;

  DeepLinkHandler(this.context);

  Future<void> init() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleLink(Uri.parse(initialLink));
      }
    } catch (e) {
      // Error
    }

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        _handleLink(Uri.parse(link));
      }
    }, onError: (err) {
      // Error
    });
  }

  void _handleLink(Uri link) {
    // We are looking for the oobCode, mode=verifyEmail
    if (link.queryParameters.containsKey('oobCode') &&
        link.queryParameters['mode'] == 'verifyEmail') {
          
      final oobCode = link.queryParameters['oobCode']!;
      
      // Navigate to the new verification landing page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerificationLandingPage(oobCode: oobCode),
        ),
      );
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
