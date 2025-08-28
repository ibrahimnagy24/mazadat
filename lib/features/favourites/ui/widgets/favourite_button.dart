import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/utility.dart';
import '../../data/enums/toggle_favorite_auction_enum.dart';
import '../../data/params/toggle_favourites_params.dart';
import '../../logic/toggle_favourite_auction_cubit.dart';
import '../../logic/toggle_favourite_state.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key,
    required this.id,
    this.isFav = false,
    this.withBackGround = true,
    this.height,
    this.width,
    this.favIconHeight = 18,
    this.favIconWidth = 18,
  });
  final int? id;
  final bool isFav;

  final bool withBackGround;
  final double? height;
  final double? width;
  final double? favIconHeight;
  final double? favIconWidth;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool value = false;
  @override
  void initState() {
    super.initState();
    value = widget.isFav;
  }

  @override
  Widget build(BuildContext context) {
    if (!Utility.isUserLoggedIn()) {
      return const SizedBox.shrink();
    }
    return BlocProvider(
      create: (context) => ToggleFavouriteAuctionCubit(),
      child: BlocBuilder<ToggleFavouriteAuctionCubit, ToggleFavouriteState>(
          builder: (context, state) {
        return InkWell(
          onTap: () => context
              .read<ToggleFavouriteAuctionCubit>()
              .toggleFavouriteAuction(
                ToggleFavouritesParams(
                  id: widget.id,
                  action: value
                      ? ToggleFavoriteAuctions.UNFAVORITE
                      : ToggleFavoriteAuctions.FAVORITE,
                  onSuccess: () {
                    value = !value;
                    setState(() {});
                  },
                ),
                context,
              ),
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: widget.withBackGround
                ? const EdgeInsets.all(11)
                : EdgeInsets.zero,
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
            child: SvgPicture.asset(
              value ? AppSvg.fillFav : AppSvg.fav,
              width: widget.favIconWidth,
              height: widget.favIconHeight,
            ),
          ),
        );
      }),
    );
  }
}
