import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../auctions/ui/widgets/grid_auction_card.dart';
import '../../../auctions/ui/widgets/list_auction_card.dart';
import '../../logic/my_sales_cubit.dart';
import '../../logic/my_sales_state.dart';

class MySalesBody extends StatelessWidget {
  const MySalesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MySalesCubit>();
    return Expanded(
        child: StreamBuilder(
            stream: context.read<MySalesCubit>().listingStream,
            builder: (c, snapshot) {
              return BlocBuilder<MySalesCubit, MySalesState>(
                builder: (context, state) {
                  if (state is MySalesLoading) {
                    return snapshot.data == true
                        ? ListAnimator(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            data: List.generate(
                              10,
                              (i) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: CustomShimmerContainer(
                                  height: 120.h,
                                  width: MediaQueryHelper.width,
                                ),
                              ),
                            ),
                          )
                        : GridListAnimator(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            data: List.generate(
                              20,
                              (i) => CustomShimmerContainer(
                                height: 120.h,
                                width: MediaQueryHelper.width,
                              ),
                            ),
                            crossAxisCount: 2,
                            aspectRatio: 0.9,
                          );
                  }
                  if (state is MySalesError ||
                      state is MySalesEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ErrorMessageWidget(
                        error: state is MySalesError
                            ? state.error
                            : const ErrorEntity(
                                message: 'no Data',
                                statusCode: 200,
                                errors: []),
                        onTap: () {
                          cubit.mySalesStatesHandled(SearchEngine());
                        },
                      ),
                    );
                  }
                  if (state is MySalesSuccess) {
                    return Column(
                      children: [
                        Expanded(
                            child: snapshot.data == true
                                ? ListAnimator(
                                    controller: cubit.controller,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    data: List.generate(
                                      state.auctions.length,
                                      (i) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: ListAuctionCard(
                                            fromMyPurchase: true,
                                            auction: state.auctions[i]),
                                      ),
                                    ),
                                  )
                                : GridListAnimator(
                                    controller: cubit.controller,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    data: List.generate(
                                        state.auctions.length,
                                        (i) => GridAuctionCard(
                                            fromMyPurchase: true,
                                            auction: state.auctions[i])),
                                    crossAxisCount: 2,
                                    aspectRatio: 0.9,
                                  )),
                        CustomLoadingText(loading: state.isLoading),
                      ],
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: const Text('no state provided'),
                  );
                },
              );
            }));
  }
}
