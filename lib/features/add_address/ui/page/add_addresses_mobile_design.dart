import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../addresses/data/model/addresses_model.dart';
import '../../../addresses/logic/addresses_state.dart';
import '../../../delete_address/ui/delete_address_button.dart';
import '../../logic/add_address_cubit.dart';
import '../../logic/add_address_state.dart';
import '../widgets/add_address_body.dart';

class AddAddressesMobileDesign extends StatelessWidget {
  const AddAddressesMobileDesign({super.key, this.model});
  final AddressModel? model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(
          title: model != null
              ? AppStrings.editAddress.tr
              : AppStrings.addAddress.tr),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: BlocConsumer<AddAddressCubit, AddAddressState>(
            listener: (c, state) {
              if (state is AddAddressSuccess) {
                CustomNavigator.push(Routes.ADDRESSES, replace: true);
              }
            },
            builder: (c, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AddAddressBody(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                  child: Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: DefaultButton(
                          text: AppStrings.saveChanges.tr,
                          isLoading: state is AddressesLoading,
                          onPressed: () {
                            if (context.read<AddAddressCubit>().isBodyValid()) {
                              context
                                  .read<AddAddressCubit>()
                                  .addAddressStatesHandled();
                            }
                          },
                        ),
                      ),
                      if (model != null)
                        Expanded(child: DeleteAddressButton(id: model?.id ?? 0))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
