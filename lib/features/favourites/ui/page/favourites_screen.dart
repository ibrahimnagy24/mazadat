import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../logic/favourites_cubit.dart';
import '../../logic/favourites_state.dart';
import 'favourites_mobile_design.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesCubit()..favouritesAuctionStatesHandled(),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return CustomScreenTypeLayoutWidget(
            mobilePortrait: (context) =>
                const ChooseCategoryMobilePortraitDesignScreen(),
            mobileLandscape: (context) =>
                const ChooseCategoryMobilePortraitDesignScreen(),
          );
        },
      ),
    );
  }
}
