// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseErrorModel {
  int? statusCode;
  String? statusTitle;
  String? statusMessage;
  String? incoming;

  ResponseErrorModel(
      {this.statusCode,this.statusTitle,this.statusMessage, this.incoming});
}
