import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../logic/addresses_cubit.dart';
import '../../logic/addresses_state.dart';
import 'address_card.dart';

class AddressesBody extends StatelessWidget {
  const AddressesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressesCubit>();
    return Expanded(
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
                            height: 120.h,
                            width: MediaQueryHelper.width,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is AddressesError || state is AddressesEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ErrorMessageWidget(
                        error: state is AddressesError
                            ? state.error
                            : const ErrorEntity(
                                message: 'no Data',
                                statusCode: 200,
                                errors: []),
                        onTap: () {
                          cubit.addressesStatesHandled(SearchEngine());
                        },
                      ),
                    );
                  }
                  if (state is AddressesSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                            controller: cubit.controller,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            data: List.generate(
                              state.addresses.length,
                              (i) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: AddressCard(address: state.addresses[i]),
                              ),
                            ),
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
