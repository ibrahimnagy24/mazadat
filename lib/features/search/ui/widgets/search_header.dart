import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../data/params/filter_params.dart';
import '../../logic/search_cubit.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({super.key});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FilterParams>(
        stream: context.read<SearchCubit>().filterStream,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: DefaultFormField(
                    hintText: '${AppStrings.searchForAuctions.tr}...',
                    needValidation: false,
                    initialValue: snapshot.data?.keyword,
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
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 12.h),
                      child: customImageIconSVG(
                          imageName: AppSvg.filter,
                          color: AppColors.iconDefault,
                          width: 20.w,
                          height: 20.w),
                    ),
                    onChanged: (v) {
                      if (timer != null) if (timer!.isActive) timer!.cancel();
                      timer = Timer(
                        const Duration(milliseconds: 400),
                        () {
                          context.read<SearchCubit>().updateFilter(
                              snapshot.data!.copyWith(keyword: v));

                          context
                              .read<SearchCubit>()
                              .searchStatesHandled(SearchEngine());
                        },
                      );
                    },
                    onSaved: (v) {
                      context
                          .read<SearchCubit>()
                          .updateFilter(snapshot.data!.copyWith(keyword: v));

                      context
                          .read<SearchCubit>()
                          .searchStatesHandled(SearchEngine());
                    },
                  ),
                )
              : const SizedBox();
        });
  }
}
