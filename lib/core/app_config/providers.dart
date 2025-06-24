// ignore: implementation_imports
import 'package:flutter_bloc/src/bloc_provider.dart'
    show BlocProvider, BlocProviderSingleChildWidget;

import '../../features/check_from_internet/controller/check_internet_cubit.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/more/logic/more_cubit.dart';
import '../../features/nav_layout/cubit/navbar_layout_cubit.dart';
import '../../features/user/user_data/logic/user_cubit.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<UserCubit>(
      create: (_) => UserCubit()..getUserDataStatesHandled(),
    ),
    BlocProvider<NavbarLayoutCubit>(create: (_) => NavbarLayoutCubit()),
    BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
    BlocProvider<MoreCubit>(create: (_) => MoreCubit()),
    BlocProvider<InternetConnectionCubit>(
        create: (_) => InternetConnectionCubit()),
  ];
}
