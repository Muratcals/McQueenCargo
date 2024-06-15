import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

part 'get_courier_state.dart';

class GetCourierCubit extends Cubit<GetCourierState> {
  GetCourierCubit() : super(GetCourierInitial(null, null, null));

  void changeValue({
    AddressModel? addressModel,
    ReceiverAddressModel? receiverAddressModel,
    int? selectedDate,
  }) {
    emit(state.copyWith(addressModel, receiverAddressModel, selectedDate));
  }
}
