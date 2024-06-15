
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

part 'create_address_state.dart';

class CreateAddressCubit extends Cubit<CreateAddressState> {
  CreateAddressCubit()
      : super(CreateAddressInitial(
            customerAddress: AddressModel(),
            neighbourhoodList:const [],
            receiverAddress: ReceiverAddressModel()));

  void changeCustomerAddress({
    int? countryId,
    String? countryName,
    int? provinceId,
    String? provinceName,
    int? districtId,
    String? districtName,
    int? neighbourhoodId,
    String? neighbourhoodName,
    String? street,
    String? buildingNo,
    int? floor,
    String? apartmentNumber,
    String? title,
    String? description,
    int? customerMobilId,
  }) {
    var newState = state.customerAddress.copyWith(
        countryId: countryId,
        countryName: countryName,
        provinceId: provinceId,
        provinceName: provinceName,
        districtId: districtId,
        districtName: districtName,
        neighbourhoodId: neighbourhoodId,
        neighbourhoodName: neighbourhoodName,
        street: street,
        buildingNo: buildingNo,
        floor: floor,
        apartmentNumber: apartmentNumber,
        title: title,
        description: description,
        customerMobilId: customerMobilId);
    emit(state.copyWith(customerAddress: newState));
  }

  void changeReceiverAddress({
    String? nameSurname,
    String? email,
    String? numberPhone,
    int? countryId,
    String? countryName,
    int? provinceId,
    String? provinceName,
    int? districtId,
    String? districtName,
    int? neighbourhoodId,
    String? neighbourhoodName,
    String? street,
    String? buildingNo,
    int? floor,
    String? apartmentNumber,
    String? title,
    String? description,
    int? customerMobilId,
  }) {
    var newState = state.receiverAddress.copyWith(
        nameSurname: nameSurname,
        email: email,
        numberPhone: numberPhone,
        countryId: countryId,
        countryName: countryName,
        provinceId: provinceId,
        provinceName: provinceName,
        districtId: districtId,
        districtName: districtName,
        neighbourhoodId: neighbourhoodId,
        neighbourhoodName: neighbourhoodName,
        street: street,
        buildingNo: buildingNo,
        floor: floor,
        apartmentNumber: apartmentNumber,
        title: title,
        description: description,
        customerMobilId: customerMobilId);
    emit(state.copyWith(receiverAddress: newState));
  }

  void changeList(List<NeighbourhoodModel> model) {
    emit(state.copyWith(neighbourhoodList: model));
  }
}
