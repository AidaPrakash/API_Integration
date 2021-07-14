class Enquiry {
  String name;
  String qry;

  Enquiry({this.name, this.qry});

  Enquiry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qry = json['qry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qry'] = this.qry;
    return data;
  }
}
