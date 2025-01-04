enum BookingStatus {
  pending,    // En attente de confirmation
  confirmed,  // Confirmé par le freelance
  completed,  // Service terminé
  cancelled,  // Annulé
  declined,   // Refusé par le freelance
}

class Booking {
  final String id;
  final String freelancerId;
  final String clientId;
  final DateTime startDate;
  final DateTime endDate;
  final String serviceTitle;
  final String serviceDescription;
  final double amount;
  final BookingStatus status;
  final String? cancellationReason;
  final DateTime createdAt;
  final List<String> requirements;
  final Map<String, dynamic>? additionalDetails;

  const Booking({
    required this.id,
    required this.freelancerId,
    required this.clientId,
    required this.startDate,
    required this.endDate,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.amount,
    required this.status,
    this.cancellationReason,
    required this.createdAt,
    this.requirements = const [],
    this.additionalDetails,
  });

  factory Booking.create({
    required String freelancerId,
    required String clientId,
    required DateTime startDate,
    required DateTime endDate,
    required String serviceTitle,
    required String serviceDescription,
    required double amount,
    List<String> requirements = const [],
    Map<String, dynamic>? additionalDetails,
  }) {
    return Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      freelancerId: freelancerId,
      clientId: clientId,
      startDate: startDate,
      endDate: endDate,
      serviceTitle: serviceTitle,
      serviceDescription: serviceDescription,
      amount: amount,
      status: BookingStatus.pending,
      createdAt: DateTime.now(),
      requirements: requirements,
      additionalDetails: additionalDetails,
    );
  }

  Booking copyWith({
    String? id,
    String? freelancerId,
    String? clientId,
    DateTime? startDate,
    DateTime? endDate,
    String? serviceTitle,
    String? serviceDescription,
    double? amount,
    BookingStatus? status,
    String? cancellationReason,
    DateTime? createdAt,
    List<String>? requirements,
    Map<String, dynamic>? additionalDetails,
  }) {
    return Booking(
      id: id ?? this.id,
      freelancerId: freelancerId ?? this.freelancerId,
      clientId: clientId ?? this.clientId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      requirements: requirements ?? this.requirements,
      additionalDetails: additionalDetails ?? this.additionalDetails,
    );
  }
}
