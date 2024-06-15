part of 'get_courier_cubit.dart';

final class GetCourierState extends Equatable {
  AddressModel? customerAddress;
  ReceiverAddressModel? receiverAddress;
  int? selectedDate;

  GetCourierState(
      this.customerAddress, this.receiverAddress, this.selectedDate);

  @override
  List<Object?> get props => [customerAddress, receiverAddress, selectedDate];

  GetCourierState copyWith(
    AddressModel? customerAddress,
    ReceiverAddressModel? receiverAddress,
    int? selectedDate,
  ) {
    return GetCourierState(
        customerAddress ?? this.customerAddress,
        receiverAddress ?? this.receiverAddress,
        selectedDate ?? this.selectedDate);
  }
}

final class GetCourierInitial extends GetCourierState {
  GetCourierInitial(
      super.customerAddress, super.receiverAddress, super.selectedDate);
}
