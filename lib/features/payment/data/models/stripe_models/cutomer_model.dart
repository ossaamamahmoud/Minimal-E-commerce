class CustomerModel {
  String? id;
  String? object;
  dynamic? address;
  int? balance;
  int? created;
  dynamic? currency;
  dynamic? defaultSource;
  bool? delinquent;
  dynamic? description;
  dynamic? discount;
  String? email;
  String? invoicePrefix;
  InvoiceSettings? invoiceSettings;
  bool? livemode;
  String? name;
  int? nextInvoiceSequence;
  dynamic? phone;
  List<dynamic>? preferredLocales;
  dynamic? shipping;
  String? taxExempt;
  dynamic? testClock;

  CustomerModel(
      {this.id,
      this.object,
      this.address,
      this.balance,
      this.created,
      this.currency,
      this.defaultSource,
      this.delinquent,
      this.description,
      this.discount,
      this.email,
      this.invoicePrefix,
      this.invoiceSettings,
      this.livemode,
      this.name,
      this.nextInvoiceSequence,
      this.phone,
      this.preferredLocales,
      this.shipping,
      this.taxExempt,
      this.testClock});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    address = json['address'];
    balance = json['balance'];
    created = json['created'];
    currency = json['currency'];
    defaultSource = json['default_source'];
    delinquent = json['delinquent'];
    description = json['description'];
    discount = json['discount'];
    email = json['email'];
    invoicePrefix = json['invoice_prefix'];
    invoiceSettings = json['invoice_settings'] != null
        ? new InvoiceSettings.fromJson(json['invoice_settings'])
        : null;
    livemode = json['livemode'];
    name = json['name'];
    nextInvoiceSequence = json['next_invoice_sequence'];
    phone = json['phone'];
    shipping = json['shipping'];
    taxExempt = json['tax_exempt'];
    testClock = json['test_clock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['default_source'] = this.defaultSource;
    data['delinquent'] = this.delinquent;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['email'] = this.email;
    data['invoice_prefix'] = this.invoicePrefix;
    if (this.invoiceSettings != null) {
      data['invoice_settings'] = this.invoiceSettings!.toJson();
    }
    data['livemode'] = this.livemode;
    data['name'] = this.name;
    data['next_invoice_sequence'] = this.nextInvoiceSequence;
    data['phone'] = this.phone;
    data['shipping'] = this.shipping;
    data['tax_exempt'] = this.taxExempt;
    data['test_clock'] = this.testClock;
    return data;
  }
}

class InvoiceSettings {
  dynamic? customFields;
  dynamic? defaultPaymentMethod;
  dynamic? footer;
  dynamic? renderingOptions;

  InvoiceSettings(
      {this.customFields,
      this.defaultPaymentMethod,
      this.footer,
      this.renderingOptions});

  InvoiceSettings.fromJson(Map<String, dynamic> json) {
    customFields = json['custom_fields'];
    defaultPaymentMethod = json['default_payment_method'];
    footer = json['footer'];
    renderingOptions = json['rendering_options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom_fields'] = this.customFields;
    data['default_payment_method'] = this.defaultPaymentMethod;
    data['footer'] = this.footer;
    data['rendering_options'] = this.renderingOptions;
    return data;
  }
}
