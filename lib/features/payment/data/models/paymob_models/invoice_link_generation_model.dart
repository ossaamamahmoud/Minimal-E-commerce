class InvoiceLinkGenerationModel {
  int? id;
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  dynamic collector;
  int? amountCents;
  ShippingData? shippingData;
  String? currency;
  bool? isPaymentLocked;
  bool? isReturn;
  bool? isCancel;
  bool? isReturned;
  bool? isCanceled;
  Null? merchantOrderId;
  Null? walletNotification;
  int? paidAmountCents;
  bool? notifyUserWithEmail;
  List<Null>? items;
  String? orderUrl;
  int? commissionFees;
  int? deliveryFeesCents;
  int? deliveryVatCents;
  String? paymentMethod;
  Null? merchantStaffTag;
  String? apiSource;
  String? paymentStatus;
  String? token;
  String? url;

  InvoiceLinkGenerationModel(
      {this.id,
      this.createdAt,
      this.deliveryNeeded,
      this.merchant,
      this.collector,
      this.amountCents,
      this.shippingData,
      this.currency,
      this.isPaymentLocked,
      this.isReturn,
      this.isCancel,
      this.isReturned,
      this.isCanceled,
      this.merchantOrderId,
      this.walletNotification,
      this.paidAmountCents,
      this.notifyUserWithEmail,
      this.items,
      this.orderUrl,
      this.commissionFees,
      this.deliveryFeesCents,
      this.deliveryVatCents,
      this.paymentMethod,
      this.merchantStaffTag,
      this.apiSource,
      this.paymentStatus,
      this.token,
      this.url});

  InvoiceLinkGenerationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    deliveryNeeded = json['delivery_needed'];
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    collector = json['collector'];
    amountCents = json['amount_cents'];
    shippingData = json['shipping_data'] != null
        ? new ShippingData.fromJson(json['shipping_data'])
        : null;
    currency = json['currency'];
    isPaymentLocked = json['is_payment_locked'];
    isReturn = json['is_return'];
    isCancel = json['is_cancel'];
    isReturned = json['is_returned'];
    isCanceled = json['is_canceled'];
    merchantOrderId = json['merchant_order_id'];
    walletNotification = json['wallet_notification'];
    paidAmountCents = json['paid_amount_cents'];
    notifyUserWithEmail = json['notify_user_with_email'];
    orderUrl = json['order_url'];
    commissionFees = json['commission_fees'];
    deliveryFeesCents = json['delivery_fees_cents'];
    deliveryVatCents = json['delivery_vat_cents'];
    paymentMethod = json['payment_method'];
    merchantStaffTag = json['merchant_staff_tag'];
    apiSource = json['api_source'];
    paymentStatus = json['payment_status'];
    token = json['token'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['delivery_needed'] = this.deliveryNeeded;
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['collector'] = this.collector;
    data['amount_cents'] = this.amountCents;
    if (this.shippingData != null) {
      data['shipping_data'] = this.shippingData!.toJson();
    }
    data['currency'] = this.currency;
    data['is_payment_locked'] = this.isPaymentLocked;
    data['is_return'] = this.isReturn;
    data['is_cancel'] = this.isCancel;
    data['is_returned'] = this.isReturned;
    data['is_canceled'] = this.isCanceled;
    data['merchant_order_id'] = this.merchantOrderId;
    data['wallet_notification'] = this.walletNotification;
    data['paid_amount_cents'] = this.paidAmountCents;
    data['notify_user_with_email'] = this.notifyUserWithEmail;
    data['order_url'] = this.orderUrl;
    data['commission_fees'] = this.commissionFees;
    data['delivery_fees_cents'] = this.deliveryFeesCents;
    data['delivery_vat_cents'] = this.deliveryVatCents;
    data['payment_method'] = this.paymentMethod;
    data['merchant_staff_tag'] = this.merchantStaffTag;
    data['api_source'] = this.apiSource;
    data['payment_status'] = this.paymentStatus;
    data['token'] = this.token;
    data['url'] = this.url;
    return data;
  }
}

class Merchant {
  int? id;
  String? createdAt;
  List<String>? phones;
  List<String>? companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;

  Merchant(
      {this.id,
      this.createdAt,
      this.phones,
      this.companyEmails,
      this.companyName,
      this.state,
      this.country,
      this.city,
      this.postalCode,
      this.street});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    phones = json['phones'].cast<String>();
    companyEmails = json['company_emails'].cast<String>();
    companyName = json['company_name'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['phones'] = this.phones;
    data['company_emails'] = this.companyEmails;
    data['company_name'] = this.companyName;
    data['state'] = this.state;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['street'] = this.street;
    return data;
  }
}

class ShippingData {
  int? id;
  String? firstName;
  String? lastName;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? city;
  String? state;
  String? country;
  String? email;
  String? phoneNumber;
  String? postalCode;
  String? extraDescription;
  String? shippingMethod;
  int? orderId;
  int? order;

  ShippingData(
      {this.id,
      this.firstName,
      this.lastName,
      this.street,
      this.building,
      this.floor,
      this.apartment,
      this.city,
      this.state,
      this.country,
      this.email,
      this.phoneNumber,
      this.postalCode,
      this.extraDescription,
      this.shippingMethod,
      this.orderId,
      this.order});

  ShippingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    street = json['street'];
    building = json['building'];
    floor = json['floor'];
    apartment = json['apartment'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    postalCode = json['postal_code'];
    extraDescription = json['extra_description'];
    shippingMethod = json['shipping_method'];
    orderId = json['order_id'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['street'] = this.street;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['apartment'] = this.apartment;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['postal_code'] = this.postalCode;
    data['extra_description'] = this.extraDescription;
    data['shipping_method'] = this.shippingMethod;
    data['order_id'] = this.orderId;
    data['order'] = this.order;
    return data;
  }
}
