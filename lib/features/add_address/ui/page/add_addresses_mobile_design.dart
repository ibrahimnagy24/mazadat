import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../addresses/logic/addresses_state.dart';
import '../../logic/add_address_cubit.dart';
import '../../logic/add_address_state.dart';
import '../widgets/add_address_body.dart';

class AddAddressesMobileDesign extends StatelessWidget {
  const AddAddressesMobileDesign({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(
          title: isEdit ? AppStrings.editAddress.tr : AppStrings.addAddress.tr),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: BlocBuilder<AddAddressCubit, AddAddressState>(
            builder: (c, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AddAddressBody(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                  child: Builder(builder: (context) {
                    return DefaultButton(
                      text: AppStrings.saveChanges.tr,
                      isLoading: state is AddressesLoading,
                      onPressed: () {
                        if (context.read<AddAddressCubit>().isBodyValid()) {
                          context
                              .read<AddAddressCubit>()
                              .addAddressStatesHandled();
                        }
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
