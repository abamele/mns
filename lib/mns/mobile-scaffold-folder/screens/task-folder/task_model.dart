class Veri {
  List<TaskModel> task;

  Veri({required this.task});

  factory Veri.fromJson(Map<String, dynamic> json) {
    return Veri(
        task: List<TaskModel>.from(
            json["Veri"].map((x) => TaskModel.fromJson(x))));
  }
}

class TaskModel {
  int? id;
  String? taskDef;
  String? taskNom;
  String? taskResp;
  String? taskType;
  String? startDate;
  String? endDate;
  int? taskStateNum;
  String? taskState;
  String? comment;

  TaskModel(
      {this.id,
        this.taskDef,
        this.taskNom,
        this.taskResp,
        this.taskType,
        this.startDate,
        this.endDate,
        this.taskStateNum,
        this.taskState,
        this.comment

      });

  TaskModel.fromJson(Map json) {
    id = json["GorevID"];
    taskDef = json["GorevTanimi"];
    taskNom = json["GoreviAtayanAdiSoyadi"];
    taskResp = json["GorevSorumlusu"];
    taskType = json["GorevTipi"];
    startDate = json["GorevBaslangicFormatli"];
    endDate = json["GorevBitisFormatli"];
    taskStateNum = json["GorevinDurumu"];
    taskState = json["GorevDurumuText"];
    comment = json["GorevinAciklamasi"];
  }

  Map toJson() {
    return {
      "GorevTanimi": taskDef,
      "GoreviAtayanAdiSoyadi": taskNom,
      "GorevSorumlusu": taskResp,
      "GorevTipi": taskType,
      "GorevBaslangicFormatli": startDate,
      "GorevBitisFormatli": endDate,
      "GorevinDurumu": taskStateNum,
      "GorevDurumuText": taskState,
      "GorevinAciklamasi": comment,
    };
  }
}
