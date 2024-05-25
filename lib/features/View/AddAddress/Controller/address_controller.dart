import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';

class CustomerAddressController extends Cubit<AddressModel> {
  CustomerAddressController() : super(AddressModel());

  void changeProvinceId(int id) {
    state.copyWith(provinceId: id);
  }

  void changeDistrictId(int id) {
    state.districtId = id;
    emit(state);
  }

  void changebuildingNo(String id) {
    state.buildingNo = id;
    emit(state);
  }

  void changeApartmenNumber(String id) {
    state.apartmentNumber = id;
    emit(state);
  }

  void changeCustomerId(int id) {
    state.customerMobilId = id;
    emit(state);
  }

  void changeDescription(String description) {
    state.copyWith(description: description);
    emit(state);
  }

  void changeFloor(int id) {
    state.floor = id;
    emit(state);
  }

  void changeNeighbourhoodId(int id) {
    state.neighbourhoodId = id;
    emit(state);
  }

  void changeCountryId(int id) {
    state.countryId = id;
    emit(state);
  }

  void changeStreetId(String id) {
    state.street = id;
    emit(state);
  }

  void changeTitle(String title) {
    state.title = title;
    emit(state);
  }
}
