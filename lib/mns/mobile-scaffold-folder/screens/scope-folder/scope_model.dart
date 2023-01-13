class Veri {
  List<ScopeModel> scope;

  Veri({required this.scope});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        scope: List<ScopeModel>.from(
            json["Veri"].map((x) => ScopeModel.fromJson(x))));
  }
}

class ScopeModel {
  int? id;
  String? scopeName;
  String? startDate;
  String? endDate;
  String? comment;

  ScopeModel(
      {this.id,
        this.scopeName,
        this.startDate,
        this.endDate,
        this.comment

      });

  ScopeModel.fromJson(Map json) {
    id = json["FirsatID"];
    scopeName = json["FirsatAdi"];
    startDate = json["BaslangicTarihiFormatli"];
    endDate = json["BitisTarihiFormatli"];
    comment = json["FirsatAciklama"];
  }

  Map toJson() {
    return {
      "FirsatID": id,
      "FirsatAdi": scopeName,
      "BaslangicTarihiFormatli": startDate,
      "BitisTarihiFormatli": endDate,
      "FirsatAciklama": comment,
    };
  }
}
