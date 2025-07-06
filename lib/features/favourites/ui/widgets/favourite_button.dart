import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/enums/toggle_favorite_auction_enum.dart';
import '../../data/params/toggle_favourites_params.dart';
import '../../logic/toggle_favourite_auction_cubit.dart';
import '../../logic/toggle_favourite_state.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton(
      {super.key,
      required this.id,
      this.isFav = false,
      this.withBackGround = true});
  final int? id;
  final bool isFav;

  final bool withBackGround;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool value = false;
  @override
  void initState() {
    value = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleFavouriteAuctionCubit(),
      child: BlocBuilder<ToggleFavouriteAuctionCubit, ToggleFavouriteState>(
          builder: (context, state) {
        return InkWell(
          onTap: () => context
              .read<ToggleFavouriteAuctionCubit>()
              .toggleFavouriteAuction(ToggleFavouritesParams(
                  id: widget.id,
                  action: value
                      ? ToggleFavoriteAuctions.UNFAVORITE
                      : ToggleFavoriteAuctions.FAVORITE,
                  onSuccess: () {
                    value = !value;
                    setState(() {});
                  })),
          child: Container(
            padding:
                widget.withBackGround ? EdgeInsets.all(11.w) : EdgeInsets.zero,
            decoration: widget.withBackGround
                ? BoxDecoration(
                    color: AppColors.backgroundBody,
                    shape: BoxShape.circle,
                    boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, -1),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Colors.white.withValues(alpha: 0.2))
                      ])
                : null,
            child: customImageIconSVG(
              imageName: value ? AppSvg.fillFav : AppSvg.fav,
              width: 18.w,
              height: 18.w,
            ),
          ),
        );
      }),
    );
  }
}
