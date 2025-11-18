import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/enum/auction_status_type.dart';
import '../../logic/my_auctions_cubit.dart';
import '../../logic/my_auctions_state.dart';

class MyAuctionsStatusTabs extends StatelessWidget {
  const MyAuctionsStatusTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAuctionsCubit, MyAuctionsState>(
      buildWhen: (previous, current) => current is MyAuctionsStatusTypeChanged,
      builder: (context, state) {
        final cubit = context.read<MyAuctionsCubit>();
        final currentType = cubit.getAuctionStatusType;

        final Map<AuctionStatusType, Widget> segmentOptions = {
          AuctionStatusType.ongoing: SizedBox(
            height: 36,
            child: Center(
              child: MainText(
                text: AuctionStatusType.ongoing.arabicName,
                style: currentType == AuctionStatusType.ongoing
                    ? AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite)
                    : AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          AuctionStatusType.finished: SizedBox(
            height: 36,
            child: Center(
              child: MainText(
                text: AuctionStatusType.finished.arabicName,
                style: currentType == AuctionStatusType.finished
                    ? AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite)
                    : AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          AuctionStatusType.cancelled: SizedBox(
            height: 36,
            child: Center(
              child: MainText(
                text: AuctionStatusType.cancelled.arabicName,
                style: currentType == AuctionStatusType.cancelled
                    ? AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite)
                    : AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        };

        return SizedBox(
          height: 40,
          width: MediaQuery.sizeOf(context).width,
          child: CupertinoSlidingSegmentedControl<AuctionStatusType>(
            children: segmentOptions,
            groupValue: currentType,
            onValueChanged: (AuctionStatusType? value) {
              if (value != null) {
                cubit.setAuctionStatusType(value);
                cubit.myAuctionsStatesHandled();
              }
            },
            thumbColor: const Color.fromRGBO(138, 147, 118, 1),
            backgroundColor: AppColors.kWhite,
            padding: const EdgeInsets.all(0),
          ),
        );
      },
    );
  }
}
