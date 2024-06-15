import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';

class CreteCustomerState extends Cubit<LoginModel> {
  CreteCustomerState() : super(LoginModel());

  void changeValue({
    String? name,
    String? surname,
    String? tcNo,
    String? numberPhone,
    String? password,
    String? email,
    DateTime? birthDate,
  }) {
    var newValue = state.copyWith(
        name: name,
        surname: surname,
        email: email,
        tcNo: tcNo,
        numberPhone: numberPhone,
        password: password,
        birthDate: birthDate);
    emit(newValue);
  }
}
