import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';

class CalculatePriceCustomerAddressBloc extends Cubit<AddressModel?> {
  CalculatePriceCustomerAddressBloc() : super(null);

  void changeAddress(AddressModel model) {
    emit(model);
  }
}
