class PaymentIntentInputModel {
  final num amount;
  final String currency;

  final String customer;

  PaymentIntentInputModel(
      {required this.amount, required this.currency, required this.customer});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount.toString();
    data['currency'] = this.currency;
    data['customer'] = this.customer;
    return data;
  }
}
