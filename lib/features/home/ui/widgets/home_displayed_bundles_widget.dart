import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/bundle_cards/bundle_card_widget.dart';
import '../../../../core/shared/widgets/bundle_cards/horizontal_bundle_card_widget.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/logo_loading.dart';
import '../../../bundle_details/data/params/bundle_details_route_params.dart';
import '../../data/enum/displayed_types.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeDisplayedBundlesWidget extends StatelessWidget {
  const HomeDisplayedBundlesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeDisplayedTypeChanged ||
          current is HomeBundlesLoading ||
          current is HomeBundlesSuccess ||
          current is HomeBundlesError,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        if (state is HomeBundlesLoading) {
          return const LogoLoadingWidget();
        }
        if (state is HomeBundlesError) {
          return Center(
            child: ErrorMessageWidget(
              error: state.error,
              onTap: () {
                cubit.getSuitableData();
              },
              message: state.error.message,
            ),
          );
        }
        if (cubit.homeBundles != null && cubit.homeBundles!.isNotEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              );
            },
            child: cubit.displayedType == HomeDisplayedTypes.grid
                ? GridView.builder(
                    key: const ValueKey('grid_view'),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 213,
                    ),
                    itemBuilder: (context, index) {
                      return BundleCardWidget(
                        bundleId: cubit.homeBundles![index].id,
                        bundleName: cubit.homeBundles![index].name,
                        bundlePrice: cubit.homeBundles![index].price,
                        numberOfAuctions:
                            cubit.homeBundles![index].numberOfAuctions,
                        onTap: () {
                          CustomNavigator.push(
                            Routes.BUNDLE_DETAILS,
                            extra: BundleDetailsRouteParams(
                              bundleId: cubit.homeBundles![index].id,
                              fromMyBundles: false,
                            ),
                          );
                        },
                      );
                    },
                    itemCount: cubit.homeAuctions!.length,
                  )
                : ListView.builder(
                    key: const ValueKey('list_view'),
                    itemCount: cubit.homeBundles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: HorizontalBundleCardWidget(
                          bundleId: cubit.homeBundles![index].id,
                          bundleName: cubit.homeBundles![index].name,
                          bundlePrice: cubit.homeBundles![index].price,
                          numberOfAuctions:
                              cubit.homeBundles![index].numberOfAuctions,
                          onTap: () {
                            CustomNavigator.push(
                              Routes.BUNDLE_DETAILS,
                              extra: BundleDetailsRouteParams(
                                bundleId: cubit.homeBundles![index].id,
                                fromMyBundles: false,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        }
        if (cubit.homeBundles == null || cubit.homeBundles!.isEmpty) {
          return ResponsiveEmptyWidget(
            onTap: () {
              cubit.getSuitableData();
            },
            title: 'No Bundles',
            subtitle: 'No bundles found',
          );
        }
        return SizedBox.fromSize();
      },
    );
  }
}
