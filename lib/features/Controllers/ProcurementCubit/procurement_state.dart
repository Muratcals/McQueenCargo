import 'package:equatable/equatable.dart';

final class ProcurementState extends Equatable {
  int selectedProcurement;
  int selectedDelivery;

  ProcurementState(
    this.selectedProcurement,
    this.selectedDelivery,
  );

  @override
  List<Object?> get props => [selectedProcurement, selectedDelivery];

  ProcurementState copyWith(
      {int selectedProcurement = 0, int selectedDelivery = 0}) {
    return ProcurementState(selectedProcurement, selectedDelivery);
  }
}

final class ProcurementInitial extends ProcurementState {
  ProcurementInitial(super.selectedProcurement, super.selectedDelivery);
}
