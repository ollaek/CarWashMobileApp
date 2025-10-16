import 'package:json_annotation/json_annotation.dart';

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






