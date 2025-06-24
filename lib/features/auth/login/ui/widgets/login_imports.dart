import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_password_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../../shared/auth_title_image_banner_widget.dart';
import '../../logic/login_cubit.dart';
import '../../logic/login_state.dart';
import '../widgets/login_button_widget.dart';
import 'dont_have_account_widget.dart';
import 'login_as_visitor_text_widget.dart';
import 'login_remember_me_widget.dart';

part '../pages/login_screen.dart';
part '../pages/login_screen_mobile.dart';
