import 'package:flutter/material.dart';
import '../../../../core/theme.dart';

class RegistrationStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegistrationStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalSteps,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: index < currentStep ? AppTheme.primaryColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Étape $currentStep sur $totalSteps',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
