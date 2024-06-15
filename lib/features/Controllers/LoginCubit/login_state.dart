part of 'login_cubit.dart';

class LoginState extends Equatable {
  String userName;
  String password;

  LoginState(this.userName, this.password);

  @override
  List<Object> get props => [userName, password];

  LoginState copyWith({String? userName, String? password}) {
    return LoginState(userName ?? this.userName, password ?? this.password);
  }
}

final class LoginInitial extends LoginState {
  LoginInitial(super.userName, super.password);
}
