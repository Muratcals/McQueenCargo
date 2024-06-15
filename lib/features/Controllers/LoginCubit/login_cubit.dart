import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial("", ""));

  void changeState({String? userName, String? password}) {
    emit(LoginState(userName ?? state.userName, password ?? state.password));
  }
}
