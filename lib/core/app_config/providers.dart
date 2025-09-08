// ignore: implementation_imports
import 'package:flutter_bloc/src/bloc_provider.dart'
    show BlocProvider, BlocProviderSingleChildWidget;

import '../../features/auction_details/auction_joining/logic/check_on_joining_auction_state.dart';
import '../../features/check_from_internet/controller/check_internet_cubit.dart';
import '../../features/more/logic/more_cubit.dart';
import '../../features/nav_layout/cubit/navbar_layout_cubit.dart';
import '../../features/user/logic/user_cubit.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<UserCubit>(
      create: (_) => UserCubit()..getUserDataStatesHandled(),
    ),
    BlocProvider<NavbarLayoutCubit>(create: (_) => NavbarLayoutCubit()),
    BlocProvider<MoreCubit>(create: (_) => MoreCubit()),
    BlocProvider<CheckOnJoiningAuctionCubit>(
        create: (_) => CheckOnJoiningAuctionCubit()),
    BlocProvider<InternetConnectionCubit>(
        create: (_) => InternetConnectionCubit()),
    BlocProvider<CheckOnJoiningAuctionCubit>(
        create: (_) => CheckOnJoiningAuctionCubit()),
  ];
}
