import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/entities/static_page_entity.dart';

class StaticPageSuccessWidget extends StatelessWidget {
  const StaticPageSuccessWidget(this.staticPageEntity, {super.key});
  final StaticPageEntity staticPageEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (staticPageEntity.lastUpdateDate != null &&
                staticPageEntity.lastUpdateDate!.isNotEmpty &&
                DateTime.tryParse(staticPageEntity.lastUpdateDate!) != null)
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
                              text: AppStrings.agreeTo.tr,
                              style: AppTextStyles.textXLRegular.copyWith(
                                fontSize: 16,
                                color: const Color.fromRGBO(138, 147, 118, 1),
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '\n${AppStrings.termsAndPrivacyPolicy.tr}',
                                  style: AppTextStyles.displaySMMedium.copyWith(
                                    fontSize: 20,
                                    color: const Color.fromRGBO(81, 94, 50, 1),
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
                              width: 16,
                              height: 16,
                              color: const Color.fromRGBO(185, 185, 185, 1),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                    text: '${AppStrings.lastModified.tr}  ',
                                    style: AppTextStyles.textLgRegular,
                                    children: [
                                      TextSpan(
                                        text: (DateTime.parse(staticPageEntity
                                                .lastUpdateDate!))
                                            .toDateFormat(
                                                format: 'd MMMM yyyy',
                                                locale: mainAppBloc
                                                    .lang.valueOrNull),
                                        style: AppTextStyles.textLgRegular
                                            .copyWith(
                                                color: AppColors.textPrimary),
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
                    AppSvg.logo,
                    height: 56,
                    width: 78,
                    color: const Color.fromRGBO(81, 94, 50, 1),
                  ),
                ],
              ),
            if (staticPageEntity.lastUpdateDate != null &&
                staticPageEntity.lastUpdateDate!.isNotEmpty &&
                DateTime.tryParse(staticPageEntity.lastUpdateDate!) != null)
              const Divider(height: 32, color: AppColors.border),
            Expanded(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  staticPageEntity.body,
                  textStyle: AppTextStyles.balooBhaijaan2W400Size13kPrimary1000
                      .copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
