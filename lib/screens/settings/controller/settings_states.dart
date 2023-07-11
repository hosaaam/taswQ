abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}
class ChangeNotify extends SettingsStates {}
class DeleteAccLoadingState extends SettingsStates {}
class DeleteAccErrorState extends SettingsStates {}
class DeleteAccSuccessState extends SettingsStates {}
class ChangeNotifyErrorState extends SettingsStates {}
class ChangeNotifySuccessState extends SettingsStates {}