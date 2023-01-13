class CurrencyModel {
  int? id;
  double? currency;
  String? price;
  String? createdDate;
  String? persCreated;
  String? updateDate;
  String? persUpdate;
  bool? active;

  CurrencyModel(
      {this.id,
        this.currency,
        this.price,
        this.createdDate,
        this.persCreated,
        this.updateDate,
        this.persUpdate,
        this.active
      });

  CurrencyModel.fromJson(Map json) {
    id = json["Id"];
    currency = json["Fiyat"];
    price = json["Currency"];
    createdDate = json["OlusturulmaTarihiFormatli"];
    persCreated = json["OlusturanKisi"];
    updateDate = json["GuncellemeTarihiFormatli"];
    persUpdate = json["GuncelleyenKisi"];
    active = json["Aktiflik"];
  }

  Map toJson() {
    return {
      "Id": id,
      "Currency": currency,
      "Fiyat": price,
      "OlusturulmaTarihiFormatli": createdDate,
      "OlusturanKisi": persCreated,
      "GuncellemeTarihiFormatli": updateDate,
      "GuncelleyenKisi": persUpdate,
      "Aktiflik": active,
    };
  }

  static List<CurrencyModel> currencyList(List<dynamic> list){
    return List<CurrencyModel>.from(list.map((e) => CurrencyModel.fromJson(e)));
  }
}
