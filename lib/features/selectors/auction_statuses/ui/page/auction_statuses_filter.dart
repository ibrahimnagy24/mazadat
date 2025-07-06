import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/entity/auction_status_entity.dart';
import '../../logic/auction_statuses_cubit.dart';
import '../widgets/auction_status_filter_card.dart';

class AuctionStatusFilterSection extends StatefulWidget {
  const AuctionStatusFilterSection({super.key, this.onTap, this.initialValue});
  final Function(AuctionStatusEntity?)? onTap;
  final AuctionStatusEntity? initialValue;

  @override
  State<AuctionStatusFilterSection> createState() =>
      _AuctionStatusFilterSectionState();
}

class _AuctionStatusFilterSectionState
    extends State<AuctionStatusFilterSection> {
  AuctionStatusEntity? initialValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.auctionStatus.tr,
            style: AppTextStyles.textLgBold,
          ),
          BlocBuilder<AuctionStatusesCubit, AuctionStatusesState>(
            builder: (context, state) {
              final cubit = context.read<AuctionStatusesCubit>();
              if (state is AuctionStatusesLoading) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.h,
                  runSpacing: 8.w,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    5,
                    (index) => CustomShimmerContainer(
                      width: 80.w,
                      height: 35.h,
                    ),
                  ),
                );
              }
              if (state is AuctionStatusesDone) {
                {
                  return Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.h,
                    runSpacing: 8.w,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      cubit.allAuctionStatuses!.length,
                      (index) => AuctionStatusFilterCard(
                        auctionStatus: cubit.allAuctionStatuses![index],
                        isSelected: widget.initialValue?.value ==
                            cubit.allAuctionStatuses![index].value,
                        onTap: () {
                          if (widget.initialValue?.value == cubit.allAuctionStatuses![index].value) {
                            widget.onTap?.call(null);
                          } else {
                            widget.onTap
                                ?.call(cubit.allAuctionStatuses![index]);
                          }
                        },
                        animationDuration: (index * 10).ms,
                        borderRadiusValue: AppRadius.rM,
                      ),
                    ),
                  );
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
