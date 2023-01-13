class Veri {
  List<OfferModel> offer;
  int? totalData;
  Veri({required this.offer, this.totalData});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        totalData: json["Toplam"],
        offer: List<OfferModel>.from(
          json["Veri"].map((x) => OfferModel.fromJson(x)),
        ));
  }
}

class OfferModel {
  int? offerId;
  String? offerNo;
  String? customerName;
  String? offerDate;
  String? validityDate;
  int? offerStateNum;
  String? offerStatetxt;
  String? comment;
  List<Contact> contact;
  List<Product> product;

  OfferModel(
      {
        this.offerId,
        this.offerNo,
        this.customerName,
        this.offerDate,
        this.validityDate,
        this.offerStateNum,
        this.offerStatetxt,
        this.comment,
        required this.contact,
        required this.product});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      offerId: json["TeklifID"],
      offerNo: json["TeklifNo"],
      customerName: json["MusteriAdi"],
      offerDate: json["TeklifTarihiFormatli"],
      validityDate: json["GecerlilikTarihiFormatli"],
      offerStateNum: json["TeklifinDurumu"],
      offerStatetxt: json["TeklifDurumuText"],
      comment: json["Aciklama"],
      contact: List<Contact>.from(
          json["TeklifYetkilileri"].map((x) => Contact.fromJson(x))),
      product:
      List<Product>.from(json["Sepet"].map((x) => Product.fromJson(x))),
    );
  }

  Map toJson() {
    return {
      "TeklifID": offerId,
      "TeklifNo": offerNo,
      "MusteriAdi": offerStateNum,
      "TeklifTarihiFormatli": offerStatetxt,

    };
  }

  static List<OfferModel> allCategoryList(List<dynamic> list){
    return List<OfferModel>.from(list.map((e) => OfferModel.fromJson(e)));
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

class Product {
  String? model;
  double? price;
  double? quantity;
  double? totalPrice;

  Product({
    this.model,
    this.price,
    this.quantity,
    this.totalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      model: json["Model"],
      price: json["BirimFiyat"],
      quantity: json["Miktar"],
      totalPrice: json["AraToplam"],
    );
  }

  Map toJson() {
    return {
      "Model": model,
      "BirimFiyat": price,
      "Miktar": quantity,
      "AraToplam": totalPrice,
    };
  }
}
