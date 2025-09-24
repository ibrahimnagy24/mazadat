import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/widgets/custom_back_icon.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../shared/auth_header_content.dart';
import '../../data/params/change_phone_number_route_params.dart';
import '../../logic/change_phone_number_cubit.dart';
import '../../logic/change_phone_number_state.dart';
import 'change_phone_number_button_widget.dart';

part '../pages/change_phone_number_screen.dart';
part '../pages/change_phone_number_screen_mobile_design.dart';
