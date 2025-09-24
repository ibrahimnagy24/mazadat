import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../data/model/addresses_model.dart';
import '../../logic/addresses_cubit.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key, required this.address, this.fromAddress = true});
  final AddressModel address;
  final bool fromAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color:
            address.isDefault == true ? AppColors.kWhite : AppColors.background,
        border: Border.all(
          color: address.isDefault == true
              ? AppColors.kPrimary
              : AppColors.borderNeutralSecondary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(
            AppSvg.location,
            width: 24,
            height: 24,
            color: address.isDefault == true
                ? AppColors.kPrimary
                : AppColors.iconDefault,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                Text(
                  address.addressType?.name ?? '',
                  style: address.isDefault == true
                      ? AppTextStyles.textLgBold
                          .copyWith(color: const Color.fromRGBO(81, 94, 50, 1))
                      : AppTextStyles.textLgRegular.copyWith(
                          color: const Color.fromRGBO(116, 116, 116, 1)),
                ),
                Text(
                  address.desc ?? '',
                  style: AppTextStyles.textMdRegular
                      .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
                ),
              ],
            ),
          ),
          if (fromAddress)
            GestureDetector(
              onTap: () {
                address.onSuccess = () {
                  context
                      .read<AddressesCubit>()
                      .addressesStatesHandled(SearchEngine());
                };
                CustomNavigator.push(Routes.ADD_ADDRESSES, extra: address);
              },
              child: SvgPicture.asset(
                AppSvg.edit,
                width: 20,
                height: 20,
                color: address.isDefault == true
                    ? AppColors.kPrimary
                    : const Color.fromRGBO(81, 94, 50, 1),
              ),
            ),
        ],
      ),
    );
  }
}
