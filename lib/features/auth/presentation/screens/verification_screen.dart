import 'package:flutter/material.dart';
import '../widgets/verification_code_input.dart';
import '../../../../core/theme.dart';

class VerificationScreen extends StatefulWidget {
  final String contactInfo;
  final bool isEmail;

  const VerificationScreen({
    super.key,
    required this.contactInfo,
    required this.isEmail,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isResending = false;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      }
    });
  }

  Future<void> _resendCode() async {
    if (_remainingTime > 0) return;

    setState(() {
      _isResending = true;
    });

    // Simuler l'envoi du code
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isResending = false;
        _remainingTime = 60;
      });
      _startTimer();
    }
  }

  void _onCodeCompleted(String code) {
    // TODO: Implémenter la vérification du code
    if (code == '123456') { // Code de test
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vérification réussie !'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Code incorrect'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 80,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Vérification ${widget.isEmail ? "email" : "SMS"}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Un code de vérification a été envoyé à\n${widget.contactInfo}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            VerificationCodeInput(
              onCompleted: _onCodeCompleted,
              length: 6,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: _remainingTime > 0 ? null : _resendCode,
              child: _isResending
                  ? const CircularProgressIndicator()
                  : Text(
                      _remainingTime > 0
                          ? 'Renvoyer le code (${_remainingTime}s)'
                          : 'Renvoyer le code',
                      style: TextStyle(
                        color: _remainingTime > 0
                            ? Colors.grey
                            : AppTheme.primaryColor,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              'Vous n\'avez pas reçu le code ?',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implémenter le support
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Support contacté'),
                  ),
                );
              },
              child: const Text('Contacter le support'),
            ),
          ],
        ),
      ),
    );
  }
}
