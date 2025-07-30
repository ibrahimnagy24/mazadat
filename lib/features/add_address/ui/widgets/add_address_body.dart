import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/validations/validator.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../core/utils/widgets/misc/should_rebuild.dart';
import '../../../selectors/address_types/ui/page/address_type_input.dart';
import '../../../selectors/city/ui/page/city_input.dart';
import '../../../selectors/districts/ui/page/district_input.dart';
import '../../../selectors/regions/ui/page/region_input.dart';
import '../../logic/add_address_cubit.dart';

class AddAddressBody extends StatelessWidget {
  const AddAddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: context.read<AddAddressCubit>().formKey,
        child: StreamBuilder(
            stream: context.read<AddAddressCubit>().entityStream,
            builder: (context, snapshot) {
              return ListAnimator(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                data: [
                  AddressTypeInput(
                    initialValue: snapshot.data?.addressType,
                    validator: (v) => DefaultValidator.defaultValidator(v,
                        label: AppStrings.addressType.tr),
                    onSelect: (v) => context
                        .read<AddAddressCubit>()
                        .updateEntity(snapshot.data?.copyWith(addressType: v)),
                  ),
                  16.sbH,
                  DefaultFormField(
                    controller: snapshot.data?.addressTEC,
                    titleText: AppStrings.address.tr,
                    hintText: '${AppStrings.enterAddress.tr}...',
                    validator: (v) => DefaultValidator.defaultValidator(v,
                        label: AppStrings.address.tr),
                  ),
                  16.sbH,
                  DefaultPhoneFormField(
                    controller: snapshot.data?.phoneTEC,
                  ),
                  16.sbH,
                  RegionInput(
                    initialValue: snapshot.data?.region,
                    validator: (v) => DefaultValidator.defaultValidator(v,
                        label: AppStrings.region.tr),
                    onSelect: (v) => context
                        .read<AddAddressCubit>()
                        .updateEntity(snapshot.data?.copyWith(
                            region: v, clearCity: true, clearDistrict: true)),
                  ),
                  16.sbH,
                  ShouldRebuild(
                    shouldRebuild: (o, n) => o.key != n.key,
                    child: CityInput(
                      key: ValueKey(
                          '${snapshot.data?.region?.id}_${snapshot.data?.city?.id}'),
                      withRegionFilter: true,
                      regionId: snapshot.data?.region?.id,
                      initialValue: snapshot.data?.city,
                      validator: (v) => DefaultValidator.defaultValidator(v,
                          label: AppStrings.city.tr),
                      onSelect: (v) => context
                          .read<AddAddressCubit>()
                          .updateEntity(snapshot.data
                              ?.copyWith(city: v, clearDistrict: true)),
                    ),
                  ),
                  16.sbH,
                  ShouldRebuild(
                    shouldRebuild: (o, n) => o.key != n.key,
                    child: DistrictInput(
                      key: ValueKey(
                          '${snapshot.data?.city?.id}_${snapshot.data?.district?.id}'),
                      cityId: snapshot.data?.city?.id,
                      initialValue: snapshot.data?.district,
                      validator: (v) => DefaultValidator.defaultValidator(v,
                          label: AppStrings.district.tr),
                      onSelect: (v) => context
                          .read<AddAddressCubit>()
                          .updateEntity(snapshot.data?.copyWith(district: v)),
                    ),
                  ),
                  16.sbH,

                  ///Set Default
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4.w,
                    children: [
                      Checkbox(
                        value: snapshot.data?.isDefault == true,
                        onChanged: (v) => context
                            .read<AddAddressCubit>()
                            .updateEntity(snapshot.data?.copyWith(
                                isDefault:
                                    !(snapshot.data?.isDefault == true))),
                        activeColor: AppColors.kPrimary,
                        side: const BorderSide(color: AppColors.kPrimary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Expanded(
                        child: Text(AppStrings.setAsADefaultAddress.tr,
                            style: AppTextStyles.textLgMedium),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
