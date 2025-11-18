import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../logic/my_bundles_cubit.dart';
import 'my_bundles_mobile_design.dart';

class MyBundlesScreen extends StatelessWidget {
  const MyBundlesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyBundlesCubit()..myBundlesStatesHandled(SearchEngine()),
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MyBundlesMobileDesign(),
          landscape: (context) => const MyBundlesMobileDesign(),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => const MyBundlesMobileDesign(),
          landscape: (context) => const MyBundlesMobileDesign(),
        ),
      ),
    );
  }
}
