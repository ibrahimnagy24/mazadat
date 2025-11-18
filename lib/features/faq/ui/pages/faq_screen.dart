import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../data/params/faq_route_params.dart';
import '../../logic/faq_cubit.dart';
import '../../logic/faq_state.dart';
import '../widgets/faq_expansion_tile.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({
    super.key,
    required this.params,
  });
  final FaqRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqCubit()..getFaqsStatesHandled(),
      child: BlocConsumer<FaqCubit, FaqState>(
        listener: (context, state) {
          if (state is FaqError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<FaqCubit>();
          final isLoading = state is FaqLoading;

          return CustomScaffoldWidget(
            appbarTitle: Text(AppStrings.whoAreWe.tr),
            needAppbar: true,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const CustomBackIcon(),
                      const SizedBox(height: 17),
                      if (cubit.lastUpdateDate != null &&
                          cubit.lastUpdateDate!.isNotEmpty &&
                          DateTime.tryParse(cubit.lastUpdateDate!) != null)
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: AppStrings.faq.tr,
                                      style:
                                          AppTextStyles.displayMdBold.copyWith(
                                        fontSize: 24,
                                        color:
                                            const Color.fromRGBO(34, 39, 21, 1),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    spacing: 4,
                                    children: [
                                      SvgPicture.asset(
                                        AppSvg.calendar,
                                        width: 16,
                                        height: 16,
                                        color: const Color.fromRGBO(
                                            185, 185, 185, 1),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text:
                                                '${AppStrings.lastModified.tr}  ',
                                            style: AppTextStyles.textMdRegular
                                                .copyWith(
                                              color: const Color.fromRGBO(
                                                  162, 162, 162, 1),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: (DateTime.parse(
                                                        cubit.lastUpdateDate!))
                                                    .toDateFormat(
                                                        format: 'd MMMM yyyy',
                                                        locale: mainAppBloc
                                                            .lang.valueOrNull),
                                                style: AppTextStyles
                                                    .textLgMedium
                                                    .copyWith(
                                                  color: const Color.fromRGBO(
                                                      116, 116, 116, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              AppSvg.baitAlasjdiahGoldLogo,
                              height: 56,
                              width: 78,
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(81, 94, 50, 1),
                          ),
                        )
                      else if (state is FaqSuccess)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.faqs.length,
                          itemBuilder: (context, index) {
                            final faq = state.faqs[index];
                            return FaqExpansionTile(faq: faq);
                          },
                        )
                      else if (state is FaqEmpty)
                        Center(
                          child: Text(
                            AppStrings.no_data.tr,
                            style: AppTextStyles.textMdRegular.copyWith(
                              color: const Color.fromRGBO(92, 92, 92, 1),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
