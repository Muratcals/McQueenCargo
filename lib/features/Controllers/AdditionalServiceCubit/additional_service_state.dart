part of 'additional_service_cubit.dart';

sealed class AdditionalServiceState extends Equatable {
  int selectedProcurement;
  int selectedDelivery;

  AdditionalServiceState(this.selectedDelivery,this.selectedProcurement);

  @override
  List<Object> get props => [selectedDelivery, selectedProcurement];
}

final class AdditionalServiceInitial extends AdditionalServiceState {
  AdditionalServiceInitial(super.selectedDelivery, super.selectedProcurement);

}
