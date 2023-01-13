
class CauseRefuseModel {
  int? id;
  String? comment;
  String? createdDate;
  String? persCreated;
  String? updateDate;
  String? persUpdate;
  bool? active;

  CauseRefuseModel(
      {this.id,
        this.comment,
        this.createdDate,
        this.persCreated,
        this.updateDate,
        this.persUpdate,
        this.active
      });

  CauseRefuseModel.fromJson(Map json) {
    id = json["Id"];
    comment = json["RedAciklama"];
    createdDate = json["OlusturulmaTarihiFormatli"];
    persCreated = json["OlusturanKisi"];
    updateDate = json["GuncellemeTarihiFormatli"];
    persUpdate = json["GuncelleyenKisi"];
    active = json["Aktiflik"];
  }

  Map toJson() {
    return {
      "Id": id,
      "RedAciklama": comment,
      "OlusturulmaTarihiFormatli": createdDate,
      "OlusturanKisi": persCreated,
      "GuncellemeTarihiFormatli": updateDate,
      "GuncelleyenKisi": persUpdate,
      "Aktiflik": active,
    };
  }
  static List<CauseRefuseModel> causeRefuseList(List<dynamic> list){
    return List<CauseRefuseModel>.from(list.map((e) => CauseRefuseModel.fromJson(e)));
  }
}
