import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auctions/ui/widgets/grid_auction_card.dart';
import '../../logic/favourites_cubit.dart';
import '../../logic/favourites_state.dart';

class ChooseCategoryMobilePortraitDesignScreen extends StatelessWidget {
  const ChooseCategoryMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FavouritesCubit, FavouritesState>(
                buildWhen: (previous, current) =>
                    current is FavouritesLoading ||
                    current is FavouritesSuccess ||
                    current is FavouritesError,
                builder: (context, state) {
                  final cubit = context.read<FavouritesCubit>();
                  if (state is FavouritesLoading) {
                    return SliverGrid.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CustomShimmerContainer(
                          height: 120.h,
                          width: MediaQueryHelper.width,
                        ),
                      ),
                      itemCount: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.w,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1,
                      ),
                    );
                  }
                  if (state is FavouritesError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: ErrorMessageWidget(
                          error: state.error,
                          onTap: () {
                            cubit.favouritesAuctionStatesHandled();
                          },
                        ),
                      ),
                    );
                  }
                  if (cubit.allAuctions != null) {
                    if (cubit.allAuctions!.isEmpty) {
                      return const SizedBox();
                    }
                    return SliverGrid.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: GridAuctionCard(
                              auction: cubit.allAuctions![index]),
                        );
                      },
                      itemCount: cubit.allAuctions?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.w,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1,
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: const Center(child: Text('no state provided')),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
