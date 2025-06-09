# 📦 McQueenCargo – Gönderici Uygulaması

**McQueenCargo**, McQueenCargo sisteminin gönderici (müşteri) tarafında çalışan mobil uygulamasıdır. Kullanıcılar bu uygulama sayesinde evlerinden çıkmadan kargo gönderme işlemlerini gerçekleştirebilir, fiyat hesaplaması yapabilir ve kurye çağırabilir.

---

## 🚀 Özellikler

### 📦 Kargo Gönderimi Oluşturma  
Alıcı adresi, açıklama ve paket bilgileri girilerek hızlıca gönderi talebi oluşturulabilir.

### 📍 Kurye Çağırma  
Kargo alınacak adresi belirterek, kuryeyi doğrudan eve ya da ofise çağırabilirsiniz.

### 💰 Fiyat Hesaplama  
Gönderi oluşturma ekranında paket türüne ve teslimat adresine göre ücret otomatik olarak hesaplanır ve gösterilir.

### 🔔 Anlık Bildirimler  
Kurye ataması, gönderi alımı ve diğer önemli adımlar hakkında kullanıcıya bildirim gönderilir.

### 💳 Ödeme İşlemleri  
Gönderi ücreti uygulama içinden güvenli bir şekilde ödenebilir.

### 📜 Gönderi Geçmişi  
Önceden yapılmış tüm gönderiler geçmiş listesinde detaylarıyla birlikte görüntülenebilir.

### 👤 Profil ve Adres Yönetimi  
Kullanıcı bilgileri ve sık kullanılan adresler kayıt altına alınabilir ve düzenlenebilir.

---

## 🛠️ Kullanılan Teknolojiler

- **Flutter** – Mobil uygulama geliştirme
- **Firebase** – Kimlik doğrulama, veritabanı, bildirim sistemi
- **State Management** – GetX kullanılarak state management kullanımı 

---

## 📦 Karşılıklı Entegrasyon

Bu uygulama, kargo teslimat tarafındaki kurye uygulaması olan [McQueenCourier](https://github.com/Muratcals/McQueenCourier) ile entegre çalışmaktadır. Gönderilen kargolar, kurye uygulaması üzerinden teslim alınır ve sistem otomatik senkronize şekilde ilerler.

---

## 🚀 Uygulamayı Başlatma

1. Bu projeyi klonlayın:
   ```bash
   git clone https://github.com/Muratcals/McQueenCargo.git
