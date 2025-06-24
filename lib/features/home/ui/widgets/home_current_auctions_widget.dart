import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';

import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/enums/home_enums.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import 'auction_card_widget.dart';
import 'home_auction_error_widget.dart';
import 'home_auction_loading_widget.dart';

class HomeCurrentAuctionsWidget extends StatelessWidget {
  const HomeCurrentAuctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeInProgressAuctionLoading ||
          current is HomeInProgressAuctionSuccess ||
          current is HomeInProgressAuctionError,
      builder: (context, state) {
        if (state is HomeInProgressAuctionLoading) {
          return const HomeAuctionLoadingWidget();
        }
        if (state is HomeInProgressAuctionError) {
          return HomeAuctionErrorWidget(
            errorEntity: state.error,
            onTap: () {
              cubit.auctionStatesHandled(HomeAuctionType.inProgress);
            },
          );
        }
        if (cubit.inProgressAuction != null) {
          if (cubit.inProgressAuction!.isEmpty) {
            return const SizedBox();
          }
          return SliverList.separated(
            itemBuilder: (context, index) {
              return AuctionCardWidget(
                  auction: cubit.inProgressAuction![index]);
            },
            itemCount: cubit.inProgressAuction!.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        }
        return const SliverToBoxAdapter(child: Text('no state provided'));
      },
    );
  }
}

class HomeCurrentAuctionsTitleWidget extends StatelessWidget {
  const HomeCurrentAuctionsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeInProgressAuctionLoading ||
          current is HomeInProgressAuctionError ||
          current is HomeInProgressAuctionSuccess,
      builder: (context, state) {
        if (context.read<HomeCubit>().inProgressAuction != null &&
            context.read<HomeCubit>().inProgressAuction!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16, bottom: 12),
              child: MainText(
                text: 'AppStrings.currentAuctions.tr',
                style: AppTextStyles.bodyMMed
                    .copyWith(color: AppColors.kOpacityBlack),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
