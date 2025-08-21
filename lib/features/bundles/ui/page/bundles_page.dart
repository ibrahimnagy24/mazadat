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
import '../../logic/bundles_cubit.dart';
import '../../logic/bundles_state.dart';

import '../widgets/grid_bundle_card.dart';
import '../widgets/list_bundle_card.dart';

class BundlesPage extends StatelessWidget {
  const BundlesPage({super.key, this.isListing = true});
  final bool isListing;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BundlesCubit>();
    return Expanded(child: BlocBuilder<BundlesCubit, BundlesState>(
      builder: (context, state) {
        if (state is BundlesLoading) {
          return isListing
              ? ListAnimator(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  data: List.generate(
                    10,
                    (i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: CustomShimmerContainer(
                        height: 120,
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
        if (state is BundlesError || state is BundlesEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ErrorMessageWidget(
              error: state is BundlesError
                  ? state.error
                  : const ErrorEntity(
                      message: 'no Data', statusCode: 200, errors: []),
              onTap: () {
                cubit.bundlesStatesHandled(SearchEngine());
              },
            ),
          );
        }
        if (state is BundlesSuccess) {
          return Column(
            children: [
              Expanded(
                child: isListing
                    ? ListAnimator(
                        controller: cubit.controller,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        data: List.generate(
                          state.bundles.length,
                          (i) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListBundleCard(bundle: state.bundles[i]),
                          ),
                        ),
                      )
                    : GridListAnimator(
                        controller: cubit.controller,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        data: List.generate(state.bundles.length,
                            (i) => GridBundleCard(bundle: state.bundles[i])),
                        crossAxisCount: 2,
                        aspectRatio: 0.9,
                      ),
              ),
              CustomLoadingText(loading: state.isLoading),
            ],
          );
        }
        return const SliverToBoxAdapter(child: Text('no state provided'));
      },
    ));
  }
}
