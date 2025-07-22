import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_core.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../check_out/ui/widgets/payment_list.dart';
import '../../logic/joining_auction_state.dart';

class JoinAuctionView extends StatelessWidget {
  const JoinAuctionView({super.key, required this.id, this.onSuccess});
  final int id;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => JoiningAuctionCubit(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: BlocBuilder<JoiningAuctionCubit, JoiningAuctionState>(
              builder: (context, state) {
            return Column(
              spacing: 8.h,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: context.read<JoiningAuctionCubit>().paymentStream,
                    builder: (context, snapshot) {
                      return PaymentList(
                        onSelect: (v) => context.read<JoiningAuctionCubit>().updatePayment(v),
                        initialValue: snapshot.data?.id,
                      );
                    },
                  ),
                ),
                DefaultButton(
                  text: AppStrings.confirm.tr,
                  isLoading: state is JoiningAuctionLoading,
                  onPressed: () {
                    if(  context.read<JoiningAuctionCubit>().payment.valueOrNull != null){
                      context.read<JoiningAuctionCubit>().joinAuction(id:id,onSuccess:onSuccess );
                    }else{
                      showToast(AppStrings.youHaveToSelectPaymentMethod.tr);
                    }
                  },
                ),
              ],
            );
          }),
        ));
  }
}
