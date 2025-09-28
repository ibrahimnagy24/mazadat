import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../bundle_joining/data/params/validate_bundle_params.dart';
import '../../../bundle_joining/ui/pages/validate_joining_bundle_view.dart';
import '../../data/params/bundle_details_route_params.dart';
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
          child: SafeArea(
            top: false,
            right: false,
            left: false,
            child: DefaultButton(
              text: AppStrings.registerInThePackage.tr,
              onPressed: () {
                final cubit = context.read<BundleDetailsCubit>();
                final List<int> auctionsId = cubit.bundleDetailsModel!.auction!
                    .map((e) => e.id)
                    .toList();

                final params = ValidateBundleParams(
                  id: cubit.bundleDetailsModel!.id!,
                  avaliableAuctionsId: auctionsId,
                );
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  builder: (bottomSheetContext) {
                    return ValidateJoiningBundleView(
                      params: params,
                      onSuccess: () {
                        final bundleId = cubit.bundleDetailsModel!.id!;
                        context.read<BundleDetailsCubit>().getBundleDetails(
                            BundleDetailsRouteParams(bundleId: bundleId));
                      },
                      bottomSheetContext: bottomSheetContext,
                    );
                  },
                );
              },
              height: 48,
              isLoading: state is BundleDetailsLoading,
            ),
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
