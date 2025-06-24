import 'package:flutter/material.dart';

class AuthImageWidget extends StatelessWidget {
  const AuthImageWidget({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'AppImages.loginHeader',
      height: height,
    );
  }
}
