import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../data/payment_service.dart';
import '../../domain/models/payment.dart';

class CinetPayWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final String paymentId;
  final PaymentService paymentService;

  const CinetPayWebViewPage({
    super.key,
    required this.paymentUrl,
    required this.paymentId,
    required this.paymentService,
  });

  @override
  State<CinetPayWebViewPage> createState() => _CinetPayWebViewPageState();
}

class _CinetPayWebViewPageState extends State<CinetPayWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _checkPaymentStatus(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://votre-domaine.com/return')) {
              _handlePaymentCompletion(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkPaymentStatus(String url) {
    if (url.contains('success') || url.contains('cancel')) {
      // Vérifier le statut du paiement avec l'API CinetPay
      widget.paymentService.processPayment(widget.paymentId);
    }
  }

  Future<void> _handlePaymentCompletion(String url) async {
    final uri = Uri.parse(url);
    final status = uri.queryParameters['status'];
    
    if (status == 'success') {
      await widget.paymentService.updatePaymentStatus(
        widget.paymentId,
        PaymentStatus.completed,
        transactionId: uri.queryParameters['transaction_id'],
      );
    } else {
      await widget.paymentService.updatePaymentStatus(
        widget.paymentId,
        PaymentStatus.failed,
      );
    }

    if (mounted) {
      Navigator.of(context).pop(status == 'success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.paymentService.updatePaymentStatus(
              widget.paymentId,
              PaymentStatus.failed,
            );
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
