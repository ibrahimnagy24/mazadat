import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';

class WhatsappContactWidget extends StatelessWidget {
  const WhatsappContactWidget({
    super.key,
    required this.whatsappNumber,
  });

  final String whatsappNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainAppBloc.isArabic
              ? 'يمكنك التواصل ايضاً عن طريق رقم واتساب'
              : 'You can also contact us through WhatsApp number',
          style: AppTextStyles.textLgBold
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _launchWhatsApp(whatsappNumber),
          child: Row(
            children: [
              Image.asset(
                AppImages.whatsappImage,
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 8),
              Text(
                whatsappNumber,
                style: AppTextStyles.textLgRegular.copyWith(
                  color: const Color.fromRGBO(116, 116, 116, 1),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    // Remove any spaces, dashes, or other formatting from the phone number
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Create WhatsApp URL
    final whatsappUrl = 'https://wa.me/$cleanNumber';

    try {
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: try to open WhatsApp app directly
        final appUri = Uri.parse('whatsapp://send?phone=$cleanNumber');
        if (await canLaunchUrl(appUri)) {
          await launchUrl(appUri);
        }
      }
    } catch (e) {
      // Handle error silently or show a toast
      debugPrint('Could not launch WhatsApp: $e');
    }
  }
}
