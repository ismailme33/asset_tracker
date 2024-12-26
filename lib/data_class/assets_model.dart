class AssetsModel {
  String id;
  String assetType;
  String brand;

  String sn;
  String imeiNumber;
  String deviceModel;
  String assetname;

  String processor;
  String ram;
  String hardDrive;
  String displaySize;

  DateTime? purchasedDate;
  String warrantyPeriod;
  String notes;
  String assignee;
  String status;
  String substatus;
  DateTime? assignedDate;
  String localITSite;
  String location;
  String legalentity;

  String supplier;
  String supportPeriod;
  String sapnumber;
  String invNumber;
  String assetNumber;

  DateTime createdDate;

  AssetsModel({
    required this.id,
    this.assetname = "",
    required this.assetType,
    required this.brand,
    required this.sn,
    this.imeiNumber = '0',
    this.deviceModel = '',
    this.processor = '',
    this.ram = '',
    this.hardDrive = '',
    this.displaySize = '',
    this.purchasedDate,
    this.warrantyPeriod = '',
    this.assignee = '',
    this.assignedDate,
    required this.createdDate,
    this.localITSite = '',
    this.location = '',
    this.status = '',
    this.substatus = '',
    this.legalentity = '',
    this.assetNumber = '',
    this.invNumber = '',
    this.notes = '',
    this.sapnumber = '',
    this.supplier = '',
    this.supportPeriod = '',
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assetname': assetname,
      'assettype': assetType,
      'brand': brand,
      'sn': sn,
      'imeinumber': imeiNumber,
      'devicemoder': deviceModel,
      'processor': processor,
      'ram': ram,
      'harddrive': hardDrive,
      'displaysize': displaySize,
      'purchaseDate': purchasedDate,
      'warrantyperiod': warrantyPeriod,
      'assignee': assignee,
      'assigneddate': assignedDate,
      'createddate': createdDate,
      'localItSite': localITSite,
      'location': location,
      'status': status,
      'substatus': substatus,
      'supplier': supplier,
      'legalentity': legalentity,
      'invNumber': invNumber,
      'sapNumber': sapnumber,
      'assetNumber': assetNumber,
      'notes': notes,
      'supportPeriod': supportPeriod,
    };
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'],
      assetname: map['assetname'],
      assetType: map['assettype'],
      brand: map['brand'],
      sn: map['sn'],
      imeiNumber: map['imeinumber'],
      deviceModel: map['devicemoder'],
      processor: map['processor'],
      ram: map['ram'],
      hardDrive: map['harddrive'],
      displaySize: map['displaysize'],
      purchasedDate: map['purchasedate'],
      warrantyPeriod: map['warrantyperiod'],
      assignee: map['assignee'],
      assignedDate: map['assigneddate'],
      createdDate: map['createddate'],
      localITSite: map['localItSite'],
      location: map['location'],
      status: map['status'],
      substatus: map['substatus'],
      supplier: map['supplier'],
      legalentity: map['legalentity'],
      invNumber: map['invNumber'],
      sapnumber: map['sapNumber'],
      assetNumber: map['assetNumber'],
      notes: map['notes'],
      supportPeriod: map['supportPeriod'],
    );
  }
}
