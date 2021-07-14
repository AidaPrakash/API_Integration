class DriverDetails {
  String sno;
  String trailerno;
  String operator;
  String operator1;
  String omobileno;
  String mobileno1;
  String partyName;
  String desitination;
  String rtonne;

  DriverDetails(
      {this.sno,
      this.trailerno,
      this.operator,
      this.operator1,
      this.omobileno,
      this.mobileno1,
      this.partyName,
      this.desitination,
      this.rtonne});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    trailerno = json['trailerno'];
    operator = json['operator'];
    operator1 = json['operator1'];
    omobileno = json['omobileno'];
    mobileno1 = json['mobileno1'];
    partyName = json['partyName'];
    desitination = json['desitination'];
    rtonne = json['rtonne'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['trailerno'] = this.trailerno;
    data['operator'] = this.operator;
    data['operator1'] = this.operator1;
    data['omobileno'] = this.omobileno;
    data['mobileno1'] = this.mobileno1;
    data['partyName'] = this.partyName;
    data['desitination'] = this.desitination;
    data['rtonne'] = this.rtonne;
    return data;
  }
}

class DriverDetailsList {
  final List<DriverDetails> operator;

  DriverDetailsList({
    this.operator,
  });

  factory DriverDetailsList.fromJson(List<dynamic> parsedJson) {
    List<DriverDetails> operator = new List<DriverDetails>();
    operator = parsedJson.map((i) => DriverDetails.fromJson(i)).toList();
    return new DriverDetailsList(
      operator: operator,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> dataList = new List();
    for (DriverDetails data in operator) {
      dataList.add(data.toJson());
    }
    return dataList;
  }
}

class EnquiryDetails {
  String name;
  String qry;

  EnquiryDetails({this.name, this.qry});

  EnquiryDetails.fromJson(Map<String, dynamic> json) {
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

class EnquiryDetailsList {
  final List<EnquiryDetails> name;

  EnquiryDetailsList({
    this.name,
  });

  factory EnquiryDetailsList.fromJson(List<dynamic> parsedJson) {
    List<EnquiryDetails> name = new List<EnquiryDetails>();
    name = parsedJson.map((i) => EnquiryDetails.fromJson(i)).toList();
    return new EnquiryDetailsList(
      name: name,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> dataList = new List();
    for (EnquiryDetails data in name) {
      dataList.add(data.toJson());
    }
    return dataList;
  }
}
