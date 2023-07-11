abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}
class ChangeDropDown extends RegisterStates {}
class ChangeCheck extends RegisterStates {}
class CitiesLoadingState extends RegisterStates {}
class CitiesErrorState extends RegisterStates {}
class CitiesSuccessState extends RegisterStates {}
class ConfirmRegisterSuccessState extends RegisterStates {}
class ConfirmRegisterFailureState extends RegisterStates {}
class ConfirmRegisterLoadingState extends RegisterStates {}