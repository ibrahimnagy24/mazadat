import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/enums/home_enums.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import 'auction_card_widget.dart';
import 'home_auction_error_widget.dart';
import 'home_auction_loading_widget.dart';

class HomeUpComingAuctionsWidget extends StatelessWidget {
  const HomeUpComingAuctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeUpComingAuctionLoading ||
          current is HomeUpComingAuctionSuccess ||
          current is HomeUpComingAuctionError,
      builder: (context, state) {
        if (state is HomeUpComingAuctionLoading) {
          return const HomeAuctionLoadingWidget();
        }
        if (state is HomeUpComingAuctionError) {
          return HomeAuctionErrorWidget(
            errorEntity: state.error,
            onTap: () {
              cubit.auctionStatesHandled(HomeAuctionType.inProgress);
            },
          );
        }
        if (cubit.upcomingAuction != null) {
          if (cubit.upcomingAuction!.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverList.separated(
            itemBuilder: (context, index) {
              return AuctionCardWidget(auction: cubit.upcomingAuction![index]);
            },
            itemCount: cubit.upcomingAuction!.length,
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

class HomeUpComingAuctionsTitleWidget extends StatelessWidget {
  const HomeUpComingAuctionsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeUpComingAuctionLoading ||
          current is HomeUpComingAuctionError ||
          current is HomeUpComingAuctionSuccess,
      builder: (context, state) {
        if (context.read<HomeCubit>().upcomingAuction != null &&
            context.read<HomeCubit>().upcomingAuction!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16, bottom: 12),
              child: MainText(
                text: AppStrings.upcomingAuctions.tr,
                style: AppTextStyles.bodyMMed
                    .copyWith(color: AppColors.kOpacityBlack),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
