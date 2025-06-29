import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/styles.dart';
import 'app_font_size_styles.dart';

abstract class AppTextStyles {
  static const TextStyle SCREEN_TITLE =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 24);
  static const TextStyle w800 = TextStyle(fontWeight: FontWeight.w800);
  static const TextStyle w700 = TextStyle(fontWeight: FontWeight.w700);
  static const TextStyle w600 = TextStyle(fontWeight: FontWeight.w600);
  static const TextStyle w500 = TextStyle(fontWeight: FontWeight.w500);
//MAZADAT
//----------------------------------EXOW700----------------------------------//

  static TextStyle displayMdBold = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsXL,
    color: AppColors.kPrimary,
  );

  static TextStyle heading = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsL,
    color: AppColors.textDefault,
  );

  static TextStyle textLgBold = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsS,
    color: AppColors.textPrimary,
  );

  static TextStyle textMdBold = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.textPrimary,
  );

  static TextStyle textMdSemibold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.kPrimary,
  );

  static TextStyle textSmSemibold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSizes.xxs,
    color: AppColors.kPrimary,
  );
  static TextStyle textMdMedium = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.textSecondaryParagraph,
  );
  static TextStyle textXLMedium = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.fsM,
    color: AppColors.textDefault,
  );

  static TextStyle textMdRegular = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.textPrimaryParagraph,
  );

  static TextStyle textLgRegular = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.fsS,
    color: AppColors.textSecondaryParagraph,
  );

  static TextStyle exoW700SizeMediumWhite = GoogleFonts.exo(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsM,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle headingLBold = GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsXL,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle bodyXsReq = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle bodyXXsReq = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.xxs,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle bodyXsMed = GoogleFonts.notoSans(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.fsXs,
    color: AppColors.kPrimary500,
    letterSpacing: 0,
  );
  static TextStyle bodySReq = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.fsS,
    color: AppColors.kGeryText7,
    letterSpacing: 0,
  );
  static TextStyle bodySMed = GoogleFonts.notoSans(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.fsS2,
    color: AppColors.kGeryText7,
    letterSpacing: 0,
  );

  static TextStyle bodyMReq = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.fsM,
    color: AppColors.kGeryText4,
    letterSpacing: 0,
  );
  static TextStyle bodyMMed = GoogleFonts.notoSans(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.fsM,
    color: AppColors.kGeryText4,
    letterSpacing: 0,
  );
  static TextStyle bodyMBold = GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSizes.fsM,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle w700Font18Primary500 = GoogleFonts.notoSans(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.kPrimary500,
    letterSpacing: 0,
  );
  static TextStyle w400Font18kGeryText2 = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.xxs,
    color: AppColors.kGeryText2,
    letterSpacing: 0,
  );
  static TextStyle w400FontXXSkGeryText2 = GoogleFonts.notoSans(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSizes.xxs,
    color: AppColors.kGeryText2,
    letterSpacing: 0,
  );

  static TextStyle w500FontXXSkGeryText8 = GoogleFonts.notoSans(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSizes.xxs,
    color: AppColors.kGeryText8,
    letterSpacing: 0,
  );
//BARRQ
//----------------------------------BALOOW800----------------------------------//
  static TextStyle balooBhaijaan2W800Size32Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 32,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W800Size24KGold2 = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 24,
    color: AppColors.kGold2,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W800Size16kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W800Size18kWhite = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 18,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W800Size18kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 18,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W800Size12KGold2 = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w800,
    fontSize: 12,
    color: AppColors.kGold2,
    letterSpacing: 0,
  );

//----------------------------------BALOOW700----------------------------------//
  static TextStyle balooBhaijaan2W700Size24Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W700Size20Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W700Size18Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W700Size16kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W700Size14KGold2 = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.kGold2,
    letterSpacing: 0,
  );

//----------------------------------BALOOW600----------------------------------//
  static TextStyle balooBhaijaan2W600Size24Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size24White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W600Size20Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size18White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size18kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W600Size16Primary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W600Size16White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size16KBrown = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.Kbrown,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size16KGreen = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.KGreen,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size16KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W600Size14KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W600Size14White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size14Kburgundy =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.Kburgundy,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size14NavyBlue =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.navyBlue,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size14kOpacityGrey3 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.kOpacityGrey3,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W600Size12KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

//----------------------------------BALOOW500----------------------------------//
  static TextStyle balooBhaijaan2W500Size18KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W500Size16KPrimary700 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.kPrimary700,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W500Size16KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W500Size15KWhite = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W500Size14KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W500Size14opacityWhite =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: const Color.fromRGBO(255, 255, 255, 0.7),
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W500Size12KPrimary700 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.kPrimary700,
    letterSpacing: 0,
  );
//----------------------------------BALOOW400----------------------------------//
  static TextStyle balooBhaijaan2W400Size24kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size16KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size16kPrimary700 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.kPrimary700,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size16kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size16GreyText =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.kGeryText,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size14kOpacityGrey3 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kOpacityGrey3,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size14KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size14KPrimary700 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kPrimary700,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size14GreyText2 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kGeryText2,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size14GreyText3 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kGeryText3,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size14OpacityGrey2 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.kOpacityGrey2,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size13kPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12KPrimary1000 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kPrimary1000,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12kPrimary800 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kPrimary800,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12kOpacityGrey4 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kOpacityGrey4,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12kPrimary700 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kPrimary700,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size12kPrimary600 =
      GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kPrimary600,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size12kBlue = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: const Color(0xFF007DB5),
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12Gold = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kGold,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size12KGold3 = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kGold3,
    letterSpacing: 0,
  );

  static TextStyle balooBhaijaan2W400Size12White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size12KBrown = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.Kbrown,
    letterSpacing: 0,
  );
  static TextStyle balooBhaijaan2W400Size10White = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  //------------------------------CAIRO------------------------------//
  static TextStyle cairoW700Size20White = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );

  static TextStyle cairoW700Size16White = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
  static TextStyle cairoW700Size14White = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.kWhite,
    letterSpacing: 0,
  );
}
