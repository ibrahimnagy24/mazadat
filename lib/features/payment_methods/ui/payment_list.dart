import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/assets/app_svg.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/extensions/media_query_helper.dart';
import '../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../core/utils/widgets/misc/custom_network_image.dart';
import '../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../data/model/payment_model.dart';
import '../logic/payment_methods_cubit.dart';
import '../logic/payment_methods_state.dart';

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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomShimmerContainer(
                        height: 60,
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedItem == payments[index].id
                          ? AppColors.kPrimary
                          : const Color.fromRGBO(232, 232, 232, 1),
                      width: _selectedItem == payments[index].id ? 1.5 : 1,
                    ),
                  ),
                  width: MediaQueryHelper.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8,
                    children: [
                      CustomNetworkImage.containerNewWorkImage(
                        image: payments[index].icon ?? '',
                        width: 24,
                        height: 24,
                        radius: 6,
                      ),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          style: _selectedItem == payments[index].id
                              ? AppTextStyles.textXLBold.copyWith(
                                  color: const Color.fromRGBO(81, 94, 50, 1))
                              : AppTextStyles.textXLRegular.copyWith(
                                  color:
                                      const Color.fromRGBO(162, 162, 162, 1)),
                          child: Text(payments[index].name ?? ''),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: SvgPicture.asset(
                          _selectedItem == payments[index].id
                              ? AppSvg.activeRadio
                              : AppSvg.inactiveRadio,
                          key: ValueKey<bool>(
                              _selectedItem == payments[index].id),
                          width: 18,
                          height: 18,
                        ),
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
        }
        return const SizedBox();
      }),
    );
  }
}
