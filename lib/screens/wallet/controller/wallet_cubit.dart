import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/screens/wallet/controller/wallet_states.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(WalletInitialState());

  static WalletCubit get(context) => BlocProvider.of(context);

}