class TenantsResponseModel {
  TenantsResponseModel({
      this.status, 
      this.message, 
      this.data,});

  TenantsResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TenantData.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<TenantData>? data;
TenantsResponseModel copyWith({  bool? status,
  String? message,
  List<TenantData>? data,
}) => TenantsResponseModel(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TenantData {
  TenantData({
      this.transactionId, 
      this.tenantId, 
      this.amount, 
      this.roomNumber, 
      this.startDate, 
      this.endDate, 
      this.tenant,});

  TenantData.fromJson(dynamic json) {
    transactionId = json['transactionId'];
    tenantId = json['tenantId'];
    amount = json['amount'];
    roomNumber = json['roomNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    tenant = json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null;
  }
  String? transactionId;
  String? tenantId;
  num? amount;
  String? roomNumber;
  String? startDate;
  String? endDate;
  Tenant? tenant;
TenantData copyWith({  String? transactionId,
  String? tenantId,
  num? amount,
  String? roomNumber,
  String? startDate,
  String? endDate,
  Tenant? tenant,
}) => TenantData(  transactionId: transactionId ?? this.transactionId,
  tenantId: tenantId ?? this.tenantId,
  amount: amount ?? this.amount,
  roomNumber: roomNumber ?? this.roomNumber,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  tenant: tenant ?? this.tenant,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transactionId'] = transactionId;
    map['tenantId'] = tenantId;
    map['amount'] = amount;
    map['roomNumber'] = roomNumber;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    if (tenant != null) {
      map['tenant'] = tenant?.toJson();
    }
    return map;
  }

}

class Tenant {
  Tenant({
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.profileImage, 
      this.tampayId,});

  Tenant.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profileImage = json['profileImage'];
    tampayId = json['tampayId'];
  }
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  String? tampayId;
Tenant copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? profileImage,
  String? tampayId,
}) => Tenant(  userId: userId ?? this.userId,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  profileImage: profileImage ?? this.profileImage,
  tampayId: tampayId ?? this.tampayId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['profileImage'] = profileImage;
    map['tampayId'] = tampayId;
    return map;
  }

}