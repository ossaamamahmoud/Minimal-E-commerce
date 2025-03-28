import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/di/dependency_injection.dart';
import 'package:payment/core/helpers/extensions.dart';
import 'package:payment/features/payment/presentation/cubits/payments_cubit/payment_cubit.dart';
import 'package:payment/features/payment/presentation/ui/web_view_screen.dart';
import 'package:payment/features/payment/presentation/ui/widgets/payment_card.dart';

import '../../../../core/theming/app_styles.dart';
import '../../data/models/paymob_models/invoice_link_generation_model.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key, required this.amount});

  final num amount;

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool _isProcessing = false;

  // Asynchronous functions to process payments.
  Future<void> _handlePaymobPayment() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    final InvoiceLinkGenerationModel? invoiceModel =
        await getIt<PaymentsCubit>().payWithPaymob(amount: widget.amount);

    if (invoiceModel?.url != null) {
      context.navigateToReplacement(
        WebViewScreen(url: invoiceModel!.url!),
      );
    }
    setState(() => _isProcessing = false);
  }

  Future<void> _handleStripePayment() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await getIt<PaymentsCubit>().payWithStripe(amount: widget.amount);
    await Stripe.instance.presentPaymentSheet();

    setState(() => _isProcessing = false);
  }

  void _onTapPaymob() {
    _handlePaymobPayment();
  }

  void _onTapStripe() {
    _handleStripePayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Methods',
          style: TextStyles.font24Bold.copyWith(
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              PaymentCard(
                  imgUrl:
                      "https://images.ctfassets.net/y6oq7udscnj8/7pGYJSsSu8IjvuscnxPcng/ae9dc800b649640406b5bfa1ae9b02d6/PayPal.png?w=592&h=368&q=50&fm=png",
                  onTap: _isProcessing ? null : () {}),
              PaymentCard(
                imgUrl:
                    "https://ps.w.org/paymob-for-woocommerce/assets/icon-256X256.png?rev=2998235",
                onTap: _isProcessing ? null : _onTapPaymob,
              ),
              PaymentCard(
                imgUrl:
                    "https://www.ebs.ae/wp-content/uploads/2021/11/Stripe-Logo.png",
                onTap: _isProcessing ? null : _onTapStripe,
              ),
            ],
          ),
          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
