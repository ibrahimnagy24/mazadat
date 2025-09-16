import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entities/static_page_entity.dart';

class StaticPageAboutUsSuccessWidget extends StatelessWidget {
  const StaticPageAboutUsSuccessWidget(this.staticPageEntity, {super.key});
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: AppStrings.whoAreWe.tr,
              style: AppTextStyles.displayMdBold
                  .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                AppImages.primaryColorLogo,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 64),
            Expanded(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  staticPageEntity.body,
                  textStyle: AppTextStyles.textXLMedium.copyWith(
                    fontSize: 16,
                    color: const Color.fromRGBO(46, 46, 46, 1),
                  ),
                  customStylesBuilder: (element) {
                    if (element.localName == 'p' ||
                        element.localName == 'div' ||
                        element.localName == 'span') {
                      return {'text-align': 'center'};
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SafeArea(
              top: false,
              left: false,
              right: false,
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final version = snapshot.data!.version;
                    return Center(
                      child: Text(
                        mainAppBloc.isArabic
                            ? 'الإصدار $version - حقوق النشر © بيت العسجدية'
                            : 'Version $version - Copyright © Beit Al Usjdah',
                        style: AppTextStyles.textLgRegular
                            .copyWith(color: const Color.fromRGBO(0, 0, 0, 1)),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
