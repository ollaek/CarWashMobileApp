import 'package:json_annotation/json_annotation.dart';

part 'payment_models.g.dart';

@JsonSerializable()
class PaymobOrder {
  PaymobOrder({
    required this.id,
    this.merchantOrderId,
    required this.amountCents,
  });

  final int id;
  @JsonKey(name: 'merchant_Order_Id')
  final String? merchantOrderId;
  @JsonKey(name: 'amount_Cents')
  final int amountCents;

  factory PaymobOrder.fromJson(Map<String, dynamic> json) =>
      _$PaymobOrderFromJson(json);
  Map<String, dynamic> toJson() => _$PaymobOrderToJson(this);
}

@JsonSerializable()
class PaymobData {
  PaymobData({
    this.klass,
    this.gatewayIntegrationPk,
    this.amount,
    this.currency,
    this.message,
  });

  final String? klass;
  @JsonKey(name: 'gateway_Integration_Pk')
  final String? gatewayIntegrationPk;
  final String? amount;
  final String? currency;
  final String? message;

  factory PaymobData.fromJson(Map<String, dynamic> json) =>
      _$PaymobDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaymobDataToJson(this);
}

@JsonSerializable()
class PaymobTransactionObj {
  PaymobTransactionObj({
    required this.id,
    required this.pending,
    required this.amountCents,
    required this.success,
    required this.isAuth,
    required this.isCapture,
    required this.isStandalonePayment,
    required this.isVoided,
    required this.isRefunded,
    required this.is3dSecure,
    required this.integrationId,
    required this.hasParentTransaction,
    this.profileId,
    required this.order,
    this.createdAt,
    this.currency,
    required this.data,
  });

  final int id;
  final bool pending;
  @JsonKey(name: 'amount_Cents')
  final int amountCents;
  final bool success;
  @JsonKey(name: 'is_Auth')
  final bool isAuth;
  @JsonKey(name: 'is_Capture')
  final bool isCapture;
  @JsonKey(name: 'is_Standalone_Payment')
  final bool isStandalonePayment;
  @JsonKey(name: 'is_Voided')
  final bool isVoided;
  @JsonKey(name: 'is_Refunded')
  final bool isRefunded;
  @JsonKey(name: 'is_3d_Secure')
  final bool is3dSecure;
  @JsonKey(name: 'integration_Id')
  final int integrationId;
  final String? profileId;
  @JsonKey(name: 'has_Parent_Transaction')
  final bool hasParentTransaction;
  final PaymobOrder order;
  @JsonKey(name: 'created_At')
  final String? createdAt;
  final String? currency;
  final PaymobData data;

  factory PaymobTransactionObj.fromJson(Map<String, dynamic> json) =>
      _$PaymobTransactionObjFromJson(json);
  Map<String, dynamic> toJson() => _$PaymobTransactionObjToJson(this);
}

@JsonSerializable()
class PaymobCallbackData {
  PaymobCallbackData({required this.obj, this.type});
  final PaymobTransactionObj obj;
  final String? type;
  factory PaymobCallbackData.fromJson(Map<String, dynamic> json) =>
      _$PaymobCallbackDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaymobCallbackDataToJson(this);
}





