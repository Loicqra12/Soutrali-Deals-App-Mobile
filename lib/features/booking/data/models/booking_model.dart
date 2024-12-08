import 'package:equatable/equatable.dart';

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
  disputed,
}

class BookingModel extends Equatable {
  final String id;
  final String serviceId;
  final String customerId;
  final String providerId;
  final DateTime bookingDate;
  final DateTime serviceDate;
  final String? address;
  final String? notes;
  final double amount;
  final BookingStatus status;
  final String? paymentId;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BookingModel({
    required this.id,
    required this.serviceId,
    required this.customerId,
    required this.providerId,
    required this.bookingDate,
    required this.serviceDate,
    this.address,
    this.notes,
    required this.amount,
    this.status = BookingStatus.pending,
    this.paymentId,
    this.isPaid = false,
    required this.createdAt,
    this.updatedAt,
  });

  BookingModel copyWith({
    DateTime? serviceDate,
    String? address,
    String? notes,
    double? amount,
    BookingStatus? status,
    String? paymentId,
    bool? isPaid,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id,
      serviceId: serviceId,
      customerId: customerId,
      providerId: providerId,
      bookingDate: bookingDate,
      serviceDate: serviceDate ?? this.serviceDate,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paymentId: paymentId ?? this.paymentId,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'customerId': customerId,
      'providerId': providerId,
      'bookingDate': bookingDate.toIso8601String(),
      'serviceDate': serviceDate.toIso8601String(),
      'address': address,
      'notes': notes,
      'amount': amount,
      'status': status.toString(),
      'paymentId': paymentId,
      'isPaid': isPaid,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      serviceId: json['serviceId'],
      customerId: json['customerId'],
      providerId: json['providerId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      serviceDate: DateTime.parse(json['serviceDate']),
      address: json['address'],
      notes: json['notes'],
      amount: json['amount'].toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      paymentId: json['paymentId'],
      isPaid: json['isPaid'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        serviceId,
        customerId,
        providerId,
        bookingDate,
        serviceDate,
        address,
        notes,
        amount,
        status,
        paymentId,
        isPaid,
        createdAt,
        updatedAt,
      ];
}
