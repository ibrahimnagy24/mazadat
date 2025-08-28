import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/global_favourites_cubit.dart';

/// Global Favourites Provider
/// Wrap your app with this provider to enable global favourites functionality
class GlobalFavouritesProvider extends StatelessWidget {
  final Widget child;

  const GlobalFavouritesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalFavouritesCubit>.value(
      value: GlobalFavouritesCubit.instance,
      child: child,
    );
  }
}

/// Extension to easily access GlobalFavouritesCubit from BuildContext
extension GlobalFavouritesContext on BuildContext {
  GlobalFavouritesCubit get globalFavourites => read<GlobalFavouritesCubit>();
  
  /// Watch for favourites changes
  GlobalFavouritesCubit get watchGlobalFavourites => watch<GlobalFavouritesCubit>();
}
