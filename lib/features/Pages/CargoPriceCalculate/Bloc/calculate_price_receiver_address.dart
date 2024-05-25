import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

class CalculatePriceReceiverAddressBloc extends Cubit<ReceiverAddressModel?> {
  CalculatePriceReceiverAddressBloc() : super(null);

  void changeAddress(ReceiverAddressModel model) {
    emit(model);
  }
}