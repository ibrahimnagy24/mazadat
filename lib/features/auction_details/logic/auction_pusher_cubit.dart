import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../../core/app_config/app_config.dart';
import '../../../../../core/utils/utility.dart';
import '../../../core/shared/blocs/main_app_bloc.dart';
import '../data/model/auction_pusher_model.dart';
part 'auction_pusher_state.dart';

class AuctionPusherCubit extends Cubit<AuctionPusherState> {
  AuctionPusherCubit() : super(AuctionPusherInitial());

  //---------------------------------VARIABLES----------------------------------//
  PusherChannelsFlutter? _pusher;
  PusherStateEnum? currentState;
  AuctionPusherModel? details;

  //---------------------------------FUNCTIONS----------------------------------//

  void init(int id) async {
    await _pusherInit(id);
    await _pusherConnect();
    await _pusherSubscribe();
  }

  Future<void> _pusherInit(int id) async {
    _pusher = PusherChannelsFlutter.getInstance();
    // _viewLoadingOverlay();

    emit(ChannelInitLoading());
    try {
      await _pusher?.init(
        apiKey: AppConfig.PUSHER_API_KEY,
        cluster: AppConfig.PUSHER_API_CLUSTER,
        authEndpoint: AppConfig.PUSHER_AUTH_ENDPOINT,
        authParams: {
          'headers': {'Authorization': 'Bearer ${mainAppBloc.globalToken}'}
        },
        onDecryptionFailure: (event, reason) {
          cprint(event.toString());
          cprint(reason.toString());
        },
        onConnectionStateChange: _onConnectionStateChange,
        onEvent: (event) => _onEvent(event: event, id: id),
        onError: (message, code, error) {
          cprint(message.toString());
          cprint(code.toString());
          cprint(error.toString());
        },
        onMemberAdded: (channelName, member) {
          cprint(channelName.toString());
          cprint(member.toString());
        },
        onMemberRemoved: (channelName, member) {
          cprint(channelName.toString());
          cprint(member.toString());
        },
        onSubscriptionSucceeded: (channelName, data) {
          cprint(channelName.toString());
          cprint(data.toString());
        },
        onSubscriptionError: (message, error) {
          cprint(message.toString());
          cprint(error.toString());
        },
        onAuthorizer: (channelName, socketId, options) {
          cprint(channelName.toString());
          cprint(socketId.toString());
          cprint(options.toString());
        },
        logToConsole: true,
      );
      emit(ChannelInitSuccess());
    } catch (e) {
      emit(ChannelInitError(e.toString()));
    }
  }

  dynamic _onConnectionStateChange(String currentState, String previousState) {
    // This is your previous state and we will convert it to our enum
    final prevStateIndex = PusherStateEnum.values
        .indexWhere((element) => element.name == previousState);
    final prevState = PusherStateEnum.values[prevStateIndex];
    cprint('state was is ${prevState.name} so you need to handle it');

    emit(RoomCurrentState(prevState));

    // This is your current state and we will convert it to our enum
    final currStateIndex = PusherStateEnum.values
        .indexWhere((element) => element.name == currentState);
    final currState = PusherStateEnum.values[currStateIndex];
    cprint('now current state is ${currState.name} so you need to handle it');

    emit(RoomCurrentState(currState));
  }

  dynamic _onEvent({required PusherEvent event, required int id}) {
    if (event.eventName != 'PLACE_BID_$id') return;
    log("event ${event.eventName}");
    log("event ${event.data}");
    details = AuctionPusherModel.fromJson(jsonDecode(event.data));

    emit(BiddingState(details!));
  }

  Future<void> _pusherConnect() async {
    emit(const ChannelConnectionLoading());
    try {
      await _pusher?.connect();
      emit(const ChannelConnectionSuccess());
    } catch (e) {
      emit(ChannelConnectionError(e.toString()));
    }
  }

  Future<void> _pusherSubscribe() async {
    emit(const ChannelSubscribedLoading());

    try {
      await _pusher?.subscribe(
        channelName: 'DEV_BIDDING_FLOW',
      );
      emit(const ChannelSubscribedSuccess());
    } catch (e) {
      emit(ChannelSubscribedError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    try {
      await _pusher?.disconnect();
    } catch (e) {
      cprint(e.toString());
    }

    await super.close();
  }
}

enum PusherStateEnum {
  RECONNECTING,
  DISCONNECTED,
  CONNECTING,
  CONNECTED,
  DISCONNECTING
}
