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
import '../../../bundles/ui/widgets/grid_bundle_card.dart';
import '../../../bundles/ui/widgets/list_bundle_card.dart';
import '../../logic/my_bundles_cubit.dart';
import '../../logic/my_bundles_state.dart';

class MyBundlesBody extends StatelessWidget {
  const MyBundlesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyBundlesCubit>();
    return Expanded(
        child: StreamBuilder(
            stream: context.read<MyBundlesCubit>().listingStream,
            builder: (c, snapshot) {
              return BlocBuilder<MyBundlesCubit, MyBundlesState>(
                builder: (context, state) {
                  if (state is MyBundlesLoading) {
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
                  if (state is MyBundlesError || state is MyBundlesEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ErrorMessageWidget(
                        error: state is MyBundlesError
                            ? state.error
                            : const ErrorEntity(
                                message: 'no Data',
                                statusCode: 200,
                                errors: []),
                        onTap: () {
                          cubit.myBundlesStatesHandled(SearchEngine());
                        },
                      ),
                    );
                  }
                  if (state is MyBundlesSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: snapshot.data == true
                              ? ListAnimator(
                                  controller: cubit.controller,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  data: List.generate(
                                    state.bundles.length,
                                    (i) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: ListBundleCard(
                                          bundle: state.bundles[i]),
                                    ),
                                  ),
                                )
                              : GridListAnimator(
                                  controller: cubit.controller,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  data: List.generate(
                                      state.bundles.length,
                                      (i) => GridBundleCard(
                                          bundle: state.bundles[i])),
                                  crossAxisCount: 2,
                                  aspectRatio: 0.9,
                                ),
                        ),
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
