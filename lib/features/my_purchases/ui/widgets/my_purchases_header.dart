import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../logic/my_purchases_cubit.dart';
import '../../logic/my_purchases_state.dart';

class MyPurchasesHeader extends StatefulWidget {
  const MyPurchasesHeader({super.key});

  @override
  State<MyPurchasesHeader> createState() => _MyPurchasesHeaderState();
}

class _MyPurchasesHeaderState extends State<MyPurchasesHeader> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPurchasesCubit, MyPurchasesState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: DefaultFormField(
                controller: context.read<MyPurchasesCubit>().keywordTEC,
                hintText: '${AppStrings.searchByOrderNumber.tr}...',
                needValidation: false,
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 12.w,
                    top: 12.h,
                    bottom: 12.h,
                  ),
                  child: customImageIconSVG(
                      imageName: AppSvg.searchIcon,
                      color: AppColors.iconDefault,
                      width: 20.w,
                      height: 20.w),
                ),
                onChanged: (v) {
                  if (timer != null) if (timer!.isActive) timer!.cancel();
                  timer = Timer(
                    const Duration(milliseconds: 400),
                    () {
                      context
                          .read<MyPurchasesCubit>()
                          .myPurchasesStatesHandled(SearchEngine());
                    },
                  );
                },
                onSaved: (v) {
                  context
                      .read<MyPurchasesCubit>()
                      .myPurchasesStatesHandled(SearchEngine());
                },
              ),
            ),

            ///Listing Button
            StreamBuilder(
                stream: context.read<MyPurchasesCubit>().listingStream,
                builder: (c, snapshot) {
                  return InkWell(
                    onTap: () => context
                        .read<MyPurchasesCubit>()
                        .updateListing(snapshot.data == true ? false : true),
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 14.h),
                      decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          border: Border.all(
                            color: AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.rMd)),
                      child: customImageIconSVG(
                        imageName:
                            snapshot.data == true ? AppSvg.grid : AppSvg.list,
                        width: 20.w,
                        height: 20.w,
                        color: AppColors.iconDefault,
                      ),
                    ),
                  );
                }),
          ],
        ),
      );
    });
  }
}
