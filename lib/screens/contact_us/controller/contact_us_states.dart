abstract class ContactUsStates {}

class ContactUsInitialState extends ContactUsStates {}
class GetContactLoadingState extends ContactUsStates {}
class GetContactErrorState extends ContactUsStates {}
class GetContactSuccessState extends ContactUsStates {}
class ContactStoreFailureState extends ContactUsStates {}
class ContactStoreSuccessState extends ContactUsStates {}
class ContactStoreLoadingState extends ContactUsStates {}