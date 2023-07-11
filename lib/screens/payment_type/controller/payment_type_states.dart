abstract class PaymentTypeStates {}

class PaymentTypeInitialState extends PaymentTypeStates {}
class PaySuccessState extends PaymentTypeStates {}
class PayFieldState extends PaymentTypeStates {}
class PayLoadingState extends PaymentTypeStates {}
class PayLoadingOnlineState extends PaymentTypeStates {}
class GetProfileErrorState extends PaymentTypeStates {}
class GetProfileSuccessState extends PaymentTypeStates {}