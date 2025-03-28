class InvoiceLinkGenerationInputModel {
  final String? authToken;
  final String? apiSource;
  final String? amountCents;
  final String? currency;
  final List<int>? integrations;
  final ShippingInputData? shippingData;

  InvoiceLinkGenerationInputModel(
      {required this.authToken,
      required this.apiSource,
      required this.amountCents,
      required this.currency,
      required this.integrations,
      required this.shippingData});

  factory InvoiceLinkGenerationInputModel.fromJson(Map<String, dynamic> json) {
    return InvoiceLinkGenerationInputModel(
      authToken: json['auth_token'],
      apiSource: json['api_source'],
      amountCents: json['amount_cents'],
      currency: json['currency'],
      integrations: json['integrations'],
      shippingData: json['shipping_data'] != null
          ? ShippingInputData.fromJson(json['shipping_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['api_source'] = this.apiSource;
    data['amount_cents'] = this.amountCents;
    data['currency'] = this.currency;
    data['integrations'] = this.integrations;
    if (this.shippingData != null) {
      data['shipping_data'] = this.shippingData!.toJson();
    }
    return data;
  }
}

class ShippingInputData {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;

  ShippingInputData(
      {this.firstName, this.lastName, this.phoneNumber, this.email});

  ShippingInputData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
