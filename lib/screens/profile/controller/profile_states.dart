abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}
class GetProfileErrorState extends ProfileStates {}
class GetProfileSuccessState extends ProfileStates {}
class ProfileLoadingState extends ProfileStates {}