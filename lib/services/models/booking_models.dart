import 'package:json_annotation/json_annotation.dart';
import 'package:glint/services/models/service_vehicle_models.dart';
import 'package:glint/services/models/address_models.dart';
import 'package:glint/services/models/payment_card_models.dart';

part 'booking_models.g.dart';

enum PaymentMethod { method1, method2, method3 }

@JsonSerializable()
class CreateBookingRequest {
  CreateBookingRequest({
    required this.serviceId,
    required this.vehicleId,
    required this.addressId,
    required this.scheduledDateTime,
    required this.paymentMethod,
    this.paymentCardId,
    this.promocodeCode,
    this.notes,
  });

  final int serviceId;
  final int vehicleId;
  final int addressId;
  final String scheduledDateTime;
  final PaymentMethod paymentMethod;
  final int? paymentCardId;
  final String? promocodeCode;
  final String? notes;

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBookingRequestToJson(this);
}

@JsonSerializable()
class CancelBookingRequest {
  CancelBookingRequest({this.reason});
  final String? reason;
  factory CancelBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CancelBookingRequestToJson(this);
}

@JsonSerializable()
class Booking {
  Booking({
    this.id,
    this.serviceId,
    this.vehicleId,
    this.addressId,
    this.scheduledDateTime,
    this.status,
    this.paymentMethod,
    this.paymentCardId,
    this.promocodeCode,
    this.notes,
    this.basePrice,
    this.discountAmount,
    this.finalPrice,
    this.service,
    this.vehicle,
    this.address,
    this.paymentCard,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? serviceId;
  final int? vehicleId;
  final int? addressId;
  final DateTime? scheduledDateTime;
  final String? status;
  final String? paymentMethod;
  final int? paymentCardId;
  final String? promocodeCode;
  final String? notes;
  final double? basePrice;
  final double? discountAmount;
  final double? finalPrice;
  final CarWashService? service;
  final Vehicle? vehicle;
  final Address? address;
  final PaymentCard? paymentCard;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}











