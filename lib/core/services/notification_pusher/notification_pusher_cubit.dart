import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../app_config/app_config.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../utils/utility.dart';
import 'notification_event_model.dart';
import 'notification_pusher_state.dart';

class NotificationPusherCubit extends Cubit<NotificationPusherState> {
  NotificationPusherCubit() : super(NotificationPusherInitial());

  //---------------------------------VARIABLES----------------------------------//
  PusherChannelsFlutter? _pusher;
  NotificationEventModel? notificationData;
  String? _currentUserId;

  //---------------------------------FUNCTIONS----------------------------------//

  void init(String userId) async {
    cprint('🚀 [NOTIFICATION_PUSHER] Starting initialization for user $userId');
    _currentUserId = userId;
    await _pusherInit();
    await _pusherConnect();
    await _pusherSubscribe();
    cprint('✅ [NOTIFICATION_PUSHER] Initialization complete for user $userId');
  }

  void _userNotificationReceived(PusherEvent event, String userId) {
    cprint('🔔 [NOTIFICATION] Processing user notification for user $userId');
    cprint('📄 [NOTIFICATION] Notification data: ${event.data}');
    try {
      notificationData =
          NotificationEventModel.fromJson(jsonDecode(event.data));
      emit(UserNotificationReceived(
        userId: userId,
        notificationData: notificationData!,
      ));
    } catch (e) {
      cprint('❌ [NOTIFICATION] Error parsing notification data: $e');
    }
  }

  void _generalNotificationReceived(PusherEvent event, String userId) {
    cprint(
        '🔔 [NOTIFICATION] Processing general notification for user $userId');
    cprint('📄 [NOTIFICATION] General notification data: ${event.data}');
    try {
      notificationData =
          NotificationEventModel.fromJson(jsonDecode(event.data));
      emit(GeneralNotificationReceived(
        userId: userId,
        notificationData: notificationData!,
      ));
    } catch (e) {
      cprint('❌ [NOTIFICATION] Error parsing general notification data: $e');
    }
  }

  //---------------------------------PRIVATE METHODS----------------------------------//

  Future<void> _pusherInit() async {
    cprint('⚙️ [NOTIFICATION_PUSHER] Getting Pusher instance...');
    _pusher = PusherChannelsFlutter.getInstance();
    cprint('🔄 [NOTIFICATION_PUSHER] Starting initialization process...');
    emit(NotificationPusherInitLoading());

    try {
      await _pusher?.init(
        apiKey: AppConfig.PUSHER_API_KEY,
        cluster: AppConfig.PUSHER_API_CLUSTER,
        authEndpoint: AppConfig.PUSHER_AUTH_ENDPOINT,
        authParams: {
          'headers': {'Authorization': 'Bearer ${mainAppBloc.globalToken}'}
        },
        onConnectionStateChange: _onConnectionStateChange,
        onEvent: (event) => _onEvent(event: event),
        onError: (message, code, error) {
          cprint('❌ [NOTIFICATION_PUSHER] Error: $message (Code: $code)');
        },
        logToConsole: true,
      );
      cprint('✅ [NOTIFICATION_PUSHER] Initialization successful!');
      emit(NotificationPusherInitSuccess());
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER] Initialization failed: $e');
      emit(NotificationPusherInitError(e.toString()));
    }
  }

  dynamic _onConnectionStateChange(String currentState, String previousState) {
    cprint(
        '🔄 [NOTIFICATION_PUSHER] Connection state changed: $previousState → $currentState');
    final currStateIndex = NotificationPusherConnectionState.values
        .indexWhere((element) => element.name == currentState);
    if (currStateIndex != -1) {
      final currState =
          NotificationPusherConnectionState.values[currStateIndex];
      switch (currState) {
        case NotificationPusherConnectionState.CONNECTED:
          cprint('✅ [NOTIFICATION_PUSHER] Successfully connected!');
          break;
        case NotificationPusherConnectionState.CONNECTING:
          cprint('🔄 [NOTIFICATION_PUSHER] Connecting...');
          break;
        case NotificationPusherConnectionState.DISCONNECTED:
          cprint('🔴 [NOTIFICATION_PUSHER] Disconnected');
          break;
        case NotificationPusherConnectionState.RECONNECTING:
          cprint('🔄 [NOTIFICATION_PUSHER] Reconnecting...');
          break;
        case NotificationPusherConnectionState.DISCONNECTING:
          cprint('🔄 [NOTIFICATION_PUSHER] Disconnecting...');
          break;
      }
      emit(NotificationPusherConnectionStateChanged(currState));
    }
  }

  dynamic _onEvent({required PusherEvent event}) {
    cprint('📨 [NOTIFICATION_PUSHER] Event received: ${event.eventName}');

    if (_currentUserId == null) {
      cprint('⚠️ [NOTIFICATION_PUSHER] No user ID set, ignoring event');
      return;
    }

    // Handle DEV_USER_NOTIFICATION event
    if (event.eventName == 'DEV_USER_NOTIFICATION') {
      _userNotificationReceived(event, _currentUserId!);
      return;
    }

    // Handle SEND_NOTIFICATION_{userId} event
    if (event.eventName == 'SEND_NOTIFICATION_$_currentUserId') {
      _generalNotificationReceived(event, _currentUserId!);
      return;
    }

    cprint(
        '⚠️ [NOTIFICATION_PUSHER] Ignoring event: ${event.eventName} (not for user $_currentUserId)');
  }

  Future<void> _pusherConnect() async {
    cprint('🔗 [NOTIFICATION_PUSHER] Attempting to connect...');
    emit(NotificationPusherConnectionLoading());
    try {
      await _pusher?.connect();
      cprint('✅ [NOTIFICATION_PUSHER] Connection request sent successfully');
      emit(NotificationPusherConnectionSuccess());
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER] Connection failed: $e');
      emit(NotificationPusherConnectionError(e.toString()));
    }
  }

  Future<void> _pusherSubscribe() async {
    cprint(
        '📡 [NOTIFICATION_PUSHER] Subscribing to DEV_USER_NOTIFICATION channel...');
    emit(NotificationPusherSubscriptionLoading());
    try {
      await _pusher?.subscribe(channelName: 'DEV_USER_NOTIFICATION');
      cprint(
          '✅ [NOTIFICATION_PUSHER] Successfully subscribed to DEV_USER_NOTIFICATION');
      emit(NotificationPusherSubscriptionSuccess());
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER] Subscription failed: $e');
      emit(NotificationPusherSubscriptionError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    try {
      cprint('🔄 [NOTIFICATION_PUSHER] Closing connection...');
      await _pusher?.disconnect();
      cprint('✅ [NOTIFICATION_PUSHER] Connection closed successfully');
    } catch (e) {
      cprint('❌ [NOTIFICATION_PUSHER] Error closing connection: $e');
    }
    await super.close();
  }
}
