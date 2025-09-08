import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../auction_details/auction_joining/ui/pages/join_auction_view.dart';
import '../../../auction_details/auction_joining/ui/pages/validate_joining_auction_view.dart';
import '../../../auction_details/view_auction/logic/view_auction_details_cubit.dart';
import '../../logic/bundle_details_cubit.dart';

class BundleDetailsJoiningButtonWidget extends StatelessWidget {
  const BundleDetailsJoiningButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BundleDetailsCubit, BundleDetailsState>(
      buildWhen: (previous, current) =>
          current is BundleDetailsSuccess ||
          current is BundleDetailsError ||
          current is BundleDetailsLoading,
      builder: (context, state) {
        final cubit = context.read<BundleDetailsCubit>();
        if (cubit.bundleDetailsModel == null) {
          return const SizedBox.shrink();
        }
        if (cubit.bundleDetailsModel!.isJoined == true) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 114,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: AppColors.kWhite),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: DefaultButton(
            text: AppStrings.registerInThePackage.tr,
            onPressed: () {
              // cubit.
              CustomBottomSheet.show(
                widget: ValidateJoiningAuctionView(
                  id: 121,
                  onSuccess: () => context
                      .read<ViewAuctionDetailsCubit>()
                      .viewAuctionDetailsStatesHandled(),
                ),
              );
              // showModalBottomSheet(
              //   context: context,
              //   builder: (dialogContext) {
              //     return JoinAuctionView(
              //       id: 121,
              //       onSuccess: () {},
              //     );
              //   },
              // );
            },
            height: 48,
            isLoading: state is BundleDetailsLoading,
          ),
        );
      },
    );
  }
}

// class _JoinAuctionView extends StatelessWidget {
//   const _JoinAuctionView({super.key, required this.id, this.onSuccess});
//   final int id;
//   final Function()? onSuccess;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => JoiningAuctionCubit(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//         child: BlocBuilder<JoiningAuctionCubit, JoiningAuctionState>(
//             builder: (context, state) {
//           return Column(
//             spacing: 8.h,
//             children: [
//               Expanded(
//                 child: StreamBuilder(
//                   stream: context.read<JoiningAuctionCubit>().paymentStream,
//                   builder: (context, snapshot) {
//                     return PaymentList(
//                       onSelect: (v) =>
//                           context.read<JoiningAuctionCubit>().updatePayment(v),
//                       initialValue: snapshot.data?.id,
//                     );
//                   },
//                 ),
//               ),
//               DefaultButton(
//                 textStyle: AppTextStyles.bodyXlBold
//                     .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
//                 text: AppStrings.confirm.tr,
//                 isLoading: state is JoiningAuctionLoading,
//                 onPressed: () {
//                   if (context.read<JoiningAuctionCubit>().payment.valueOrNull !=
//                       null) {
//                     context
//                         .read<JoiningAuctionCubit>()
//                         .joinAuction(id: id, onSuccess: onSuccess);
//                   } else {
//                     showToast(AppStrings.youHaveToSelectPaymentMethod.tr);
//                   }
//                 },
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
