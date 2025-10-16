// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobOrder _$PaymobOrderFromJson(Map<String, dynamic> json) => PaymobOrder(
  id: (json['id'] as num).toInt(),
  merchantOrderId: json['merchant_Order_Id'] as String?,
  amountCents: (json['amount_Cents'] as num).toInt(),
);

Map<String, dynamic> _$PaymobOrderToJson(PaymobOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchant_Order_Id': instance.merchantOrderId,
      'amount_Cents': instance.amountCents,
    };

PaymobData _$PaymobDataFromJson(Map<String, dynamic> json) => PaymobData(
  klass: json['klass'] as String?,
  gatewayIntegrationPk: json['gateway_Integration_Pk'] as String?,
  amount: json['amount'] as String?,
  currency: json['currency'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$PaymobDataToJson(PaymobData instance) =>
    <String, dynamic>{
      'klass': instance.klass,
      'gateway_Integration_Pk': instance.gatewayIntegrationPk,
      'amount': instance.amount,
      'currency': instance.currency,
      'message': instance.message,
    };

PaymobTransactionObj _$PaymobTransactionObjFromJson(
  Map<String, dynamic> json,
) => PaymobTransactionObj(
  id: (json['id'] as num).toInt(),
  pending: json['pending'] as bool,
  amountCents: (json['amount_Cents'] as num).toInt(),
  success: json['success'] as bool,
  isAuth: json['is_Auth'] as bool,
  isCapture: json['is_Capture'] as bool,
  isStandalonePayment: json['is_Standalone_Payment'] as bool,
  isVoided: json['is_Voided'] as bool,
  isRefunded: json['is_Refunded'] as bool,
  is3dSecure: json['is_3d_Secure'] as bool,
  integrationId: (json['integration_Id'] as num).toInt(),
  hasParentTransaction: json['has_Parent_Transaction'] as bool,
  profileId: json['profileId'] as String?,
  order: PaymobOrder.fromJson(json['order'] as Map<String, dynamic>),
  createdAt: json['created_At'] as String?,
  currency: json['currency'] as String?,
  data: PaymobData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaymobTransactionObjToJson(
  PaymobTransactionObj instance,
) => <String, dynamic>{
  'id': instance.id,
  'pending': instance.pending,
  'amount_Cents': instance.amountCents,
  'success': instance.success,
  'is_Auth': instance.isAuth,
  'is_Capture': instance.isCapture,
  'is_Standalone_Payment': instance.isStandalonePayment,
  'is_Voided': instance.isVoided,
  'is_Refunded': instance.isRefunded,
  'is_3d_Secure': instance.is3dSecure,
  'integration_Id': instance.integrationId,
  'profileId': instance.profileId,
  'has_Parent_Transaction': instance.hasParentTransaction,
  'order': instance.order,
  'created_At': instance.createdAt,
  'currency': instance.currency,
  'data': instance.data,
};

PaymobCallbackData _$PaymobCallbackDataFromJson(Map<String, dynamic> json) =>
    PaymobCallbackData(
      obj: PaymobTransactionObj.fromJson(json['obj'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PaymobCallbackDataToJson(PaymobCallbackData instance) =>
    <String, dynamic>{'obj': instance.obj, 'type': instance.type};
