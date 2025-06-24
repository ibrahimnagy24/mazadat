import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../navigation/custom_navigation.dart';
import '../../utils/utility.dart';

class DeepLinkHandler {
  static final _appLinks = AppLinks();
  static bool _initialUriIsHandled = false;
  static StreamSubscription? _streamSubscription;

  static Future<void> initDeepLinks(Function(Uri) onLink) async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;

      // Wait for widget binding to be initialized
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final uri = await _appLinks.getInitialAppLink();
          cprint('Initial URI: ${uri?.toString()}');
          if (uri != null) {
            // Increase delay for cold start
            await Future.delayed(const Duration(seconds: 3));
            try {
              onLink(uri);
            } catch (e) {
              cprint(e.toString());
            }
          }
        } catch (e) {
          debugPrint('Failed to get initial uri: $e');
        }
      });
    }

    // Listen to app links while app is in foreground
    _streamSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        try {
          onLink(uri);
        } catch (e) {
          cprint(e.toString());
        }
      },
      onError: (err) {
        debugPrint('Failed to handle deep link: $err');
      },
    );
  }

  static void dispose() {
    _streamSubscription?.cancel();
  }

  static void handleDeepLink(Uri uri) {
    // Example of handling different deep link patterns
    switch (uri.host) {
      case 'app':
        try {
          _handleAppDeepLink(uri);
        } catch (e) {
          cprint(e.toString());
        }

        break;
      default:
        if (uri.host == 'barq.innoeg.com') {
          _handleAppDeepLink(uri);
        }
    }
  }

  static Future<void> _handleAppDeepLink(Uri uri) async {
    final pathSegments = uri.pathSegments;
    if (pathSegments.isEmpty) return;

    // Increase retry count and delay for cold start
    int maxRetries = 5; // Increased from 3
    int currentTry = 0;

    while (currentTry < maxRetries) {
      try {
        if (CustomNavigator.navigatorState.currentState != null &&
            CustomNavigator.navigatorState.currentState!.mounted) {
          switch (pathSegments[0]) {
            case 'join-room':
              if (pathSegments.length > 1) {
                final gameCode = pathSegments[1];
              }
              return;
          }
          break;
        }
      } catch (e) {
        cprint('Deep link navigation error: $e');
      }
      currentTry++;
      // Increase delay between retries
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
