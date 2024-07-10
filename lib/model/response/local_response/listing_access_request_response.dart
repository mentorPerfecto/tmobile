class ListingAccessRequestResponse {
  ListingAccessRequestResponse({
      this.status, 
      this.message, 
      this.data,});

  ListingAccessRequestResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<Data>? data;
ListingAccessRequestResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => ListingAccessRequestResponse(  status: status ?? this.status,
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

class Data {
  Data({
      this.listingTransactionHistoryId, 
      this.transactionId, 
      this.tenantId, 
      this.landlordId, 
      this.listingId, 
      this.transactionType, 
      this.amount, 
      this.numberOfUnits, 
      this.roomNumber, 
      this.startDate, 
      this.endDate, 
      this.status, 
      this.deletedAt, 
      this.tenant,});

  Data.fromJson(dynamic json) {
    listingTransactionHistoryId = json['listingTransactionHistoryId'];
    transactionId = json['transactionId'];
    tenantId = json['tenantId'];
    landlordId = json['landlordId'];
    listingId = json['listingId'];
    transactionType = json['transactionType'];
    amount = json['amount'];
    numberOfUnits = json['numberOfUnits'];
    roomNumber = json['roomNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    deletedAt = json['deletedAt'];
    tenant = json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null;
  }
  String? listingTransactionHistoryId;
  String? transactionId;
  String? tenantId;
  String? landlordId;
  String? listingId;
  String? transactionType;
  num? amount;
  num? numberOfUnits;
  dynamic roomNumber;
  dynamic startDate;
  dynamic endDate;
  String? status;
  dynamic deletedAt;
  Tenant? tenant;
Data copyWith({  String? listingTransactionHistoryId,
  String? transactionId,
  String? tenantId,
  String? landlordId,
  String? listingId,
  String? transactionType,
  num? amount,
  num? numberOfUnits,
  dynamic roomNumber,
  dynamic startDate,
  dynamic endDate,
  String? status,
  dynamic deletedAt,
  Tenant? tenant,
}) => Data(  listingTransactionHistoryId: listingTransactionHistoryId ?? this.listingTransactionHistoryId,
  transactionId: transactionId ?? this.transactionId,
  tenantId: tenantId ?? this.tenantId,
  landlordId: landlordId ?? this.landlordId,
  listingId: listingId ?? this.listingId,
  transactionType: transactionType ?? this.transactionType,
  amount: amount ?? this.amount,
  numberOfUnits: numberOfUnits ?? this.numberOfUnits,
  roomNumber: roomNumber ?? this.roomNumber,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  status: status ?? this.status,
  deletedAt: deletedAt ?? this.deletedAt,
  tenant: tenant ?? this.tenant,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['listingTransactionHistoryId'] = listingTransactionHistoryId;
    map['transactionId'] = transactionId;
    map['tenantId'] = tenantId;
    map['landlordId'] = landlordId;
    map['listingId'] = listingId;
    map['transactionType'] = transactionType;
    map['amount'] = amount;
    map['numberOfUnits'] = numberOfUnits;
    map['roomNumber'] = roomNumber;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['status'] = status;
    map['deletedAt'] = deletedAt;
    if (tenant != null) {
      map['tenant'] = tenant?.toJson();
    }
    return map;
  }

}


class Tenant {
  Tenant({
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phoneNumber, 
      this.profileImage, 
      this.tampayId,});

  Tenant.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
    tampayId = json['tampayId'];
  }
  String? firstName;
  String? lastName;
  String? email;
  dynamic phoneNumber;
  String? profileImage;
  String? tampayId;
Tenant copyWith({  String? firstName,
  String? lastName,
  String? email,
  dynamic phoneNumber,
  String? profileImage,
  String? tampayId,
}) => Tenant(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  profileImage: profileImage ?? this.profileImage,
  tampayId: tampayId ?? this.tampayId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['profileImage'] = profileImage;
    map['tampayId'] = tampayId;
    return map;
  }

}