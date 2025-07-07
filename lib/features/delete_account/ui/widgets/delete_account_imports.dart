

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/form_fields/default_password_form_field.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../logic/delete_account_cubit.dart';
import '../../logic/delete_account_state.dart';
import 'confirm_delete_account_button.dart';
import 'delete_account_content.dart';

part '../pages/delete_account_screen.dart';
part '../pages/delete_account_screen_mobile.dart';
