import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/my_sales_cubit.dart';
import 'my_sales_mobile_design.dart';

class MySalesScreen extends StatelessWidget {
  const MySalesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MySalesCubit()..getAuctions(),
      child: const MySalesMobileDesign(),
    );
  }
}
