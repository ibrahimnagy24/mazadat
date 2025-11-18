import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../features/static_pages/data/params/static_page_params.dart';
import '../../../features/static_pages/logic/static_page_cubit.dart';
import '../../../features/static_pages/logic/static_page_state.dart';
import '../../assets/app_svg.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/constant/app_strings.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/widgets/errors/error_message_widget.dart';
import '../../utils/widgets/loading/custom_loading.dart';
import '../blocs/main_app_bloc.dart';

class StaticPagesHtmlBottomSheetWidget extends StatelessWidget {
  const StaticPagesHtmlBottomSheetWidget({
    super.key,
    this.bottomWidget,
    this.lastModified,
    required this.params,
  });
  final Widget? bottomWidget;
  final String? lastModified;
  final StaticPageParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaticPageCubit()..getStaticPage(params),
      child: SafeArea(
        child: BlocBuilder<StaticPageCubit, StaticPageState>(
          buildWhen: (previous, current) =>
              current is GetStaticPageLoading ||
              current is GetStaticPageError ||
              current is GetStaticPageSuccess,
          builder: (context, state) {
            final cubit = context.read<StaticPageCubit>();
            if (state is GetStaticPageLoading) {
              return const Center(child: CustomLoading());
            }

            if (state is GetStaticPageError) {
              return Center(
                child: ErrorMessageWidget(
                  error: state.error,
                  onTap: () {
                    cubit.getStaticPage(params);
                  },
                  message: AppStrings.tryAgain.tr,
                ),
              );
            }
            if (state is GetStaticPageSuccess ||
                cubit.staticPageEntity != null) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
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
                                    text: AppStrings.agreeTo.tr,
                                    style: AppTextStyles.textXLRegular.copyWith(
                                      fontSize: 16,
                                      color: const Color.fromRGBO(
                                          138, 147, 118, 1),
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '\n${AppStrings.termsAndPrivacyPolicy.tr}',
                                        style: AppTextStyles.displaySMMedium
                                            .copyWith(
                                          fontSize: 20,
                                          color: const Color.fromRGBO(
                                              81, 94, 50, 1),
                                        ),
                                      ),
                                    ]),
                              ),

                              ///Last Modified
                              Row(
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(
                                    AppSvg.calendar,
                                    width: 13,
                                    height: 13,
                                    color:
                                        const Color.fromRGBO(185, 185, 185, 1),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                          text:
                                              '${AppStrings.lastModified.tr}  ',
                                          style: AppTextStyles.textMdRegular
                                              .copyWith(
                                                  color: const Color.fromRGBO(
                                                      162, 162, 162, 1)),
                                          children: [
                                            TextSpan(
                                              text: (DateTime.parse(cubit
                                                      .staticPageEntity!
                                                      .lastUpdateDate!))
                                                  .toDateFormat(
                                                      format: 'd MMMM yyyy',
                                                      locale: mainAppBloc
                                                          .lang.valueOrNull),
                                              style: AppTextStyles.textLgMedium
                                                  .copyWith(
                                                      color:
                                                          const Color.fromRGBO(
                                                              116,
                                                              116,
                                                              116,
                                                              1)),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          AppSvg.joiningAuctionBaitAlasjadyah,
                          height: 56,
                          width: 78,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32, color: AppColors.border),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        thickness: 8,
                        radius: const Radius.circular(8),
                        thumbColor: const Color.fromRGBO(209, 209, 209, 1),
                        trackColor: const Color.fromRGBO(242, 242, 242, 1),
                        trackBorderColor: Colors.transparent,
                        trackRadius: const Radius.circular(8),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: SingleChildScrollView(
                              child: HtmlWidget(cubit.staticPageEntity!.body)),
                        ),
                      ),
                    ),
                  ),
                  bottomWidget ?? const SizedBox.shrink(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
