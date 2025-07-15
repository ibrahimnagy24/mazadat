import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/navigation/custom_navigation.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/utils/widgets/custom_app_bar.dart';


class PaymentPage extends StatefulWidget {
  final String url;

  const PaymentPage({super.key, required this.url});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true),
            onWebViewCreated: (controller) => evaluateJavaScript(controller),
            onLoadStart: (controller, url) => setState(() => isLoading = true),
            onLoadStop: (controller, url) {
              isLoading = false;
              setState(() {});

              /// Evaluate JavaScript to check for a response
              evaluateJavaScript(controller);
            },
          ),
          if (isLoading)
            Column(
              children: [
                Expanded(
                    child: Container(
                        color: AppColors.kWhite,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.kPrimary,
                        )))),
              ],
            ),
        ],
      ),
    );
  }

  void evaluateJavaScript(controller) async {
    if (controller != null) {
      /// Execute JavaScript code within the WebView
      String? result = await controller!
          .evaluateJavascript(source: 'document.body.innerHTML');
      log("======>result: $result");

      /// Process the JavaScript response
      if (result != null && result.contains('Transaction successful')) {
        Future.delayed(const Duration(seconds: 1), () {
          CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true, extra: 0);
        });
      }

      if (result != null && result.contains('Transaction not completed')) {
        Future.delayed(const Duration(seconds: 1), () {
          CustomNavigator.pop();
        });
      }
    }
  }
}
