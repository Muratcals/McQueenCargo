import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Model/response_error_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorResponse {
  // StreamController oluştur
  static final streamController =
      StreamController<ResponseErrorModel>.broadcast();

  static Stream<ResponseErrorModel> get stream =>
      streamController.stream.asBroadcastStream();

  // Stream'i dinleyen fonksiyon
  static void responseErrorDialog(
      BuildContext context, ResponseErrorModel statusModel) {
    showDialog(
      context: context,
      builder: (context) {
        ResponseErrorModel model = convertStatusCode(statusModel);
        return Center(
          child: Container(
            width: double.infinity,
            height: (Get.height * 30) / 100,
            margin: CustomPadding.onlyHorizontalInset(20),
            color: Colors.white,
            child: PopScope(
              canPop: false,
              child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: const AppbarFlexibleSpace(),
                  leading: Container(),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                  centerTitle: true,
                  title: GeneralTextWidget(
                      title: model.statusTitle ?? "",
                      fontsize: 14.sp,
                      color: Colors.white),
                ),
                body: Center(
                  child: Container(
                    padding: CustomPadding.onlyHorizontalInset(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.statusMessage ?? "",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.sp),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          margin: CustomPadding.onlyHorizontalInset(50),
                          height: 25.h,
                          child: AtomicOrangeButton(
                              onPressed: () {
                                if (model.statusCode == HttpStatus.forbidden ||
                                    model.statusCode ==
                                        HttpStatus.internalServerError) {
                                  Restart.restartApp();
                                } else {
                                  Get.back();
                                }
                              },
                              title: model.statusCode == HttpStatus.forbidden ||
                                      (model.statusCode ==
                                                  HttpStatus.notFound &&
                                              model.incoming == "Customer" ||
                                          model.statusCode ==
                                              HttpStatus.internalServerError)
                                  ? "Yeniden Başlat"
                                  : "Kapat"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static ResponseErrorModel convertStatusCode(ResponseErrorModel model) {
    if (model.statusCode == HttpStatus.badRequest) {
      return ResponseErrorModel(
          statusMessage:
              "Sunucu isteğinizi anlayamadı. Lütfen verileri düzgün doldurunuz",
          statusTitle: "Geçersiz istek");
    } else if (model.statusCode == HttpStatus.unauthorized) {
      return ResponseErrorModel(
          statusMessage: "Kullanıcı adı veya şifre yalnış",
          statusTitle: "Hatalı Giriş");
    } else if (model.statusCode == HttpStatus.forbidden) {
      return ResponseErrorModel(
          statusMessage:
              "Bu sayfaya erişim izniniz yok. Lütfen yöneticiye başvurun",
          statusTitle: "Erişim engellendi");
    } else if (model.statusCode == HttpStatus.notFound) {
      if (model.incoming == "Cargo") {
        model.statusMessage =
            "Girdiğiniz takip numarası ile bir kargo bulunamadı.";
        model.statusTitle = "Bir hata oluştu";
      } else if (model.incoming == "Customer") {
        model.statusMessage = "Kullanıcı bulunamadı";
        model.statusTitle = "Bir hata oluştu";
        _deleteCustomer();
      } else if (model.incoming == "Login") {
        model.statusMessage = "Kullanıcı adı veya şifre hatalı";
        model.statusTitle = "Hatalı giriş";
      }
      return model;
    } else if (model.statusCode == HttpStatus.requestTimeout) {
      return ResponseErrorModel(
          statusMessage:
              "Sunucu isteği beklerken bir sorun oluştu. Lütfen tekrar deneyin",
          statusTitle: "İstek zaman aşımına uğradı");
    } else if (model.statusCode == HttpStatus.conflict) {
      return ResponseErrorModel(
          statusMessage: "Girilen bilgiler daha önce kullanılmış.",
          statusTitle: "Bir hata oluştu");
    } else if (model.statusCode == HttpStatus.internalServerError) {
      return ResponseErrorModel(
          statusMessage:
              "Bir şeyler ters gitti. Lütfen daha sonra tekrar deneyin. Sorun devam ederse sistem yöneticinize başvurun",
          statusTitle: "Sunucu hatası");
    } else if (model.statusCode == HttpStatus.badGateway) {
      return ResponseErrorModel(
          statusMessage:
              "Sunucu bir hata ile karşılaştı. Lütfen bir süre sonra tekrar deneyin.",
          statusTitle: "Kötü ağ gecidi");
    } else if (model.statusCode == HttpStatus.serviceUnavailable) {
      return ResponseErrorModel(
          statusMessage:
              "Sunucu şu anda talebinizi işleyemiyor. Lütfen daha sonra tekrar deneyin.",
          statusTitle: "Hizmet şuanda kullanılamıyor");
    } else if (model.statusCode == HttpStatus.gatewayTimeout) {
      return ResponseErrorModel(
          statusMessage:
              "Sunucu, başka bir sunucudan zamanında yanıt alamadı. Lütfen tekrar deneyin",
          statusTitle: "Zaman aşımı");
    } else {
      return ResponseErrorModel(
          statusMessage: "Birşeyler ters gitti.",
          statusTitle: "Bir sorun oluştu");
    }
  }

  static Future<void> _deleteCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", 0);
  }
}
