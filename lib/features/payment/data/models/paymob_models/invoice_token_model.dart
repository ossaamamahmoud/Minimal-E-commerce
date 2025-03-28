class InvoiceTokenModel {
  final String? token;

  InvoiceTokenModel({required this.token});

  factory InvoiceTokenModel.fromJson(Map<String, dynamic> json) {
    return InvoiceTokenModel(token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
