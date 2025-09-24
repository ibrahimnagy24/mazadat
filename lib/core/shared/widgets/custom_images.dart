import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/colors/styles.dart';
import '../../utils/extensions/extensions.dart';

Widget customImageIcon(
    {String? folderPath,
    required String imageName,
    String? imagePath,
    double? width,
    double? height,
    color,
    BoxFit? fit}) {
  return Image.asset(
    imageName,
    color: color,
    width: width ?? 30,
    height: height ?? 25,
    fit: fit,
  );
}

Widget customCircleSvgIcon(
    {String? folderPath,
    String? title,
    required String imageName,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return GestureDetector(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2.h,
      children: [
        CircleAvatar(
          backgroundColor: color ?? AppColors.kPrimary.withOpacity(0.1),
          radius: radius ?? 24,
          child: SvgPicture.asset(
            imageName,
          ),
        ),
        if (title != null)
          Text(
            title,
            style: const TextStyle(
                color: AppColors.kPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
      ],
    ),
  );
}

Widget customImageIconSVG({
  required String imageName,
  Color? color,
  double? height,
  double? width,
  BoxFit? fit,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(
      imageName,
      color: color,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    ),
  );
}

Widget customContainerSvgIcon(
    {required String imageName,
    Function? onTap,
    Color? color,
    Color? backGround,
    Color? borderColor,
    double? padding,
    double? width,
    double? height,
    double? radius}) {
  return InkWell(
    onTap: () {
      onTap?.call();
    },
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    child: Container(
      height: height ?? 50,
      width: width ?? 50,
      padding: EdgeInsets.all(padding ?? 16),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.transparent),
        color: backGround ?? AppColors.kWhite,
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: SvgPicture.asset(
        imageName,
        color: color,
      ),
    ),
  );
}
