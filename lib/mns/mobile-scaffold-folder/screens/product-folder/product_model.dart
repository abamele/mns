class Veri{
  List<ProductModel> product;

  Veri({required this.product});

  factory Veri.fromJson(Map<String, dynamic> json){
    return Veri(
        product: List<ProductModel>.from(json["Veri"].map((x)=>ProductModel.fromJson(x)))
    );
  }
}

class ProductModel {
  int? ref;
  String? code;
  String? name;
  String? attendanceExchange;
  String? serviceExchange;
  String? comment;

  ProductModel({this.ref,this.code, this.name, this.attendanceExchange, this.serviceExchange, this.comment});

  ProductModel.fromJson(Map json) {
    ref = json["LOGICALREF"];
    code = json["CODE"];
    name = json["NAME"];
    attendanceExchange = json["HizmetBedeli"];
    serviceExchange = json["ServisBedeli"];
    comment = json["EXPCATEGORY"];
  }

  Map toJson() {
    return {
      "CODE": code,
      "NAME": name,
      "HizmetBedeli": attendanceExchange,
      "ServisBedeli": serviceExchange,
      "EXPCATEGORY": comment,
    };
  }
}