import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/payment_method.dart';
import '../widgets/payment_method_card.dart';
import 'cinetpay_webview_page.dart';
import '../providers/payment_service_provider.dart';

class PaymentMethodPage extends StatefulWidget {
  final String clientId;
  final String freelancerId;
  final double amount;
  final String description;
  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const PaymentMethodPage({
    super.key,
    required this.clientId,
    required this.freelancerId,
    required this.amount,
    required this.description,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  PaymentMethod? _selectedMethod;
  bool _isProcessing = false;

  void _handlePaymentMethodSelection(PaymentMethod method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  Future<void> _proceedToPayment() async {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner un mode de paiement'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final paymentService = PaymentServiceProvider.of(context);
      final result = await paymentService.initializePayment(
        clientId: widget.clientId,
        freelancerId: widget.freelancerId,
        amount: widget.amount,
        description: widget.description,
        customerName: widget.customerName,
        customerEmail: widget.customerEmail,
        customerPhone: widget.customerPhone,
      );

      if (mounted) {
        setState(() {
          _isProcessing = false;
        });

        if (result['success']) {
          final success = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => CinetPayWebViewPage(
                paymentUrl: result['payment_url'],
                paymentId: result['payment_id'],
                paymentService: paymentService,
              ),
            ),
          );

          if (success == true && mounted) {
            Navigator.of(context).pop(true);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['error'] ?? 'Une erreur est survenue'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Une erreur est survenue'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mode de paiement'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Choisissez votre mode de paiement',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Montant à payer : ${NumberFormat.currency(
                    symbol: 'FCFA',
                    decimalDigits: 0,
                  ).format(widget.amount)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                ...PaymentMethod.availableMethods.map((method) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PaymentMethodCard(
                      method: method,
                      isSelected: _selectedMethod == method,
                      onTap: () => _handlePaymentMethodSelection(method),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Procéder au paiement',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
