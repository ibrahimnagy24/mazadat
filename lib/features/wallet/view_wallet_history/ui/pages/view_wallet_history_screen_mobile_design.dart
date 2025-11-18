import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_constant.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../../core/shared/widgets/wallet_history_card_widget.dart';
import '../../../view_wallet/data/params/view_wallet_params.dart';
import '../../../view_wallet/logic/view_my_wallet_cubit.dart';
import '../../../view_wallet/logic/view_my_wallet_state.dart';
import '../../data/params/view_wallet_history_route_params.dart';

class ViewWalletHistoryScreenMobileDesign extends StatefulWidget {
  const ViewWalletHistoryScreenMobileDesign({super.key, required this.params});
  final ViewWalletHistoryRouteParams params;

  @override
  State<ViewWalletHistoryScreenMobileDesign> createState() =>
      _ViewWalletHistoryScreenMobileDesignState();
}

class _ViewWalletHistoryScreenMobileDesignState
    extends State<ViewWalletHistoryScreenMobileDesign> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    widget.params.viewMyWalletCubit.size = 10000;

    widget.params.viewMyWalletCubit.viewMyWalletStatesHandled(
      params: ViewWalletParams(
        page: widget.params.viewMyWalletCubit.page,
        size: widget.params.viewMyWalletCubit.size,
      ),
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _scrollListener() {
  //   if (_scrollController.position.atEdge &&
  //       _scrollController.position.pixels != 0) {
  //     if (widget.params.viewMyWalletCubit.viewMyWalletEntity != null &&
  //         widget.params.viewMyWalletCubit.viewMyWalletEntity!.pagginationEntity
  //                 .lastPage >=
  //             widget.params.viewMyWalletCubit.page) {
  //       widget.params.viewMyWalletCubit.page++;
  //       widget.params.viewMyWalletCubit.viewMyWalletStatesHandled();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbarTitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                AppImages.arrowBlack,
                height: 14,
                width: 14,
              ),
            ),
            const SizedBox(width: 16),
            MainText(
              text: AppStrings.transactionHistory.tr,
              style: AppTextStyles.displayMdBold
                  .copyWith(color: AppColors.textPrimarySaFlag),
            ),
          ],
        ),
      ),
      appbarHeight: AppConstant.appbarheight,
      centerAppbarTitle: false,
      appbarLeading: const SizedBox.shrink(),
      leadingWidth: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ViewMyWalletCubit, ViewMyWalletState>(
          buildWhen: (previous, current) =>
              current is ViewMyWalletLoading ||
              current is ViewMyWalletSuccess ||
              current is ViewMyWalletError,
          builder: (context, state) {
            final cubit = widget.params.viewMyWalletCubit;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.viewMyWalletEntity!.walletHistory.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return WalletHistoryCardWidget(
                    wallet: cubit.viewMyWalletEntity!.walletHistory[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
