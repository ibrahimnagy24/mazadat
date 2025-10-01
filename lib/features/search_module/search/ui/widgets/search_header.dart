import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../data/params/filter_params.dart';
import '../../logic/search_cubit.dart';
import 'search_filter_view.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: DefaultFormField(
                    controller: snapshot.data?.keywordTEC,
                    hintText: AppStrings.searchForAuctions.tr,
                    hintStyle: AppTextStyles.textLgRegular.copyWith(
                        color: const Color.fromRGBO(162, 162, 162, 1)),
                    needValidation: false,
                    borderColor: const Color.fromRGBO(232, 232, 232, 1),
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 16, end: 12, top: 12, bottom: 12),
                      child: SvgPicture.asset(
                        AppSvg.searchIcon,
                        color: const Color.fromRGBO(162, 162, 162, 1),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      child: GestureDetector(
                        onTap: () => CustomBottomSheet.show(
                          dragColor: const Color.fromRGBO(0, 0, 0, 1),
                          labelWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.filter.tr,
                                    style: AppTextStyles.displaySMMedium
                                        .copyWith(
                                            color: const Color.fromRGBO(
                                                46, 46, 46, 1)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<SearchCubit>().resetFilter();
                                    CustomNavigator.pop();
                                  },
                                  child: Text(
                                    AppStrings.reset.tr,
                                    style: AppTextStyles.textMdSemibold
                                        .copyWith(
                                            color: const Color.fromRGBO(
                                                81, 94, 50, 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget: SearchFilterView(blocContext: context),
                        ),
                        child: SvgPicture.asset(
                          AppSvg.filter,
                          color: const Color.fromRGBO(162, 162, 162, 1),
                          width: 20,
                          height: 20,
                        ),
                      ),
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
