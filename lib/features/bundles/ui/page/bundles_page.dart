import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
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
    return BlocBuilder<BundlesCubit, BundlesState>(
      buildWhen: (previous, current) =>
          current is BundlesLoading ||
          current is BundlesSuccess ||
          current is BundlesError,
      builder: (context, state) {
        if (state is BundlesLoading) {
          return isListing
              ? SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomShimmerContainer(
                      height: 120.h,
                      width: MediaQueryHelper.width,
                    ),
                  ),
                  itemCount: cubit.allAuctions?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverGrid.builder(
                    itemBuilder: (context, index) {
                      return CustomShimmerContainer(
                        height: 120.h,
                        width: MediaQueryHelper.width,
                      );
                    },
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.9,
                    ),
                  ));
        }
        if (state is BundlesError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  cubit.bundlesStatesHandled();
                },
              ),
            ),
          );
        }
        if (cubit.allAuctions != null) {
          if (cubit.allAuctions!.isEmpty) {
            return const SizedBox();
          }
          return isListing
              ? SliverList.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: ListBundleCard(
                            bundle: cubit.allAuctions![index]));
                  },
                  itemCount: cubit.allAuctions?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverGrid.builder(
                    itemBuilder: (context, index) {
                      return GridBundleCard(
                          bundle: cubit.allAuctions![index]);
                    },
                    itemCount: cubit.allAuctions?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.9,
                    ),
                  ));
        }
        return SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: const Center(child: Text('no state provided')),
        ));
      },
    );
  }
}
