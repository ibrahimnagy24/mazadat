import 'package:flutter/cupertino.dart';
import '../../../assets/app_launchers.dart';
import '../../../assets/app_svg.dart';
import '../../../shared/widgets/custom_images.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../extensions/media_query_helper.dart';

class EmptyState extends StatelessWidget {
  final String? img;
  final double? imgHeight;
  final double? emptyHeight;
  final double? imgWidth;
  final bool isSvg;
  final double? spaceBtw;
  final String? txt;
  final String? subText;
  final bool withImage;
  final EdgeInsetsGeometry? padding;
  const EmptyState({
    super.key,
    this.emptyHeight,
    this.spaceBtw,
    this.isSvg = false,
    this.withImage = true,
    this.img,
    this.imgHeight,
    this.imgWidth,
    this.txt,
    this.subText,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: 50.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (withImage)
              !isSvg
                  ? customImageIcon(
                      imageName: img ?? AppLaunchers.logo,
                      width: imgWidth ?? MediaQueryHelper.width * 0.45,
                      height: imgHeight ?? MediaQueryHelper.height * 0.2,
                    ) //width: MediaQueryHelper.width*.8,),
                  : customImageIconSVG(
                      imageName: img ?? AppSvg.logo,
                      width: imgWidth ?? MediaQueryHelper.width * 0.45,
                      height: imgHeight ?? MediaQueryHelper.height * 0.2,
                    ),
            SizedBox(
              height: spaceBtw ?? 16.h,
            ),
            Text(txt ?? AppStrings.no_data,
                textAlign: TextAlign.center,
                style: AppTextStyles.displayMdSemiBold.copyWith(fontSize: 24)),
            SizedBox(height: 8.h),
            Text(subText ?? '',
                textAlign: TextAlign.center, style: AppTextStyles.textLgRegular)
          ],
        ),
      ),
    );
  }
}
