// To parse this JSON data, do
//
//     final employeeResponse = employeeResponseFromJson(jsonString);

import 'dart:convert';

EmployeeResponse employeeResponseFromJson(String str) => EmployeeResponse.fromJson(json.decode(str));

String employeeResponseToJson(EmployeeResponse data) => json.encode(data.toJson());

class EmployeeResponse {
  List<EmployeeResult>? result;
  int? statusCode;
  String? message;
  String? status;

  EmployeeResponse({
    this.result,
    this.statusCode,
    this.message,
    this.status,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) => EmployeeResponse(
    result: json["result"] == null ? [] : List<EmployeeResult>.from(json["result"]!.map((x) => EmployeeResult.fromJson(x))),
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "statusCode": statusCode,
    "message": message,
    "status": status,
  };
}

class EmployeeResult {
  int? nEmployeeId;
  String? employeeCode;
  String? sG42EmpId;
  String? yituEmployeeId;
  String? yituStaffId;
  String? yituBusinessUnitId;
  String? sYituTags;
  String? eidNumber;
  String? cardNumber;
  String? licenseNumber;
  String? fullName;
  String? dateofBirth;
  String? eiDIssueDate;
  String? eiDExpiryDate;
  String? passportNumber;
  String? passportIssueDate;
  String? passportExpiryDate;
  String? nationality;
  String? sponsor;
  String? gender;
  String? mobileNo;
  String? email;
  String? address;
  String? nVisaType;
  String? nDepartmentId;
  String? sBusinessUnitEn;
  String? nSectionId;
  String? hireDate;
  String? contractExpiryDate;
  String? nEmployeeType;
  String? accessCardNumber;
  String? photo;
  String? eiDPhoto;
  dynamic remarks;
  String? createdBy;
  String? createdDate;
  dynamic yituModifiedOn;
  String? sLocationNameEn;

  EmployeeResult({
    this.nEmployeeId,
    this.employeeCode,
    this.sG42EmpId,
    this.yituEmployeeId,
    this.yituStaffId,
    this.yituBusinessUnitId,
    this.sYituTags,
    this.eidNumber,
    this.cardNumber,
    this.licenseNumber,
    this.fullName,
    this.dateofBirth,
    this.eiDIssueDate,
    this.eiDExpiryDate,
    this.passportNumber,
    this.passportIssueDate,
    this.passportExpiryDate,
    this.nationality,
    this.sponsor,
    this.gender,
    this.mobileNo,
    this.email,
    this.address,
    this.nVisaType,
    this.nDepartmentId,
    this.sBusinessUnitEn,
    this.nSectionId,
    this.hireDate,
    this.contractExpiryDate,
    this.nEmployeeType,
    this.accessCardNumber,
    this.photo,
    this.eiDPhoto,
    this.remarks,
    this.createdBy,
    this.createdDate,
    this.yituModifiedOn,
    this.sLocationNameEn,
  });

  factory EmployeeResult.fromJson(Map<String, dynamic> json) => EmployeeResult(
    nEmployeeId: json["n_EmployeeID"],
    employeeCode: json["employeeCode"],
    sG42EmpId: json["s_G42EmpID"],
    yituEmployeeId: json["yituEmployeeID"],
    yituStaffId: json["yituStaffId"],
    yituBusinessUnitId: json["yituBusinessUnitId"],
    sYituTags: json["s_YituTags"],
    eidNumber: json["eidNumber"],
    cardNumber: json["cardNumber"],
    licenseNumber: json["licenseNumber"],
    fullName: json["fullName"],
    dateofBirth: json["dateofBirth"],
    eiDIssueDate: json["eiD_IssueDate"],
    eiDExpiryDate: json["eiD_ExpiryDate"],
    passportNumber: json["passportNumber"],
    passportIssueDate: json["passportIssueDate"],
    passportExpiryDate: json["passportExpiryDate"],
    nationality: json["nationality"],
    sponsor: json["sponsor"],
    gender: json["gender"],
    mobileNo: json["mobileNo"],
    email: json["email"],
    address: json["address"],
    nVisaType: json["n_VisaType"],
    nDepartmentId: json["n_DepartmentID"],
    sBusinessUnitEn: json["s_BusinessUnit_En"],
    nSectionId: json["n_SectionID"],
    hireDate: json["hireDate"],
    contractExpiryDate: json["contractExpiryDate"],
    nEmployeeType: json["n_EmployeeType"],
    accessCardNumber: json["accessCardNumber"],
    photo: json["photo"],
    eiDPhoto: json["eiD_Photo"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    yituModifiedOn: json["yituModifiedOn"],
    sLocationNameEn: json["s_LocationName_En"],
  );

  Map<String, dynamic> toJson() => {
    "n_EmployeeID": nEmployeeId,
    "employeeCode": employeeCode,
    "s_G42EmpID": sG42EmpId,
    "yituEmployeeID": yituEmployeeId,
    "yituStaffId": yituStaffId,
    "yituBusinessUnitId": yituBusinessUnitId,
    "s_YituTags": sYituTags,
    "eidNumber": eidNumber,
    "cardNumber": cardNumber,
    "licenseNumber": licenseNumber,
    "fullName": fullName,
    "dateofBirth": dateofBirth,
    "eiD_IssueDate": eiDIssueDate,
    "eiD_ExpiryDate": eiDExpiryDate,
    "passportNumber": passportNumber,
    "passportIssueDate": passportIssueDate,
    "passportExpiryDate": passportExpiryDate,
    "nationality": nationality,
    "sponsor": sponsor,
    "gender": gender,
    "mobileNo": mobileNo,
    "email": email,
    "address": address,
    "n_VisaType": nVisaType,
    "n_DepartmentID": nDepartmentId,
    "s_BusinessUnit_En": sBusinessUnitEn,
    "n_SectionID": nSectionId,
    "hireDate": hireDate,
    "contractExpiryDate": contractExpiryDate,
    "n_EmployeeType": nEmployeeType,
    "accessCardNumber": accessCardNumber,
    "photo": photo,
    "eiD_Photo": eiDPhoto,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "yituModifiedOn": yituModifiedOn,
    "s_LocationName_En": sLocationNameEn,
  };
}
