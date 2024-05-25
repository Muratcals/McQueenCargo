import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';

class GetCourierPostCubit extends Cubit<PostCourierModel> {
  GetCourierPostCubit() : super(PostCourierModel());

  void clearModel() {
    emit(PostCourierModel());
  }

  void changeCustomerMobilId(int id) {
    state.copyWith(customerMobilId: id);
    emit(state);
  }

  void changeCustomerMobilAdressId(int id) {
    state.customerMobilAdressId = id;
    emit(state);
  }

  void changeReceiverId(int id) {
    state.receiverId = id;
    emit(state);
  }

  void changePaymentTypeId(int id) {
    state.paymentTypeId = id;
    emit(state);
  }

  void changeCargoParcelTypeId(int id) {
    state.cargoParcelTypeId = id;
    emit(state);
  }

  void changeCargoTransportationConditionsId(int id) {
    state.cargoTransportationConditionsId = id;
    emit(state);
  }

  void changeCargoTypeId(int id) {
    state.cargoTypeId = id;
    emit(state);
  }

  void changeCargoDesi(double id) {
    state.cargoDesi = id;
    emit(state);
  }

  void changeCargoRealeseDate(DateTime id) {
    state.cargoRealeseDate = id;
    emit(state);
  }

  void changePrice(double id) {
    state.price = id;
    emit(state);
  }

  void changeCallCourierOk(bool id) {
    state.callCourierOk = id;
    emit(state);
  }
}
