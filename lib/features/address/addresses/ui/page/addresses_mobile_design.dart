import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_text.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../logic/addresses_cubit.dart';
import '../../logic/addresses_state.dart';
import '../widgets/add_address_button.dart';
import '../widgets/address_card.dart';
import '../widgets/addresses_header_widget.dart';

class AddressesMobileDesign extends StatelessWidget {
  const AddressesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressesCubit>();
    return CustomScaffoldWidget(
      needAppbar: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16, width: double.infinity),
            const AddressesHeaderWidget(),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                  stream: context.read<AddressesCubit>().listingStream,
                  builder: (c, snapshot) {
                    return BlocBuilder<AddressesCubit, AddressesState>(
                      builder: (context, state) {
                        if (state is AddressesLoading) {
                          return const SizedBox.shrink();
                        }
                        if (state is AddressesError ||
                            state is AddressesEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ErrorMessageWidget(
                                error: state is AddressesError
                                    ? state.error
                                    : ErrorEntity(
                                        message:
                                            AppStrings.thereIsNoAddresses.tr,
                                        statusCode: 200,
                                        errors: const []),
                                onTap: () {
                                  cubit.addressesStatesHandled(SearchEngine());
                                },
                              ),
                              if (state is AddressesEmpty)
                                const AddAddressButton(),
                            ],
                          );
                        }
                        if (state is AddressesSuccess) {
                          return Column(
                            children: [
                              Expanded(
                                child: ListAnimator(
                                  data: List.generate(
                                    state.addresses.length,
                                    (i) => AddressCard(
                                        address: state.addresses[i]),
                                  )..add(const SafeArea(
                                      top: false,
                                      left: false,
                                      right: false,
                                      child: AddAddressButton(),
                                    )),
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
