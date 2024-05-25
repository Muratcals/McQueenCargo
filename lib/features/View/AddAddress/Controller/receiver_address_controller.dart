import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

class ReceiverAddressController extends Cubit<ReceiverAddressModel> {
  ReceiverAddressController() : super(ReceiverAddressModel());

  void changeProvinceId(int id) {
    state.provinceId = id;
  }

  void changeDistrictId(int id) {
    state.districtId = id;
  }

  void changebuildingNo(String id) {
    state.buildingNo = id;
  }

  void changeApartmenNumber(String id) {
    state.apartmentNumber = id;
  }

  void changeCustomerId(int id) {
    state.customerMobilId = id;
  }

  void changeDescription(String description) {
    state.description = description;
  }

  void changeFloor(int id) {
    state.floor = id;
  }

  void changeNeighbourhoodId(int id) {
    state.neighbourhoodId = id;
  }

  void changeCountryId(int id) {
    state.countryId = id;
  }

  void changeStreetId(String id) {
    state.street = id;
  }

  void changeTitle(String title) {
    state.title = title;
  }

    void changeName(String name) {
    state.nameSurname = name;
  }

    void changeNumberPhone(String numberPhone) {
    state.numberPhone = numberPhone;
  }

    void changeEmail(String eMail) {
    state.email = eMail;
  }
}
