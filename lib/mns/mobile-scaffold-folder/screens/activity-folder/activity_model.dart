class Veri {
  List<ActivityModel> activity;

  Veri({required this.activity});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        activity: List<ActivityModel>.from(
            json["Veri"].map((x) => ActivityModel.fromJson(x))));
  }
}

class ActivityModel {
  int? id;
  String? comment;
  String? email;
  String? customerName;
  String? contactName;
  String? activityGender;
  String? activityType;
  int? activityState;
  String? startDate;
  String? persCreated;

  ActivityModel(
      {this.id,
      this.comment,
      this.email,
      this.customerName,
      this.contactName,
      this.activityGender,
      this.activityType,
      this.activityState,
      this.startDate,
      this.persCreated,
      });

  ActivityModel.fromJson(Map json) {
    id = json["LOGICALREF"];
    comment = json["Aciklama"];
    email = json["Email"];
    customerName = json["MusteriAdi"];
    contactName = json["KontakAdi"];
    activityGender = json["AktiviteTuru"];
    activityType = json["AktiviteTipi"];
    activityState = json["AktiviteDurumu"];
    startDate = json["AktiviteTarihiFormatli"];
    persCreated = json["EXPCATEGORY"];
  }

  Map toJson() {
    return {
      "CODE": id,
      "Aciklama": comment,
      "Email": email,
      "MusteriAdi": customerName,
      "KontakAdi": contactName,
      "AktiviteTuru": activityGender,
      "AktiviteTipi": activityType,
      "AktiviteDurumu": activityState,
      "AktiviteTarihiFormatli": startDate,
      "EXPCATEGORY": persCreated,
    };
  }
}
