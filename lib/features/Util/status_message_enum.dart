enum StaticInformation {
  updatePassword,
  deleteAddress,
  deleteUser,
  createAddress,
  
}

extension ToastMessageContent on StaticInformation {
  String get status {
    switch (this) {
      case StaticInformation.createAddress:
        return "Adres başarıyla oluşturulmuştur";
        case StaticInformation.deleteAddress:
        return "Adresiniz başarıyla silinmiştir";
        case StaticInformation.deleteUser:
        return "Kullanıcı başarılı bir şekilde silinmiştir";
        case StaticInformation.updatePassword:
        return "Şifreniz başarıyla güncellenmiştir";
    }
  }
}
