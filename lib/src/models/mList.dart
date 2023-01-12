class Ml {
  String? mntnm;
  String? subnm;
  String? areanm;
  String? mntheight;
  String? aeatreason;
  String? overview;
  String? transport;
  String? etccourse;

  Ml({
    this.mntnm,
    this.subnm ,
    this.areanm,
    this.mntheight,
    this.aeatreason,
    this.overview,
    this.transport,
    this.etccourse,
  });

  factory Ml.fromJson(Map<String, dynamic> json){

    return Ml(
      mntnm : json["mntnm"] == null ? '' : json["mntnm"] as String,
      subnm :json["subnm"] == null ? '' : json["subnm"] as String,
      areanm : json["areanm"] == null ? '' : json["areanm"] as String,
      mntheight : json["mntheight"] == null ? '' : json["mntheight"] as String,
      aeatreason : json["aeatreason"]  == null ? '' : json["aeatreason"] as String,
      overview : json["overview"]  == null ? '' : json["overview"] as String,
      transport : json["transport"]  == null ? '' : json["transport"] as String,
      etccourse : json["etccourse"]  == null ? '' : json["etccourse"] as String,
    );

  }
}

