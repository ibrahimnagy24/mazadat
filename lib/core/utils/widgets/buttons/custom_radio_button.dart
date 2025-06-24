import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final Widget? checkedWidget, unCheckedWidget;
  final void Function(bool)? onChange;
  final bool check;

  const CustomRadioButton({super.key, required this.check, this.checkedWidget, this.unCheckedWidget, this.onChange});
  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChange != null) widget.onChange!(widget.check);
      },
      child: widget.check ? widget.checkedWidget : widget.unCheckedWidget,
    );
  }
}
