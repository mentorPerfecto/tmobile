class UserResponseModel {
  UserResponseModel({
      this.userId, 
      this.tampayId, 
      this.firstName, 
      this.lastName, 
      this.middleName, 
      this.gender, 
      this.verifyStatus, 
      this.accountStatus, 
      this.role, 
      this.tenantVerified, 
      this.landlordVerified, 
      this.showContactInfo, 
      this.phoneNumber, 
      this.email, 
      this.profileImage, 
      this.createdAt, 
      this.deletedAt, 
      this.existingTenantVerification, 
      this.platformCosts,});

  UserResponseModel.fromJson(dynamic json) {
    userId = json['userId'];
    tampayId = json['tampayId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    gender = json['gender'];
    verifyStatus = json['verifyStatus'];
    accountStatus = json['accountStatus'];
    role = json['role'];
    tenantVerified = json['tenantVerified'];
    landlordVerified = json['landlordVerified'];
    showContactInfo = json['showContactInfo'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    profileImage = json['profileImage'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    existingTenantVerification = json['existingTenantVerification'];
    platformCosts = json['platformCosts'] != null ? PlatformCosts.fromJson(json['platformCosts']) : null;
  }
  String? userId;
  String? tampayId;
  String? firstName;
  String? lastName;
  dynamic middleName;
  dynamic gender;
  num? verifyStatus;
  num? accountStatus;
  num? role;
  bool? tenantVerified;
  bool? landlordVerified;
  bool? showContactInfo;
  dynamic phoneNumber;
  String? email;
  String? profileImage;
  String? createdAt;
  dynamic deletedAt;
  bool? existingTenantVerification;
  PlatformCosts? platformCosts;
UserResponseModel copyWith({  String? userId,
  String? tampayId,
  String? firstName,
  String? lastName,
  dynamic middleName,
  dynamic gender,
  num? verifyStatus,
  num? accountStatus,
  num? role,
  bool? tenantVerified,
  bool? landlordVerified,
  bool? showContactInfo,
  dynamic phoneNumber,
  String? email,
  String? profileImage,
  String? createdAt,
  dynamic deletedAt,
  bool? existingTenantVerification,
  PlatformCosts? platformCosts,
}) => UserResponseModel(  userId: userId ?? this.userId,
  tampayId: tampayId ?? this.tampayId,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  middleName: middleName ?? this.middleName,
  gender: gender ?? this.gender,
  verifyStatus: verifyStatus ?? this.verifyStatus,
  accountStatus: accountStatus ?? this.accountStatus,
  role: role ?? this.role,
  tenantVerified: tenantVerified ?? this.tenantVerified,
  landlordVerified: landlordVerified ?? this.landlordVerified,
  showContactInfo: showContactInfo ?? this.showContactInfo,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  email: email ?? this.email,
  profileImage: profileImage ?? this.profileImage,
  createdAt: createdAt ?? this.createdAt,
  deletedAt: deletedAt ?? this.deletedAt,
  existingTenantVerification: existingTenantVerification ?? this.existingTenantVerification,
  platformCosts: platformCosts ?? this.platformCosts,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['tampayId'] = tampayId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['middleName'] = middleName;
    map['gender'] = gender;
    map['verifyStatus'] = verifyStatus;
    map['accountStatus'] = accountStatus;
    map['role'] = role;
    map['tenantVerified'] = tenantVerified;
    map['landlordVerified'] = landlordVerified;
    map['showContactInfo'] = showContactInfo;
    map['phoneNumber'] = phoneNumber;
    map['email'] = email;
    map['profileImage'] = profileImage;
    map['createdAt'] = createdAt;
    map['deletedAt'] = deletedAt;
    map['existingTenantVerification'] = existingTenantVerification;
    if (platformCosts != null) {
      map['platformCosts'] = platformCosts?.toJson();
    }
    return map;
  }

}

class PlatformCosts {
  PlatformCosts({
      this.extendedValidationCost, 
      this.backgroundCheckCost, 
      this.tenantOnboardingCost,});

  PlatformCosts.fromJson(dynamic json) {
    extendedValidationCost = json['extendedValidationCost'];
    backgroundCheckCost = json['backgroundCheckCost'];
    tenantOnboardingCost = json['tenantOnboardingCost'];
  }
  num? extendedValidationCost;
  num? backgroundCheckCost;
  num? tenantOnboardingCost;
PlatformCosts copyWith({  num? extendedValidationCost,
  num? backgroundCheckCost,
  num? tenantOnboardingCost,
}) => PlatformCosts(  extendedValidationCost: extendedValidationCost ?? this.extendedValidationCost,
  backgroundCheckCost: backgroundCheckCost ?? this.backgroundCheckCost,
  tenantOnboardingCost: tenantOnboardingCost ?? this.tenantOnboardingCost,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['extendedValidationCost'] = extendedValidationCost;
    map['backgroundCheckCost'] = backgroundCheckCost;
    map['tenantOnboardingCost'] = tenantOnboardingCost;
    return map;
  }

}