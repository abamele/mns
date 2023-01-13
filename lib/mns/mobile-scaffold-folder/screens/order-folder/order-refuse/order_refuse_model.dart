class Veri {
  List<OrderRefuseModel> order;

  Veri({required this.order});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        order: List<OrderRefuseModel>.from(
            json["Veri"].map((x) => OrderRefuseModel.fromJson(x))));
  }
}

class OrderRefuseModel {
  String? offerId;
  String? customerName;
  String? causeRefuse;
  String? date;

  OrderRefuseModel(
      {this.offerId,
        this.customerName,
        this.causeRefuse,
        this.date,
      });

  OrderRefuseModel.fromJson(Map json) {
    offerId = json["TeklifNo"];
    customerName = json["MusteriAdi"];
    causeRefuse = json["RetNedeni"];
    date = json["OnayTarihiFormatli"];
  }

  Map toJson() {
    return {
      "TeklifNo": offerId,
      "MusteriAdi": customerName,
      "RetNedeni": causeRefuse,
      "OnayTarihiFormatli": date,
    };
  }
}
