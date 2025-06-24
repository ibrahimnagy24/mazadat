import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DefaultDataPickerWidget extends StatelessWidget {
  const DefaultDataPickerWidget({
    super.key,
    this.enabled = true,
    this.firstDate,
    this.labelText,
    this.lastDate,
    this.needValidation = true,
    this.onSaved,
  });
  final String? labelText;
  final void Function(DateTimeRange?)? onSaved;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool needValidation;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateRangePicker(
      enabled: enabled,
      validator: needValidation
          ? (value) =>
              value.toString().isEmpty ? 'AppStrings.thisFieldIsRequired' : null
          : null,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onSaved: onSaved,
      name: '',
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 900)),
    );
  }
}
