import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/validations/validator.dart';
import '../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/misc/should_rebuild.dart';
import '../../../city/ui/page/city_input.dart';
import '../../../districts/ui/page/district_input.dart';
import '../../../regions/ui/page/region_input.dart';
import '../../logic/add_address_cubit.dart';
import '../../../address_types/ui/widgets/address_type_choice_chips_widget.dart';

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
              return ListView(
                controller: context.read<AddAddressCubit>().controller,
                children: [
                  AddressTypeChoiceChipsWidget(
                    initialValue: snapshot.data?.addressType,
                    validator: (v) =>
                        v == null ? '${AppStrings.addressType.tr} مطلوب' : null,
                    onSelect: (v) => context
                        .read<AddAddressCubit>()
                        .updateEntity(snapshot.data
                            ?.copyWith(selectedAddressTypeEntity: v)),
                  ),
                  const SizedBox(height: 16),
                  DefaultFormField(
                    controller: snapshot.data?.addressTEC,
                    titleText: AppStrings.address.tr,
                    hintText: '${AppStrings.enterAddress.tr}...',
                    validator: (v) => DefaultValidator.defaultValidator(
                      v,
                      label: AppStrings.address.tr,
                    ),
                    fillColor: AppColors.kWhite,
                    borderColor: const Color.fromRGBO(232, 232, 232, 1),
                  ),
                  const SizedBox(height: 16),
                  DefaultPhoneFormField(
                    controller: snapshot.data?.phoneTEC,
                  ),
                  const SizedBox(height: 16),
                  RegionInput(
                    initialValue: snapshot.data?.region,
                    validator: (v) => DefaultValidator.defaultValidator(
                      v,
                      label: AppStrings.region.tr,
                    ),
                    onSelect: (v) {
                      context.read<AddAddressCubit>().updateEntity(
                            snapshot.data?.copyWith(
                              region: v,
                              clearCity: true,
                              clearDistrict: true,
                            ),
                          );
                    },
                    fillColor: AppColors.kWhite,
                    borderColor: const Color.fromRGBO(232, 232, 232, 1),
                  ),
                  const SizedBox(height: 16),
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
                      fillColor: AppColors.kWhite,
                      borderColor: const Color.fromRGBO(232, 232, 232, 1),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      fillColor: AppColors.kWhite,
                      borderColor: const Color.fromRGBO(232, 232, 232, 1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
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
                        child: Text(
                          AppStrings.setAsADefaultAddress.tr,
                          style: AppTextStyles.textLgMedium,
                        ),
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
