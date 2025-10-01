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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            AppStrings.auctionStatus.tr,
            style: AppTextStyles.textLgBold
                .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
          ),
          BlocBuilder<AuctionStatusesCubit, AuctionStatusesState>(
            builder: (context, state) {
              final cubit = context.read<AuctionStatusesCubit>();
              if (state is AuctionStatusesLoading) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    5,
                    (index) => const CustomShimmerContainer(
                      width: 80,
                      height: 35,
                    ),
                  ),
                );
              }
              if (state is AuctionStatusesDone) {
                {
                  return Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      cubit.allAuctionStatuses!.length,
                      (index) {
                        final isChosen = widget.initialValue?.value ==
                            cubit.allAuctionStatuses![index].value;
                        return AuctionStatusFilterCard(
                          auctionStatus: cubit.allAuctionStatuses![index],
                          isSelected: widget.initialValue?.value ==
                              cubit.allAuctionStatuses![index].value,
                          onTap: () {
                            if (widget.initialValue?.value ==
                                cubit.allAuctionStatuses![index].value) {
                              widget.onTap?.call(null);
                            } else {
                              widget.onTap
                                  ?.call(cubit.allAuctionStatuses![index]);
                            }
                          },
                          borderRadiusValue: 12,
                          textStyle: AppTextStyles.textMdRegular.copyWith(
                            color: isChosen
                                ? const Color.fromRGBO(81, 94, 50, 1)
                                : const Color.fromRGBO(162, 162, 162, 1),
                          ),
                          fillColor: isChosen
                              ? const Color.fromRGBO(81, 94, 50, 0.1)
                              : Colors.transparent,
                        );
                      },
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
