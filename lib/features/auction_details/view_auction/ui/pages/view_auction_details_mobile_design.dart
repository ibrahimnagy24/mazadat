import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
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
            // appbar: CustomAppBar(),
            needAppbar: true,
            child: CustomLoading(),
          );
        }
        if (state is ViewAuctionDetailsError && cubit.auctionDetails == null) {
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
            backgroundColor: AppColors.background,
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
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomBackIcon(iconColor: AppColors.kWhite),
                          if (cubit.auctionDetails?.statusLabel != null)
                            Builder(
                              builder: (context) {
                                final config = _getStatusBadgeConfig(
                                  status: cubit.auctionDetails?.status ?? '',
                                  isWinner:
                                      cubit.auctionDetails?.winner ?? false,
                                  statusLabel:
                                      cubit.auctionDetails?.statusLabel ?? '',
                                );
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: config['backgroundColor'],
                                  ),
                                  child: Text(
                                    config['text'],
                                    style: AppTextStyles.textMdRegular
                                        .copyWith(color: config['textColor']),
                                  ),
                                );
                              },
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
      },
    );
  }

  /// Returns status badge configuration based on auction status and winner state
  Map<String, dynamic> _getStatusBadgeConfig({
    required String status,
    required bool isWinner,
    required String statusLabel,
  }) {
    switch (status) {
      case 'NEW':
        return {
          'text': statusLabel,
          'backgroundColor': const Color.fromRGBO(114, 94, 95, 1),
          'textColor': const Color.fromRGBO(255, 255, 255, 1),
        };
      case 'IN_PROGRESS':
        return {
          'text': statusLabel,
          'backgroundColor': const Color.fromRGBO(243, 220, 154, 1),
          'textColor': const Color.fromRGBO(34, 39, 21, 1),
        };
      case 'CANCELED':
        return {
          'text': AppStrings.canceled.tr,
          'backgroundColor': const Color.fromRGBO(224, 44, 31, 1),
          'textColor': const Color.fromRGBO(255, 255, 255, 1),
        };
      case 'COMPLETED':
        if (isWinner) {
          return {
            'text': AppStrings.iWonIt.tr,
            'backgroundColor': const Color.fromRGBO(69, 173, 34, 1),
            'textColor': const Color.fromRGBO(255, 255, 255, 1),
          };
        } else {
          return {
            'text': AppStrings.iLostIt.tr,
            'backgroundColor': const Color.fromRGBO(224, 44, 31, 1),
            'textColor': const Color.fromRGBO(255, 255, 255, 1),
          };
        }
      default:
        return {
          'text': statusLabel,
          'backgroundColor': AppColors.backgroundSecondary,
          'textColor': AppColors.textPrimary,
        };
    }
  }
}
