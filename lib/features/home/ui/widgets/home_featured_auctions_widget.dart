import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/enums/home_enums.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import 'auction_card_widget.dart';
import 'home_auction_error_widget.dart';
import 'home_auction_loading_widget.dart';

class HomeFeaturedWidget extends StatelessWidget {
  const HomeFeaturedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    cprint(cubit.featuredAuction?.length.toString());
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeFeaturedAuctionLoading ||
          current is HomeFeaturedAuctionSuccess ||
          current is HomeFeaturedAuctionError,
      builder: (context, state) {
        if (state is HomeFeaturedAuctionLoading) {
          return const HomeAuctionLoadingWidget();
        }
        if (state is HomeFeaturedAuctionError) {
          return HomeAuctionErrorWidget(
            errorEntity: state.error,
            onTap: () {
              cubit.auctionStatesHandled(HomeAuctionType.featured);
            },
          );
        }
        if (cubit.featuredAuction != null) {
          if (cubit.featuredAuction!.isEmpty) {
            return const SizedBox();
          }
          return SliverList.separated(
            itemBuilder: (context, index) {
              return AuctionCardWidget(auction: cubit.featuredAuction![index]);
            },
            itemCount: cubit.featuredAuction!.length,
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

class HomeFeaturedTitleWidget extends StatelessWidget {
  const HomeFeaturedTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeFeaturedAuctionLoading ||
          current is HomeFeaturedAuctionError ||
          current is HomeFeaturedAuctionSuccess,
      builder: (context, state) {
        if (context.read<HomeCubit>().featuredAuction != null &&
            context.read<HomeCubit>().featuredAuction!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16, bottom: 12),
              child: MainText(
                text: AppStrings.featuredAuctions.tr,
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
