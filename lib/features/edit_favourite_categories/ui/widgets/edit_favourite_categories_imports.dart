import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';

import '../../../category/logic/category_cubit.dart';
import '../../logic/edit_favourite_categories_cubit.dart';
import '../../logic/edit_favourite_categories_state.dart';

import 'edit_favourite_categories_button.dart';

import 'edit_favourite_categories_app_bar.dart';
import 'edit_favourite_categories_header.dart';
import 'edit_favourite_categories_body.dart';

part '../pages/edit_favourite_categories_screen.dart';
part '../pages/edit_favourite_categories_screen_mobile_design.dart';
