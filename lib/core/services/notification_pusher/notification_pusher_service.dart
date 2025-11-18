import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../utils/utility.dart';
import '../../utils/enums/enums.dart';
import '../../../features/user/logic/user_cubit.dart';
import '../../../features/user/logic/user_state.dart';
import 'notification_pusher_cubit.dart';
import 'notification_pusher_state.dart';

class NotificationPusherService {
  static NotificationPusherCubit? _cubit;
  static bool _waitingForUserData = false;

  /// Initialize the notification pusher service globally
  /// This should be called after the user logs in
  static Future<void> initializeGlobal(BuildContext context, String userId) async {
    try {
      _cubit = context.read<NotificationPusherCubit>();
      cprint('🌍 [NOTIFICATION_PUSHER_SERVICE] Initializing globally for user: $userId');
      _cubit?.init(userId);
      cprint('✅ [NOTIFICATION_PUSHER_SERVICE] Global initialization complete');
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Global initialization failed: $e');
    }
  }

  /// Initialize with current user from mainAppBloc
  static Future<void> initializeWithCurrentUser(BuildContext context) async {
    try {
      final userId = mainAppBloc.globalUserData?.id.toString();
      if (userId != null && userId.isNotEmpty) {
        await initializeGlobal(context, userId);
      } else {
        cprint('⚠️ [NOTIFICATION_PUSHER_SERVICE] No user ID found in mainAppBloc');
      }
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Error getting user ID: $e');
    }
  }

  /// Get the current cubit instance
  static NotificationPusherCubit? get instance => _cubit;

  /// Check if the service is initialized
  static bool get isInitialized => _cubit != null;

  /// Check if the service is waiting for user data
  static bool get isWaitingForUserData => _waitingForUserData;

  /// Listen to notification events globally
  /// Returns a BlocListener widget that should be used in the widget tree
  static Widget createNotificationListener({
    required Widget child,
    required Function(UserNotificationReceived) onUserNotification,
    required Function(GeneralNotificationReceived) onGeneralNotification,
    Function(NotificationPusherConnectionStateChanged)? onConnectionStateChanged,
  }) {
    return BlocListener<NotificationPusherCubit, NotificationPusherState>(
      listener: (context, state) {
        if (state is UserNotificationReceived) {
          onUserNotification(state);
        } else if (state is GeneralNotificationReceived) {
          onGeneralNotification(state);
        } else if (state is NotificationPusherConnectionStateChanged && onConnectionStateChanged != null) {
          onConnectionStateChanged(state);
        }
      },
      child: child,
    );
  }

  /// Disconnect the notification pusher
  static Future<void> disconnect() async {
    try {
      cprint('🔌 [NOTIFICATION_PUSHER_SERVICE] Disconnecting global service');
      await _cubit?.close();
      _cubit = null;
      _waitingForUserData = false;
      cprint('✅ [NOTIFICATION_PUSHER_SERVICE] Global service disconnected');
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Error disconnecting: $e');
    }
  }

  /// Reinitialize with new user (useful for user switching)
  static Future<void> reinitialize(BuildContext context, String newUserId) async {
    try {
      cprint('🔄 [NOTIFICATION_PUSHER_SERVICE] Reinitializing for new user: $newUserId');
      await disconnect();
      await initializeGlobal(context, newUserId);
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Reinitialization failed: $e');
    }
  }

  /// Auto-start notification pusher when entering main app (navbar layout)
  /// This should be called when the user enters the main app area
  static Future<void> autoStartOnNavbarEntry(BuildContext context) async {
    try {
      cprint('🏠 [NOTIFICATION_PUSHER_SERVICE] Auto-starting on navbar entry');
      
      // Debug initial state
      cprint('🔍 [NOTIFICATION_PUSHER_SERVICE] autoStartOnNavbarEntry Debug:');
      cprint('   - Utility.isUserLoggedIn(): ${Utility.isUserLoggedIn()}');
      cprint('   - mainAppBloc.globalUserData: ${mainAppBloc.globalUserData}');
      cprint('   - isInitialized: $isInitialized');
      
      // Check if user is logged in and not a visitor
      if (!Utility.isUserLoggedIn()) {
        cprint('⚠️ [NOTIFICATION_PUSHER_SERVICE] User not logged in, skipping auto-start');
        _waitingForUserData = false;
        return;
      }

      final userData = mainAppBloc.globalUserData;
      if (userData == null) {
        cprint('⏳ [NOTIFICATION_PUSHER_SERVICE] User data not available yet, will wait for it...');
        _waitingForUserData = true;
        return;
      }

      cprint('🔍 [NOTIFICATION_PUSHER_SERVICE] User data found:');
      cprint('   - User ID: ${userData.id}');
      cprint('   - User type: ${userData.userType}');
      cprint('   - User type == visitor: ${userData.userType == UserType.visitor}');

      // Don't start for visitors
      if (userData.userType == UserType.visitor) {
        cprint('👤 [NOTIFICATION_PUSHER_SERVICE] User is visitor, skipping auto-start');
        _waitingForUserData = false;
        return;
      }

      // Don't start if already initialized
      if (isInitialized) {
        cprint('✅ [NOTIFICATION_PUSHER_SERVICE] Already initialized, skipping auto-start');
        _waitingForUserData = false;
        return;
      }

      // Start the service with current user
      final userId = userData.id.toString();
      cprint('🚀 [NOTIFICATION_PUSHER_SERVICE] Starting initialization for user: $userId');
      await initializeGlobal(context, userId);
      _waitingForUserData = false;
      cprint('🎉 [NOTIFICATION_PUSHER_SERVICE] Auto-started successfully for user: $userId');
      
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Auto-start failed: $e');
      _waitingForUserData = false;
    }
  }

  /// Auto-stop notification pusher when leaving main app
  /// This should be called when navigating to auth screens or app closes
  static Future<void> autoStopOnNavbarExit() async {
    try {
      cprint('🚪 [NOTIFICATION_PUSHER_SERVICE] Auto-stopping on navbar exit');
      
      if (!isInitialized && !_waitingForUserData) {
        cprint('⚠️ [NOTIFICATION_PUSHER_SERVICE] Not initialized and not waiting, skipping auto-stop');
        return;
      }

      await disconnect();
      cprint('🛑 [NOTIFICATION_PUSHER_SERVICE] Auto-stopped successfully');
      
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER_SERVICE] Auto-stop failed: $e');
    }
  }

  /// Check if user should have notification pusher active
  static bool shouldBeActive() {
    // Must be logged in
    if (!Utility.isUserLoggedIn()) return false;
    
    // Must have user data
    final userData = mainAppBloc.globalUserData;
    if (userData == null) return false;
    
    // Must not be a visitor
    if (userData.userType == UserType.visitor) return false;
    
    return true;
  }

  /// Create a lifecycle-aware notification listener that automatically manages the service
  static Widget createLifecycleAwareListener({
    required Widget child,
    required Function(UserNotificationReceived) onUserNotification,
    required Function(GeneralNotificationReceived) onGeneralNotification,
    Function(NotificationPusherConnectionStateChanged)? onConnectionStateChanged,
  }) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, userState) {
        if (userState is UserDataSuccess) {
          cprint('👤 [NOTIFICATION_PUSHER_SERVICE] User data loaded successfully');
          
          // Debug current state
          cprint('🔍 [NOTIFICATION_PUSHER_SERVICE] Debug state:');
          cprint('   - _waitingForUserData: $_waitingForUserData');
          cprint('   - shouldBeActive(): ${shouldBeActive()}');
          cprint('   - isInitialized: $isInitialized');
          cprint('   - User type: ${mainAppBloc.globalUserData?.userType}');
          cprint('   - User ID: ${mainAppBloc.globalUserData?.id}');
          cprint('   - Is logged in: ${Utility.isUserLoggedIn()}');
          
          // If we were waiting for user data, try to start now
          if (_waitingForUserData && shouldBeActive() && !isInitialized) {
            cprint('🔄 [NOTIFICATION_PUSHER_SERVICE] Retrying auto-start now that user data is available');
            autoStartOnNavbarEntry(context);
          }
          // If user data loaded and we should be active but aren't initialized
          else if (shouldBeActive() && !isInitialized && !_waitingForUserData) {
            cprint('🚀 [NOTIFICATION_PUSHER_SERVICE] Starting service with newly loaded user data');
            autoStartOnNavbarEntry(context);
          }
          // If user became visitor or logged out, stop the service
          else if (!shouldBeActive() && isInitialized) {
            cprint('🛑 [NOTIFICATION_PUSHER_SERVICE] User became visitor or logged out, stopping service');
            autoStopOnNavbarExit();
          }
          else {
            cprint('⚠️ [NOTIFICATION_PUSHER_SERVICE] No action taken - conditions not met');
          }
        } else if (userState is UserDataLoading) {
          cprint('⏳ [NOTIFICATION_PUSHER_SERVICE] User data is loading...');
        } else if (userState is UserDataError) {
          cprint('❌ [NOTIFICATION_PUSHER_SERVICE] User data loading failed');
          _waitingForUserData = false;
        }
      },
      child: createNotificationListener(
        onUserNotification: onUserNotification,
        onGeneralNotification: onGeneralNotification,
        onConnectionStateChanged: onConnectionStateChanged,
        child: child,
      ),
    );
  }
}
