
class CargoModel {
  int? id;
  String? cargoName;
  String? createdDate;
  String? persCreated;
  String? updateDate;
  String? persUpdated;
  bool? active;

  CargoModel(
      {this.id,
        this.cargoName,
        this.createdDate,
        this.persCreated,
        this.updateDate,
        this.persUpdated,
        this.active
      });

  CargoModel.fromJson(Map json) {
    id = json["KargoID"];
    cargoName = json["KargoAdi"];
    createdDate = json["OlusturulmaTarihiFormatli"];
    persCreated = json["OlusturanKisi"];
    updateDate = json["GuncellemeTarihiFormatli"];
    persUpdated = json["GuncelleyenKisi"];
    active = json["Aktiflik"];
  }

  Map toJson() {
    return {
      "KargoID": id,
      "KargoAdi": cargoName,
      "OlusturulmaTarihiFormatli": createdDate,
      "OlusturanKisi": persCreated,
      "GuncellemeTarihiFormatli": updateDate,
      "GuncelleyenKisi": persUpdated,
      "Aktiflik": active,
    };
  }

  static List<CargoModel> cargoList(List<dynamic> list){
    return List<CargoModel>.from(list.map((e) => CargoModel.fromJson(e)));
  }
}
