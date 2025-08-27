import 'package:flutter/material.dart';
import '../../../assets/app_launchers.dart';
import '../../../assets/app_svg.dart';
import '../../../shared/widgets/custom_images.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../extensions/media_query_helper.dart';
import '../responsive/responsive.dart';

class ResponsiveEmptyWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final bool isSvg;
  final bool showImage;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? minHeight;
  final double? maxHeight;
  final VoidCallback? onTap;
  final Widget? customAction;
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveEmptyWidget({
    super.key,
    this.image,
    this.title,
    this.subtitle,
    this.isSvg = false,
    this.showImage = true,
    this.padding,
    this.margin,
    this.minHeight,
    this.maxHeight,
    this.onTap,
    this.customAction,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive sizing based on screen size
    final imageSize = _getImageSize(context);
    final titleFontSize = _getTitleFontSize(context);
    final subtitleFontSize = _getSubtitleFontSize(context);
    final spacing = _getSpacing(context);

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (showImage) ...[
          _buildImage(imageSize),
          SizedBox(height: spacing),
        ],
        if (title != null) ...[
          _buildTitle(titleFontSize),
          if (subtitle != null) SizedBox(height: spacing * 0.5),
        ],
        if (subtitle != null) _buildSubtitle(subtitleFontSize),
        if (customAction != null) ...[
          SizedBox(height: spacing),
          customAction!,
        ],
      ],
    );

    Widget wrappedContent = Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: Responsive.isLarge(context) ? 32.w : 16.w,
        vertical: Responsive.isLarge(context) ? 24.h : 16.h,
      ),
      margin: margin,
      decoration: backgroundColor != null
          ? BoxDecoration(color: backgroundColor)
          : null,
      child: Center(child: content),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: wrappedContent,
      );
    }

    return wrappedContent;
  }

  Widget _buildImage(double size) {
    if (isSvg) {
      return customImageIconSVG(
        imageName: image ?? AppSvg.logo,
        width: size,
        height: size,
      );
    } else {
      return customImageIcon(
        imageName: image ?? AppLaunchers.logo,
        width: size,
        height: size,
      );
    }
  }

  Widget _buildTitle(double fontSize) {
    return Text(
      title ?? AppStrings.no_data,
      textAlign: TextAlign.center,
      style: AppTextStyles.displayMdSemiBold.copyWith(
        fontSize: fontSize,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle(double fontSize) {
    return Text(
      subtitle!,
      textAlign: TextAlign.center,
      style: AppTextStyles.textLgRegular.copyWith(
        fontSize: fontSize,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  double _getImageSize(BuildContext context) {
    if (Responsive.isLarge(context)) {
      return MediaQueryHelper.width * 0.25;
    } else if (Responsive.isMedium(context)) {
      return MediaQueryHelper.width * 0.35;
    } else {
      return MediaQueryHelper.width * 0.45;
    }
  }

  double _getTitleFontSize(BuildContext context) {
    if (Responsive.isLarge(context)) {
      return 28;
    } else if (Responsive.isMedium(context)) {
      return 24;
    } else {
      return 20;
    }
  }

  double _getSubtitleFontSize(BuildContext context) {
    if (Responsive.isLarge(context)) {
      return 18;
    } else if (Responsive.isMedium(context)) {
      return 16;
    } else {
      return 14;
    }
  }

  double _getSpacing(BuildContext context) {
    if (Responsive.isLarge(context)) {
      return 24.h;
    } else if (Responsive.isMedium(context)) {
      return 20.h;
    } else {
      return 16.h;
    }
  }
}
