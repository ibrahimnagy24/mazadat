import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../address/addresses/data/model/addresses_model.dart';
import '../../cubit/checkout_address_cubit.dart';

class AddCheckoutAddressButtonWidget extends StatelessWidget {
  const AddCheckoutAddressButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.push(Routes.ADD_ADDRESSES, extra: AddressModel(
          onSuccess: () {
            context.read<CheckoutAddressCubit>().fetchAddresses();
          },
        ));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.kPrimary),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color(0xffEAE7E7), shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                size: 24,
                color: AppColors.HEADER,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.addAddress.tr,
              style: AppTextStyles.textXLBold,
            ),
          ],
        ),
      ),
    );
  }
}
