import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../data/entity/auction_types_entity.dart';
import '../../logic/auction_statuses_cubit.dart';

class AuctionStatusesFilter extends StatelessWidget {
  const AuctionStatusesFilter({super.key, this.initialValue, this.onSelect});
  final AuctionStatusesEntity? initialValue;
  final Function(AuctionStatusesEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuctionStatusesCubit()..auctionStatusesStatesHandled(),
      child: BlocBuilder<AuctionStatusesCubit, AuctionStatusesState>(
        buildWhen: (previous, current) =>
            current is AuctionStatusesLoading ||
            current is AuctionStatusesDone ||
            current is AuctionStatusesError,
        builder: (context, state) {
          final cubit = context.read<AuctionStatusesCubit>();
          return DefaultFormField(
            titleText: AppStrings.age.tr,
            hintText: '${AppStrings.selectAge.tr}...',
            needValidation: false,
            // validator: (v) => DefaultValidator.defaultValidator(
            //   initialValue?.name ?? '',
            //   label: AppStrings.age.tr,
            // ),
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textSecondaryParagraph,
            ),
            onTap: () {
              if (state is AuctionStatusesDone) {
              } else if (state is AuctionStatusesLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AuctionStatusesEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AuctionStatusesError) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.somethingWentWrong,
                    backgroundColor: AppColors.textError,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
