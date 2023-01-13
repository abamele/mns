class Veri {
  List<UserModel> custom;

  Veri({required this.custom});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        custom: List<UserModel>.from(
            json["Veri"].map((x) => UserModel.fromJson(x))));
  }
}

class UserModel {
  int? id;
  String? nameSurname;
  String? email;
  String? password;
  String? companyTitle;
  String? birthDay;
  String? phone;
  String? country;
  String? city;
  String? county;
  String? address;
  String? postalCode;
  bool? userType;
  String? website;

  UserModel(
      {this.id,
        this.nameSurname,
      this.email,
      this.password,
      this.companyTitle,
      this.birthDay,
      this.phone,
      this.country,
      this.city,
      this.county,
      this.address,
      this.postalCode,
      this.userType,
      this.website});

  UserModel.fromJson(Map json) {
    id=json["UyeID"];
    nameSurname = json["AdiSoyadi"];
    email = json["KullaniciAdi"];
    password = json["Sifresi"];
    companyTitle = json["FirmaUnvan"];
    birthDay = json["DogumTarihiFormatli"];
    phone = json["GSM"];
    country = json["Ulke"];
    city = json["Sehir"];
    county = json["Ilce"];
    address = json["Adres"];
    postalCode = json["PostaKodu"];
    userType = json["RootAdmin"];
    website = json["WebSitesi"];
  }

  Map toJson() {
    return {
      "UyeID":id,
      "MusteriAdi": nameSurname,
      "Eposta": email,
      "Sifresi": password,
      "FirmaUnvan": companyTitle,
      "DogumTarihiFormatli": birthDay,
      "GSM": phone,
      "Ulke": country,
      "Sehir": city,
      "Ilce": county,
      "Adres": address,
      "PostaKodu": postalCode,
      "RootAdmin": userType,
      "WebSitesi": website,
    };
  }
}
