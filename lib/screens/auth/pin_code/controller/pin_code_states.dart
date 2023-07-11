abstract class PinCodeStates {}

class PinCodeInitialState extends PinCodeStates {}
class ActiveAccFailureState extends PinCodeStates {}
class ActiveAccSuccessState extends PinCodeStates {}
class ResendLoadingState extends PinCodeStates {}
class ResendFailureState extends PinCodeStates {}
class ResendSuccessState extends PinCodeStates {}