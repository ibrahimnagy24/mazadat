import 'package:flutter/material.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../../utils/utility.dart';
import 'models/notification_model.dart';
import 'notification_types.dart';

class FCMNotificationHandler {
  /// Handle notification based on type and action
  static void handleNotification(NotificationModel notification,
      {bool showInApp = true, bool shouldNavigate = false}) {
    cprint('Handling notification: ${notification.toString()}');

    // Show in-app notification if app is in foreground and requested
    if (showInApp) {
      _showInAppNotification(notification);
    }

    // Handle navigation based on notification type only if explicitly requested
    if (shouldNavigate) {
      _handleNavigation(notification);
    }

    // Handle custom actions
    _handleCustomActions(notification);
  }

  /// Show in-app notification overlay
  static void _showInAppNotification(NotificationModel notification) {
    final context = CustomNavigator.navigatorState.currentContext;
    if (context == null) {
      cprint('No context available for in-app notification');
      return;
    }

    // Check if overlay is available
    // final overlay = Overlay.maybeOf(context);
    // if (overlay == null) {
    //   cprint('No overlay available, falling back to snackbar notification');
    //   _showFallbackNotification(context, notification);
    //   return;
    // }

    // try {
    //   // Show overlay notification
    //   OverlayEntry? overlayEntry;
    //   overlayEntry = OverlayEntry(
    //     builder: (context) => InAppNotificationWidget(
    //       notification: notification,
    //       onDismiss: () {
    //         overlayEntry?.remove();
    //       },
    //       onTap: () {
    //         overlayEntry?.remove();
    //         _handleNavigation(notification);
    //       },
    //     ),
    //   );

    //   overlay.insert(overlayEntry);

    //   // Auto dismiss after 4 seconds
    //   Future.delayed(const Duration(seconds: 4), () {
    //     try {
    //       overlayEntry?.remove();
    //     } catch (e) {
    //       cprint('Error removing overlay entry: $e');
    //     }
    //   });
    // } catch (e) {
    //   cprint('Error showing overlay notification: $e');
    //   _showFallbackNotification(context, notification);
    // }
  }

  /// Show fallback notification when overlay is not available
  static void _showFallbackNotification(
      BuildContext context, NotificationModel notification) {
    try {
      // Use ToastService as fallback instead of SnackBar
      // ToastService.showCustom(
      //   message: notification.title ?? notification.body ?? 'New Notification',
      //   context: context,
      //   toastStatusType: ToastStatusType.success,
      // );

      cprint('Showed fallback toast notification');
    } catch (e) {
      cprint('Error showing fallback toast notification: $e');
    }
  }

  /// Handle navigation based on notification type
  static void _handleNavigation(NotificationModel notification) {
    final type = notification.type?.toLowerCase();
    final action = notification.action?.toLowerCase();

    switch (type) {
      case NotificationTypes.auction:
        _handleAuctionNotification(notification);
        break;
      case NotificationTypes.order:
        _handleOrderNotification(notification);
        break;
      case NotificationTypes.payment:
        _handlePaymentNotification(notification);
        break;
      case NotificationTypes.general:
        _handleGeneralNotification(notification);
        break;
      case NotificationTypes.promotion:
        _handlePromotionNotification(notification);
        break;
      default:
        _handleDefaultNotification(notification);
        break;
    }
  }

  /// Handle auction-related notifications
  static void _handleAuctionNotification(NotificationModel notification) {
    final auctionId = notification.getDataValue('auction_id') ??
        notification.getDataValue('auctionId');

    if (auctionId != null) {
      // Navigate to auction details
      CustomNavigator.push(
        Routes.VIEW_AUCTION_DETAILS,
        pathParameters: {'auctionId': auctionId},
      );
    } else {
      // Navigate to search/home (no direct auctions list route)
      CustomNavigator.push(Routes.SEARCH);
    }
  }

  /// Handle order-related notifications
  static void _handleOrderNotification(NotificationModel notification) {
    final orderId = notification.getDataValue('order_id') ??
        notification.getDataValue('orderId');

    if (orderId != null) {
      // Navigate to order details or my purchases
      CustomNavigator.push(Routes.MY_PURCHASES);
    } else {
      // Navigate to orders list
      CustomNavigator.push(Routes.MY_PURCHASES);
    }
  }

  /// Handle payment-related notifications
  static void _handlePaymentNotification(NotificationModel notification) {
    final paymentId = notification.getDataValue('payment_id') ??
        notification.getDataValue('paymentId');

    // Navigate to wallet or payment history
    CustomNavigator.push(Routes.VIEW_WALLET_HISTORY);
  }

  /// Handle general notifications
  static void _handleGeneralNotification(NotificationModel notification) {
    final targetScreen = notification.getDataValue('target_screen') ??
        notification.getDataValue('targetScreen');

    if (targetScreen != null) {
      // Navigate to specific screen
      _navigateToScreen(targetScreen);
    }
    // Don't navigate anywhere if no target screen is specified
  }

  /// Handle promotion notifications
  static void _handlePromotionNotification(NotificationModel notification) {
    final promotionId = notification.getDataValue('promotion_id') ??
        notification.getDataValue('promotionId');

    // Only navigate if there's a specific promotion to show
    // Otherwise just show the notification without navigation
    if (promotionId != null) {
      // TODO: Navigate to specific promotion when route is available
      cprint('Promotion notification with ID: $promotionId');
    }
  }

  /// Handle default notification (fallback)
  static void _handleDefaultNotification(NotificationModel notification) {
    // Default action - just log, don't navigate anywhere
    cprint('Default notification handled: ${notification.title}');
  }

  /// Handle custom actions
  static void _handleCustomActions(NotificationModel notification) {
    final action = notification.action?.toLowerCase();

    switch (action) {
      case 'open_url':
        final url = notification.getDataValue('url');
        if (url != null) {
          _openUrl(url);
        }
        break;
      case 'show_dialog':
        _showCustomDialog(notification);
        break;
      case 'refresh_data':
        _refreshAppData();
        break;
      default:
        // No custom action
        break;
    }
  }

  /// Navigate to specific screen by name
  static void _navigateToScreen(String screenName) {
    switch (screenName.toLowerCase()) {
      case 'home':
        CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
        break;
      case 'profile':
        CustomNavigator.push(Routes.PROFILE);
        break;
      case 'favourites':
        CustomNavigator.push(Routes.CHOOSE_FAV_CATEGORY);
        break;
      case 'wallet':
        CustomNavigator.push(Routes.VIEW_WALLET_HISTORY);
        break;
      case 'my_purchases':
        CustomNavigator.push(Routes.MY_PURCHASES);
        break;
      case 'my_sales':
        CustomNavigator.push(Routes.MY_SALES);
        break;
      case 'search':
        CustomNavigator.push(Routes.SEARCH);
        break;
      default:
        cprint('Unknown screen name for navigation: $screenName');
        break;
    }
  }

  /// Open URL in browser
  static void _openUrl(String url) {
    // TODO: Implement URL opening using url_launcher package
    cprint('Opening URL: $url');
  }

  /// Show custom dialog
  static void _showCustomDialog(NotificationModel notification) {
    final context = CustomNavigator.navigatorState.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(notification.title ?? 'Notification'),
          content: Text(notification.body ?? ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  /// Refresh app data
  static void _refreshAppData() {
    // TODO: Implement app data refresh logic
    cprint('Refreshing app data...');
  }
}
