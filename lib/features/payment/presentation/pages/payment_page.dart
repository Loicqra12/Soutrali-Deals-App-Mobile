import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  final String bookingId;
  final String serviceId;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.serviceId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = 'mobile_money';
  final TextEditingController _phoneController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simuler le traitement du paiement
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      // Afficher la confirmation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Paiement réussi'),
          content: const Text(
            'Votre paiement a été traité avec succès. Vous recevrez une confirmation par SMS.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: 24),
            _buildPaymentMethods(),
            const SizedBox(height: 24),
            if (_selectedMethod == 'mobile_money') _buildMobileMoneyForm(),
            const SizedBox(height: 32),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résumé de la commande',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Service'),
              Text('1000 FCFA'),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frais de service'),
              Text('100 FCFA'),
            ],
          ),
          const Divider(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '1100 FCFA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF27AE60),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Méthode de paiement',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildPaymentMethodTile(
          'Mobile Money',
          'Payez avec Orange Money, MTN Money, etc.',
          'mobile_money',
          Icons.phone_android,
        ),
        _buildPaymentMethodTile(
          'Carte bancaire',
          'Payez avec votre carte Visa ou Mastercard',
          'card',
          Icons.credit_card,
        ),
        _buildPaymentMethodTile(
          'En espèces',
          'Payez en espèces à la livraison',
          'cash',
          Icons.money,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(
    String title,
    String subtitle,
    String value,
    IconData icon,
  ) {
    return RadioListTile(
      value: value,
      groupValue: _selectedMethod,
      onChanged: (value) {
        setState(() {
          _selectedMethod = value.toString();
        });
      },
      title: Row(
        children: [
          Icon(icon, color: const Color(0xFF27AE60)),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildMobileMoneyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Numéro Mobile Money',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Ex: 07 XX XX XX XX',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.phone),
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF27AE60),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Payer maintenant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
