import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../../utils/view_auction_details_controller.dart';
import '../bottom_sheets/view_auction_exceed_max_bidding_alert.dart';
import '../widgets/view_auction_details_draggable_sheet.dart';
import '../widgets/auction_hero_image.dart';

class ViewAuctionDetailsMobileDesignScreen extends StatefulWidget {
  const ViewAuctionDetailsMobileDesignScreen({super.key});

  @override
  State<ViewAuctionDetailsMobileDesignScreen> createState() =>
      _AuctionDetailsMobileDesignScreenState();
}

class _AuctionDetailsMobileDesignScreenState
    extends State<ViewAuctionDetailsMobileDesignScreen>
    with SingleTickerProviderStateMixin {
  late ViewAuctionDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ViewAuctionDetailsController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
        listener: (context, state) {
          final cubit = context.read<ViewAuctionDetailsCubit>();
          if (state is ViewAuctionDetailsSuccess) {
            if (cubit.isUserExceedMaxBiddingAmount(context)) {
              showModalBottomSheet(
                context: context,
                builder: (modalBuildContext) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: ViewAuctionExceedMaxBiddingAlert(
                      modalBuildContext: modalBuildContext,
                      cubit: cubit,
                    ),
                  );
                },
              );
            }
          }
        },
        buildWhen: (previous, current) =>
            current is ViewAuctionDetailsSuccess ||
            current is ViewAuctionDetailsError ||
            current is ViewAuctionDetailsLoading,
        builder: (context, state) {
          final cubit = context.read<ViewAuctionDetailsCubit>();
          if (state is ViewAuctionDetailsLoading &&
              cubit.auctionDetails == null) {
            return const CustomScaffoldWidget(
              appbar: CustomAppBar(),
              needAppbar: true,
              child: CustomLoading(),
            );
          }
          if (state is ViewAuctionDetailsError &&
              cubit.auctionDetails == null) {
            return CustomScaffoldWidget(
              appbar: const CustomAppBar(),
              needAppbar: true,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ErrorMessageWidget(
                    error: state.error,
                    onTap: () {
                      cubit.viewAuctionDetailsStatesHandled();
                    },
                  ),
                ),
              ),
            );
          }
          if (state is ViewAuctionDetailsSuccess ||
              cubit.auctionDetails != null) {
            return CustomScaffoldWidget(
              needAppbar: false,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ViewAuctionHeroImage(controller: _controller),
                  ViewAuctionDetailsDraggableSheet(controller: _controller),
                  PositionedDirectional(
                    top: 0,
                    child: SafeArea(
                      child: Container(
                        width: MediaQueryHelper.width,
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          spacing: 8.w,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomBackIcon(iconColor: AppColors.kWhite),
                            if (cubit.auctionDetails?.statusLabel != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: AppColors.backgroundSecondary,
                                ),
                                child: Text(
                                  cubit.auctionDetails?.statusLabel ?? '',
                                  style: AppTextStyles.textMdRegular
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return CustomScaffoldWidget(
            appbar: const CustomAppBar(),
            needAppbar: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: const Text('no state provided'),
            ),
          );
        });
  }
}
