// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DropDownLanguage extends StatefulWidget {
//   const DropDownLanguage({
//     super.key,
//     this.backGroundColor,
//     this.dropDownElevation,
//     this.elevation,
//     this.textColor,
//   });

//   final Color? backGroundColor;
//   final int? dropDownElevation;
//   final double? elevation;
//   final Color? textColor;
//   @override
//   State<DropDownLanguage> createState() => _DropDownLanguageState();
// }

// class _DropDownLanguageState extends State<DropDownLanguage> {
//   String oldLanguage = lang.name == "ar" ? "ARABIC".tr() : "ENGLISH".tr();
//   String currentLanguage = lang.name == "ar" ? "ARABIC".tr() : "ENGLISH".tr();

//   List langItem = [
//     'ARABIC'.tr(),
//     "ENGLISH".tr(),
//   ];

//   String? newLanguage;
//   bool? anyThingChange;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: widget.backGroundColor ?? AppColors.transparent,
//       elevation: widget.elevation ?? 0,
//       child: Padding(
//         padding: const EdgeInsetsDirectional.only(start: 20),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             elevation: widget.dropDownElevation ?? 5,
//             dropdownColor: AppColors.transparent,
//             borderRadius: BorderRadius.circular(10.r),
//             // value: currentLanguage,
//             style: TextStyle(color: widget.textColor ?? AppColors.white),
//             iconSize: 30.0,
//             icon: Icon(
//               Icons.arrow_circle_down_outlined,
//               color: AppColors.black,
//               size: 16.sp,
//             ),
//             items: langItem
//                 .map(
//                   (e) => DropdownMenuItem(
//                     value: e,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6.r),
//                         color: AppColors.white,
//                       ),
//                       alignment: Alignment.center,
//                       height: 24.h,
//                       width: 112.w,
//                       child: Text(
//                         e,
//                         style: TextStyles.interW400Size16Black,
//                       ),
//                     ),
//                   ),
//                 )
//                 .toList(),
//             onChanged: (val) async {
//               if (currentLanguage != val) {
//                 currentLanguage = val.toString();
//                 newLanguage = val.toString();

//                 if (newLanguage != null) {
//                   if (newLanguage == 'ARABIC'.tr()) {
//                     SharedPrefHelper.setData(
//                         SharedPrefKeys.lang, LangKeysConstances.ar.name);
//                     await context.setLocale(const Locale('ar'));
//                     lang = LangKeysConstances.ar;
//                     anyThingChange = true;
//                     isArabic = true;
//                   } else {
//                     SharedPrefHelper.setData(
//                         SharedPrefKeys.lang, LangKeysConstances.en.name);
//                     await context.setLocale(const Locale('en'));
//                     lang = LangKeysConstances.en;
//                     isArabic = false;
//                     anyThingChange = true;
//                   }
//                 }
//                 if (anyThingChange == true) {
//                   // ignore: use_build_context_synchronously
//                   RestartWidget.restartApp(context);
//                 }
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
