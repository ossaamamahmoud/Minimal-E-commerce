abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {
  PaymentSuccessState();
}

class PaymentErrorState extends PaymentState {
  final String error;

  PaymentErrorState({required this.error});
}
