enum PaymentMethodType {
  orangeMoney,
  mtnMoney,
  moovMoney,
}

class PaymentMethod {
  final PaymentMethodType type;
  final String name;
  final String logo;
  final String description;
  final String channel;

  const PaymentMethod({
    required this.type,
    required this.name,
    required this.logo,
    required this.description,
    required this.channel,
  });

  static List<PaymentMethod> get availableMethods => [
    PaymentMethod(
      type: PaymentMethodType.orangeMoney,
      name: 'Orange Money',
      logo: 'assets/images/orange_money.png',
      description: 'Payer avec Orange Money',
      channel: 'ORANGE',
    ),
    PaymentMethod(
      type: PaymentMethodType.mtnMoney,
      name: 'MTN Mobile Money',
      logo: 'assets/images/mtn_money.png',
      description: 'Payer avec MTN Mobile Money',
      channel: 'MTN',
    ),
    PaymentMethod(
      type: PaymentMethodType.moovMoney,
      name: 'Moov Money',
      logo: 'assets/images/moov_money.png',
      description: 'Payer avec Moov Money',
      channel: 'MOOV',
    ),
  ];
}
