import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../logic/addresses_cubit.dart';
import '../../logic/addresses_state.dart';
import '../widgets/add_address_button.dart';
import '../widgets/address_card.dart';

class AddressesMobileDesign extends StatelessWidget {
  const AddressesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressesCubit>();
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(title: AppStrings.myAddresses.tr),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: context.read<AddressesCubit>().listingStream,
                    builder: (c, snapshot) {
                      return BlocBuilder<AddressesCubit, AddressesState>(
                        builder: (context, state) {
                          if (state is AddressesLoading) {
                            return ListAnimator(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              data: List.generate(
                                10,
                                (i) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: CustomShimmerContainer(
                                    height: 80.h,
                                    width: MediaQueryHelper.width,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is AddressesError ||
                              state is AddressesEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ErrorMessageWidget(
                                    error: state is AddressesError
                                        ? state.error
                                        : const ErrorEntity(
                                            message:
                                                AppStrings.thereIsNoAddresses,
                                            statusCode: 200,
                                            errors: []),
                                    onTap: () {
                                      cubit.addressesStatesHandled(
                                          SearchEngine());
                                    },
                                  ),
                                  if (state is AddressesEmpty)
                                    const AddAddressButton(),

                                ],
                              ),
                            );
                          }
                          if (state is AddressesSuccess) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListAnimator(
                                    controller: cubit.controller,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    data: List.generate(
                                      state.addresses.length,
                                      (i) => AddressCard(
                                          address: state.addresses[i]),
                                    )..add(const AddAddressButton()),
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
                    })),
          ],
        ),
      ),
    );
  }
}
