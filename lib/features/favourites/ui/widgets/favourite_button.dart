import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/utility.dart';
import '../../data/enums/toggle_favorite_auction_enum.dart';
import '../../data/params/toggle_favourites_params.dart';
import '../../logic/favourites_cubit.dart';
import '../../logic/favourites_service.dart';
import '../../logic/favourites_state.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key,
    required this.id,
    @Deprecated(
        'isFav is now automatically determined from global favourites state')
    this.isFav = false,
    this.withBackGround = true,
    this.height,
    this.width,
    this.favIconHeight = 18,
    this.favIconWidth = 18,
    this.child,
  });
  final int? id;
  @Deprecated(
      'isFav is now automatically determined from global favourites state')
  final bool isFav;

  final bool withBackGround;
  final double? height;
  final double? width;
  final double? favIconHeight;
  final double? favIconWidth;
  final Widget? child;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  void initState() {
    super.initState();
    // Load favourites ONLY ONCE when first button appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FavouritesService.initializeGlobalFavourites(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!Utility.isUserLoggedIn()) {
      return const SizedBox.shrink();
    }
    return BlocBuilder<FavouritesCubit, FavouritesState>(
        bloc: FavouritesCubit.instance,
        builder: (context, state) {
          // Auto-determine favourite status from global singleton
          final bool isFavourite = FavouritesCubit.instance.isFavourite(widget.id);

          return InkWell(
            onTap: () {
              // Use the global singleton's toggle method
              FavouritesCubit.instance.toggleFavouriteAuction(
                ToggleFavouritesParams(
                  id: widget.id,
                  action: isFavourite
                      ? ToggleFavoriteAuctions.UNFAVORITE
                      : ToggleFavoriteAuctions.FAVORITE,
                ),
              );
            },
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: widget.withBackGround
                  ? BoxDecoration(
                      color: AppColors.backgroundBody,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, -1),
                          blurRadius: 8,
                          spreadRadius: 0,
                          color: Colors.white.withValues(alpha: 0.2),
                        )
                      ],
                    )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    isFavourite ? AppSvg.fillFav : AppSvg.fav,
                    width: widget.favIconWidth,
                    height: widget.favIconHeight,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
