class Veri {
  List<CustomerModel> custom;
  int? totalData;
  Veri({required this.custom, this.totalData});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
      totalData: json["Toplam"],
        custom: List<CustomerModel>.from(
            json["Veri"].map((x) => CustomerModel.fromJson(x)),
        ));
  }
}

class CustomerModel {
  int? customerId;
  String? customerName;
  String? email;
  String? tel;
  String? city;
  String? county;
  String? address;
  List<Contact> contact;
  List<Offer> offer;

  CustomerModel(
      {
        this.customerId,
        this.customerName,
      required this.contact,
      this.email,
      this.tel,
      this.city,
      this.county,
      this.address,
      required this.offer});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json["MusteriID"],
      customerName: json["MusteriAdi"],
      email: json["Eposta"],
      tel: json["Telefon"],
      city: json["Telefon"],
      county: json["Telefon"],
      address: json["Adres"],
      contact: List<Contact>.from(
          json["KontakListe"].map((x) => Contact.fromJson(x))),
      offer:
          List<Offer>.from(json["KontakListe"].map((x) => Offer.fromJson(x))),
    );
  }

  Map toJson() {
    return {
      "KontakListe": customerName,
      "KontakListe": contact,
      "Eposta": email,
      "Telefon": tel,
      "Telefon": city,
      "Telefon": county,
      "Adres": address
    };
  }

  static List<CustomerModel> allCategoryList(List<dynamic> list){
    return List<CustomerModel>.from(list.map((e) => CustomerModel.fromJson(e)));
  }
}

class Contact {
  String? contactName;
  String? email;
  String? tel;
  String? department;
  String? birthDay;
  String? address;

  Contact(
      {this.contactName,
      this.email,
      this.tel,
      this.department,
      this.birthDay,
      this.address});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactName: json["KontakAdi"],
      email: json["Email"],
      tel: json["CepTelefonu"],
      department: json["Departman"],
      birthDay: json["DogumTarihiFormatli"],
      address: json["AdresSatiri1"],
    );
  }

  Map toJson() {
    return {
      "KontakListe": contactName,
      "KontakListe": email,
      "Eposta": tel,
      "Telefon": department,
      "Telefon": birthDay,
      "Adres": address
    };
  }
}

class Offer {
  String? comment;
  String? offerState;
  String? offerStateNum;
  String? offerDate;
  String? validityDate;

  Offer({
    this.comment,
    this.offerState,
    this.offerStateNum,
    this.offerDate,
    this.validityDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      comment: json["Aciklama"],
      offerState: json["TeklifDurumuText"],
      offerStateNum: json["TeklifDurumu"],
      offerDate: json["TeklifTarihiFormatli"],
      validityDate: json["GecerlilikTarihiFormatli"],
    );
  }

  Map toJson() {
    return {
      "Aciklama": comment,
      "TeklifDurumuText": offerState,
      "TeklifDurumu": offerStateNum,
      "TeklifTarihiFormatli": offerDate,
      "GecerlilikTarihiFormatli": validityDate,
    };
  }
}
