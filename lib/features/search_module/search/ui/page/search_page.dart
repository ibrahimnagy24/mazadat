import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/utils/constant/app_constant.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../../search_result/logic/search_result_cubit.dart';
import '../../logic/search_cubit.dart';
import 'search_mobile_design.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SearchResultCubit()..searchResultStatesHandled(SearchEngine()),
        ),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: const SearchMobileDesign(),
    );
  }
}
