import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../core/app_config/app_config.dart';
import '../../../core/assets/app_audio.dart';
import '../../../core/shared/blocs/main_app_bloc.dart';
import '../../../core/utils/utility.dart';
import 'bid_event_model.dart';
import 'pusher_state.dart';

class PusherCubit extends Cubit<PusherState> {
  PusherCubit() : super(PusherInitial());

  //---------------------------------VARIABLES----------------------------------//
  PusherChannelsFlutter? _pusher;
  BidEventModel? bidData;
  final _player = AudioPlayer();

  //---------------------------------FUNCTIONS----------------------------------//

  void init(int auctionId) async {
    cprint('🚀 [PUSHER] Starting initialization for auction $auctionId');
    await _pusherInit(auctionId);
    await _pusherConnect();
    await _pusherSubscribe();
    cprint('✅ [PUSHER] Initialization complete for auction $auctionId');
  }

  void _auctionBidReceived(PusherEvent event, int auctionId) {
    cprint('🎯 [AUCTION] Processing bid for auction $auctionId');
    cprint('📄 [AUCTION] Bid data: ${event.data}');
    try {
      startAudio(AppAudio.bidReceived);
    } catch (e) {
      cprint('❌ [AUCTION] Error playing audio: $e');
    }
    bidData = BidEventModel.fromJson(jsonDecode(event.data));
    emit(AuctionBidReceived(auctionId: auctionId, bidData: bidData!));
  }

  void _auctionEnded(PusherEvent event, int auctionId) {
    cprint('🎯 [AUCTION] Processing ended for auction $auctionId');
    emit(AuctionEnded(auctionId: auctionId));
  }

  void _auctionStarted(PusherEvent event, int auctionId) {
    cprint('🎯 [AUCTION] Processing started for auction $auctionId');
    emit(AuctionStarted(auctionId: auctionId));
  }

  Future<void> startAudio(String path, {bool needVibration = false}) async {
    await _player.setAsset(path);
    _player.play();
    if (needVibration) {
      await HapticFeedback.mediumImpact();
    }
  }

  Future<void> disposeAudio() async {
    _player.dispose();
  }

//---------------------------------PRIVATE METHODS----------------------------------//

  Future<void> _pusherInit(int auctionId) async {
    cprint('⚙️ [PUSHER] Getting Pusher instance...');
    _pusher = PusherChannelsFlutter.getInstance();
    cprint('🔄 [PUSHER] Starting initialization process...');
    emit(PusherInitLoading());

    try {
      await _pusher?.init(
        apiKey: AppConfig.PUSHER_API_KEY,
        cluster: AppConfig.PUSHER_API_CLUSTER,
        authEndpoint: AppConfig.PUSHER_AUTH_ENDPOINT,
        authParams: {
          'headers': {'Authorization': 'Bearer ${mainAppBloc.globalToken}'}
        },
        onConnectionStateChange: _onConnectionStateChange,
        onEvent: (event) => _onEvent(event: event, auctionId: auctionId),
        onError: (message, code, error) {
          cprint('❌ [PUSHER] Error: $message (Code: $code)');
        },
        logToConsole: true,
      );
      cprint('✅ [PUSHER] Initialization successful!');
      emit(PusherInitSuccess());
    } catch (e) {
      cprint('❌ [PUSHER] Initialization failed: $e');
      emit(PusherInitError(e.toString()));
    }
  }

  dynamic _onConnectionStateChange(String currentState, String previousState) {
    cprint(
        '🔄 [PUSHER] Connection state changed: $previousState → $currentState');
    final currStateIndex = PusherConnectionState.values
        .indexWhere((element) => element.name == currentState);
    if (currStateIndex != -1) {
      final currState = PusherConnectionState.values[currStateIndex];
      switch (currState) {
        case PusherConnectionState.CONNECTED:
          cprint('✅ [PUSHER] Successfully connected!');
          break;
        case PusherConnectionState.CONNECTING:
          cprint('🔄 [PUSHER] Connecting...');
          break;
        case PusherConnectionState.DISCONNECTED:
          cprint('🔴 [PUSHER] Disconnected');
          break;
        case PusherConnectionState.RECONNECTING:
          cprint('🔄 [PUSHER] Reconnecting...');
          break;
        case PusherConnectionState.DISCONNECTING:
          cprint('🔄 [PUSHER] Disconnecting...');
          break;
      }
      emit(PusherConnectionStateChanged(currState));
    }
  }

  dynamic _onEvent({required PusherEvent event, required int auctionId}) {
    cprint('📨 [PUSHER] Event received: ${event.eventName}');
    if (event.eventName == 'START_BIDDING_$auctionId') {
      _auctionStarted(event, auctionId);
      return;
    }
    if (event.eventName == 'PLACE_BID_$auctionId') {
      _auctionBidReceived(event, auctionId);
      return;
    }
    if (event.eventName == 'END_BIDDING_$auctionId') {
      _auctionEnded(event, auctionId);
      return;
    }
    cprint(
        '⚠️ [PUSHER] Ignoring event: ${event.eventName} (not for auction $auctionId)');
  }

  Future<void> _pusherConnect() async {
    cprint('🔗 [PUSHER] Attempting to connect...');
    emit(PusherConnectionLoading());
    try {
      await _pusher?.connect();
      cprint('✅ [PUSHER] Connection request sent successfully');
      emit(PusherConnectionSuccess());
    } catch (e) {
      cprint('❌ [PUSHER] Connection failed: $e');
      emit(PusherConnectionError(e.toString()));
    }
  }

  Future<void> _pusherSubscribe() async {
    cprint('📡 [PUSHER] Subscribing to DEV_BIDDING_FLOW channel...');
    emit(PusherSubscriptionLoading());
    try {
      await _pusher?.subscribe(channelName: 'DEV_BIDDING_FLOW');
      cprint('✅ [PUSHER] Successfully subscribed to DEV_BIDDING_FLOW');
      emit(PusherSubscriptionSuccess());
    } catch (e) {
      cprint('❌ [PUSHER] Subscription failed: $e');
      emit(PusherSubscriptionError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    try {
      cprint('🔄 [PUSHER] Closing connection...');
      await _pusher?.disconnect();
      cprint('✅ [PUSHER] Connection closed successfully');
    } catch (e) {
      cprint('❌ [PUSHER] Error closing connection: $e');
    }
    try {
      await disposeAudio();
      cprint('✅ [PUSHER] Audio disposed successfully');
    } catch (e) {
      cprint('❌ [PUSHER] Error disposing audio: $e');
    }
    await super.close();
  }
}
