class Veri {
  List<OrderConfirmModel> order;

  Veri({required this.order});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        order: List<OrderConfirmModel>.from(
            json["Veri"].map((x) => OrderConfirmModel.fromJson(x))));
  }
}

class OrderConfirmModel {
  String? offerNo;
  String? customerName;
  String? cargoName;
  String? payment;
  String? confirmDate;

  OrderConfirmModel(
      {this.offerNo,
        this.customerName,
        this.cargoName,
        this.payment,
        this.confirmDate,
      });

  OrderConfirmModel.fromJson(Map json) {
    offerNo = json["TeklifNo"];
    customerName = json["MusteriAdi"];
    cargoName = json["KargoAdi"];
    payment = json["OdemeYonetimi"];
    confirmDate = json["OnayTarihiFormatli"];
  }

  Map toJson() {
    return {
      "TeklifNo": offerNo,
      "MusteriAdi": customerName,
      "KargoAdi": cargoName,
      "OdemeYonetimi": payment,
      "OnayTarihiFormatli": confirmDate,
    };
  }
}
