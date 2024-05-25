import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';

class AdditionalServicePrice{
  
  static final packageProcurementServices = [
    AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
  ];

  static final packageDeliveryServices = [
    AdditionalServiceModel(name: "Adrese Teslimat", price: 24.46),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
  ];

  static final fileProcurementServices = [
    AdditionalServiceModel(name: "Adresten Alım", price: 13.55),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
  ];

  static final fileDeliveryServices = [
    AdditionalServiceModel(name: "Adrese Teslimat", price: 13.48),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
  ];
}