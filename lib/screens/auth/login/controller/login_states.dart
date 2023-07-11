abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginFailureState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class GetPhoneCompleteState extends LoginStates {}