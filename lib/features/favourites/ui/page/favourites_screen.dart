import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/favourites_cubit.dart';
import '../../logic/favourites_state.dart';
import 'favourites_mobile_design.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure favourites state is correct when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FavouritesCubit.instance.ensureFavouritesLoaded();
    });

    return BlocBuilder<FavouritesCubit, FavouritesState>(
      bloc: FavouritesCubit.instance,
      builder: (context, state) {
        return const ChooseCategoryMobilePortraitDesignScreen();
      },
    );
  }
}
