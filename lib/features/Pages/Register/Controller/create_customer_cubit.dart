import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';

class CreteCustomerState extends Cubit<LoginModel> {
  CreteCustomerState() : super(LoginModel());

  void changeName(String name) {
    state.name = name;
  }

  void changeSurname(String surname) {
    state.surname = surname;
  }
  void changeTcNo(String tcNo) {
    state.tcNo = tcNo;
  }

  void changeNumberPhone(String numberPhone) {
    state.numberPhone = numberPhone;
  }

  void changePassword(String password) {
    state.password = password;
  }

  void changeEmail(String email) {
    state.email = email;
  }

  void changeBirthDate(DateTime birthDate) {
    state.birthDate = birthDate;
  }
}
