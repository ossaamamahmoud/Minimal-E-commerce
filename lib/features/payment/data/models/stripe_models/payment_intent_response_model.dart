class PaymentIntentResponseModel {
  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  int? amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  AutomaticPaymentMethods? automaticPaymentMethods;
  dynamic canceledAt;
  dynamic cancellationReason;
  String? captureMethod;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  dynamic customer;
  dynamic description;
  dynamic invoice;
  dynamic lastPaymentError;
  dynamic latestCharge;
  bool? livemode;
  dynamic nextAction;
  dynamic onBehalfOf;
  dynamic paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic processing;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  dynamic transferGroup;

  PaymentIntentResponseModel(
      {this.id,
      this.object,
      this.amount,
      this.amountCapturable,
      this.amountReceived,
      this.application,
      this.applicationFeeAmount,
      this.automaticPaymentMethods,
      this.canceledAt,
      this.cancellationReason,
      this.captureMethod,
      this.clientSecret,
      this.confirmationMethod,
      this.created,
      this.currency,
      this.customer,
      this.description,
      this.invoice,
      this.lastPaymentError,
      this.latestCharge,
      this.livemode,
      this.nextAction,
      this.onBehalfOf,
      this.paymentMethod,
      this.paymentMethodOptions,
      this.paymentMethodTypes,
      this.processing,
      this.receiptEmail,
      this.review,
      this.setupFutureUsage,
      this.shipping,
      this.source,
      this.statementDescriptor,
      this.statementDescriptorSuffix,
      this.status,
      this.transferData,
      this.transferGroup});

  PaymentIntentResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    amount = json['amount'];
    amountCapturable = json['amount_capturable'];
    amountReceived = json['amount_received'];
    application = json['application'];
    applicationFeeAmount = json['application_fee_amount'];
    automaticPaymentMethods = json['automatic_payment_methods'] != null
        ? new AutomaticPaymentMethods.fromJson(
            json['automatic_payment_methods'])
        : null;
    canceledAt = json['canceled_at'];
    cancellationReason = json['cancellation_reason'];
    captureMethod = json['capture_method'];
    clientSecret = json['client_secret'];
    confirmationMethod = json['confirmation_method'];
    created = json['created'];
    currency = json['currency'];
    customer = json['customer'];
    description = json['description'];
    invoice = json['invoice'];
    lastPaymentError = json['last_payment_error'];
    latestCharge = json['latest_charge'];
    livemode = json['livemode'];
    nextAction = json['next_action'];
    onBehalfOf = json['on_behalf_of'];
    paymentMethod = json['payment_method'];
    paymentMethodOptions = json['payment_method_options'] != null
        ? new PaymentMethodOptions.fromJson(json['payment_method_options'])
        : null;
    paymentMethodTypes = json['payment_method_types'].cast<String>();
    processing = json['processing'];
    receiptEmail = json['receipt_email'];
    review = json['review'];
    setupFutureUsage = json['setup_future_usage'];
    shipping = json['shipping'];
    source = json['source'];
    statementDescriptor = json['statement_descriptor'];
    statementDescriptorSuffix = json['statement_descriptor_suffix'];
    status = json['status'];
    transferData = json['transfer_data'];
    transferGroup = json['transfer_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['amount'] = this.amount;
    data['amount_capturable'] = this.amountCapturable;
    data['amount_received'] = this.amountReceived;
    data['application'] = this.application;
    data['application_fee_amount'] = this.applicationFeeAmount;
    if (this.automaticPaymentMethods != null) {
      data['automatic_payment_methods'] =
          this.automaticPaymentMethods!.toJson();
    }
    data['canceled_at'] = this.canceledAt;
    data['cancellation_reason'] = this.cancellationReason;
    data['capture_method'] = this.captureMethod;
    data['client_secret'] = this.clientSecret;
    data['confirmation_method'] = this.confirmationMethod;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['customer'] = this.customer;
    data['description'] = this.description;
    data['invoice'] = this.invoice;
    data['last_payment_error'] = this.lastPaymentError;
    data['latest_charge'] = this.latestCharge;
    data['livemode'] = this.livemode;
    data['next_action'] = this.nextAction;
    data['on_behalf_of'] = this.onBehalfOf;
    data['payment_method'] = this.paymentMethod;
    if (this.paymentMethodOptions != null) {
      data['payment_method_options'] = this.paymentMethodOptions!.toJson();
    }
    data['payment_method_types'] = this.paymentMethodTypes;
    data['processing'] = this.processing;
    data['receipt_email'] = this.receiptEmail;
    data['review'] = this.review;
    data['setup_future_usage'] = this.setupFutureUsage;
    data['shipping'] = this.shipping;
    data['source'] = this.source;
    data['statement_descriptor'] = this.statementDescriptor;
    data['statement_descriptor_suffix'] = this.statementDescriptorSuffix;
    data['status'] = this.status;
    data['transfer_data'] = this.transferData;
    data['transfer_group'] = this.transferGroup;
    return data;
  }
}

class AutomaticPaymentMethods {
  bool? enabled;

  AutomaticPaymentMethods({this.enabled});

  AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    return data;
  }
}

class PaymentMethodOptions {
  Card? card;
  Link? link;

  PaymentMethodOptions({this.card, this.link});

  PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Card {
  dynamic installments;
  dynamic mandateOptions;
  dynamic network;
  String? requestThreeDSecure;

  Card(
      {this.installments,
      this.mandateOptions,
      this.network,
      this.requestThreeDSecure});

  Card.fromJson(Map<String, dynamic> json) {
    installments = json['installments'];
    mandateOptions = json['mandate_options'];
    network = json['network'];
    requestThreeDSecure = json['request_three_d_secure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installments'] = this.installments;
    data['mandate_options'] = this.mandateOptions;
    data['network'] = this.network;
    data['request_three_d_secure'] = this.requestThreeDSecure;
    return data;
  }
}

class Link {
  dynamic persistentToken;

  Link({this.persistentToken});

  Link.fromJson(Map<String, dynamic> json) {
    persistentToken = json['persistent_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['persistent_token'] = this.persistentToken;
    return data;
  }
}
