import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/misc/custom_network_image.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/model/payment_model.dart';
import '../../logic/payment_methods_cubit.dart';
import '../../logic/payment_methods_state.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({
    super.key,
    this.initialValue,
    this.onSelect,
    this.onSelectIndex,
    this.needToShowWalletOption = true,
  });
  final int? initialValue;
  final Function(PaymentModel)? onSelect;
  final Function(int)? onSelectIndex;
  final bool? needToShowWalletOption;
  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  int? _selectedItem;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodsCubit()..getPaymentList(),
      child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
          builder: (context, state) {
        if (state is PaymentMethodsLoading) {
          return ListAnimator(
            data: List.generate(
                5,
                (i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: CustomShimmerContainer(
                        height: 60.h,
                        width: MediaQueryHelper.width,
                      ),
                    )),
          );
        }
        if (state is PaymentMethodsSuccess) {
          List<PaymentModel> payments = state.payments;
          if (widget.needToShowWalletOption == false) {
            payments.removeWhere((element) => element.type == 'WALLET');
          }
          return ListAnimator(
            data: List.generate(
              payments.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() => _selectedItem = payments[index].id);
                  widget.onSelect?.call(payments[index]);
                  widget.onSelectIndex?.call(index);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    border: Border.all(
                      color: _selectedItem == payments[index].id
                          ? AppColors.kPrimary
                          : AppColors.border,
                    ),
                  ),
                  width: MediaQueryHelper.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8.w,
                    children: [
                      CustomNetworkImage.containerNewWorkImage(
                        image: payments[index].icon ?? '',
                        width: 24.w,
                        height: 24.w,
                        radius: 6.w,
                      ),
                      Expanded(
                        child: Text(
                          payments[index].name ?? '',
                          style: AppTextStyles.textXLMedium,
                        ),
                      ),
                      Icon(
                        _selectedItem == payments[index].id
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        size: 24,
                        color: _selectedItem == payments[index].id
                            ? AppColors.kPrimary
                            : AppColors.iconDefault,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is PaymentMethodsError) {
          return ErrorMessageWidget(
            error: state.error,
            onTap: () {
              context.read<PaymentMethodsCubit>().getPaymentList();
            },
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
