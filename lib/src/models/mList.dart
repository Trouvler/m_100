import 'package:m_100/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

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

  factory Ml.fromXml(XmlElement xml){

    return Ml(
      mntnm : XmlUtils.searchResult(xml,"mntnm"),//json["mntnm"] == null ? '' : json["mntnm"] as String,
      subnm :XmlUtils.searchResult(xml,"subnm"),//json["subnm"] == null ? '' : json["subnm"] as String,
      areanm : XmlUtils.searchResult(xml,"areanm"),//json["areanm"] == null ? '' : json["areanm"] as String,
      mntheight : XmlUtils.searchResult(xml,"mntheight"),//json["mntheight"] == null ? '' : json["mntheight"] as String,
      aeatreason : XmlUtils.searchResult(xml,"aeatreason"),//json["aeatreason"]  == null ? '' : json["aeatreason"] as String,
      overview : XmlUtils.searchResult(xml,"overview"),//json["overview"]  == null ? '' : json["overview"] as String,
      transport : XmlUtils.searchResult(xml,"transport"),//json["transport"]  == null ? '' : json["transport"] as String,
      etccourse : XmlUtils.searchResult(xml,"etccourse"),//json["etccourse"]  == null ? '' : json["etccourse"] as String,
    );

  }
}

