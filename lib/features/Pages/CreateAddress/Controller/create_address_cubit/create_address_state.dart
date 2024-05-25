part of 'create_address_cubit.dart';

final class CreateAddressState extends Equatable {
  AddressModel customerAddress;
  ReceiverAddressModel receiverAddress;
  List<NeighbourhoodModel> neighbourhoodList;

  CreateAddressState(
      {required this.customerAddress,
      required this.receiverAddress,
      required this.neighbourhoodList});
  @override
  List<Object?> get props =>
      [customerAddress, receiverAddress, neighbourhoodList];

  CreateAddressState copyWith({
    AddressModel? customerAddress,
    ReceiverAddressModel? receiverAddress,
    List<NeighbourhoodModel>? neighbourhoodList,
  }) {
    return CreateAddressState(
        customerAddress: customerAddress ?? this.customerAddress,
        neighbourhoodList: neighbourhoodList ?? this.neighbourhoodList,
        receiverAddress: receiverAddress ?? this.receiverAddress);
  }
}

final class CreateAddressInitial extends CreateAddressState {
  CreateAddressInitial({required super.customerAddress, required super.receiverAddress, required super.neighbourhoodList});
}
