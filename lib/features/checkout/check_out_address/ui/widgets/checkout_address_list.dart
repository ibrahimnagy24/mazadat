import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../address/addresses/data/model/addresses_model.dart';
import '../../cubit/checkout_address_cubit.dart';
import '../../cubit/checkout_address_state.dart';

class CheckoutAddressList extends StatelessWidget {
  const CheckoutAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutAddressCubit, CheckoutAddressState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutAddressCubit>();
        if (state is CheckoutAddressLoading) {
          return const SizedBox.shrink();
        }

        if (state is CheckoutAddressError) {
          return ErrorMessageWidget(
            error: state.error,
            message: state.error.message,
            onTap: () {
              context.read<CheckoutAddressCubit>().fetchAddresses();
            },
          );
        }

        if (state is CheckoutAddressEmpty) {
          return ErrorMessageWidget(
            error: ErrorEntity(
              message: AppStrings.thereIsNoAddresses.tr,
              statusCode: 200,
              errors: const [],
            ),
            onTap: () {
              context.read<CheckoutAddressCubit>().fetchAddresses();
            },
          );
        }

        if (cubit.addresses != null && cubit.addresses!.isNotEmpty) {
          final addresses = state is CheckoutAddressLoaded
              ? state.addresses
              : (state as CheckoutAddressSelected).addresses;
          final selectedAddress =
              state is CheckoutAddressSelected ? state.selectedAddress : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: AppStrings.deliveryAddress.tr,
                style: AppTextStyles.textLgBold
                    .copyWith(color: AppColors.kPrimary),
              ),
              const SizedBox(height: 16),
              Column(
                spacing: 12,
                children: addresses.map((address) {
                  final isSelected = selectedAddress?.id == address.id;
                  return _CheckoutAddressCard(
                    address: address,
                    isSelected: isSelected,
                  );
                }).toList(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _CheckoutAddressCard extends StatelessWidget {
  const _CheckoutAddressCard({
    required this.address,
    required this.isSelected,
  });

  final AddressModel address;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CheckoutAddressCubit>().selectAddress(address);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kWhite : AppColors.background,
          border: Border.all(
            color: isSelected
                ? AppColors.kPrimary
                : AppColors.borderNeutralSecondary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.location,
              width: 24,
              height: 24,
              color: isSelected ? AppColors.kPrimary : AppColors.iconDefault,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    address.addressType?.name ?? '',
                    style: isSelected
                        ? AppTextStyles.textLgBold.copyWith(
                            color: const Color.fromRGBO(81, 94, 50, 1))
                        : AppTextStyles.textLgRegular.copyWith(
                            color: const Color.fromRGBO(116, 116, 116, 1)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address.desc ?? '',
                    style: AppTextStyles.textMdRegular.copyWith(
                        color: const Color.fromRGBO(162, 162, 162, 1)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Radio<int>(
              value: address.id ?? 0,
              groupValue: isSelected ? address.id : null,
              onChanged: (value) {
                if (value != null) {
                  context.read<CheckoutAddressCubit>().selectAddress(address);
                }
              },
              activeColor: const Color.fromRGBO(81, 94, 50, 1),
            ),
          ],
        ),
      ),
    );
  }
}
