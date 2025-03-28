import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/di/dependency_injection.dart';
import 'package:payment/core/helpers/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/theming/app_styles.dart';
import '../../../home/presentation/cubits/products_cubit.dart';
import '../../../home/presentation/ui/home_screen.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webViewController;
  bool isLoading = true;
  bool showSuccessMessage = false;
  bool paymentApproved = false;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress < 100) {
              setState(() => isLoading = true);
            }
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);

            // Only proceed if the user has reached the final confirmation page
            if (paymentApproved) {
              Future.delayed(const Duration(seconds: 5), () {
                if (mounted) {
                  setState(() => showSuccessMessage = false);
                  _navigateToHome(context);
                }
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            print("Navigating to: ${request.url}");

            if (request.url.contains("success=true")) {
              setState(() {
                paymentApproved = true;
              });
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => isLoading = false);
            print("Web resource error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _navigateToHome(BuildContext context) {
    final cubit = getIt<ProductsCubit>();
    cubit.cart.clear();
    cubit.currentIndex = 0;
    context.navigateToReplacement(const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: showSuccessMessage
            ? null
            : IconButton(
                onPressed: () => _navigateToHome(context),
                icon: const Icon(Icons.arrow_back, size: 23),
              ),
        title: Text(
          "Payment",
          style: TextStyles.font24Bold,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          if (paymentApproved)
            Positioned(
              bottom: 0.2.sh,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "You will be redirected to the home screen in 5 seconds.",
                        textAlign: TextAlign.center,
                        style: TextStyles.font16semiBold,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
