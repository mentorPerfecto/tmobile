/// status : true
/// message : "ListingData fetched successfully"
/// data : {"total":2,"listings":[{"listingId":"4ad76c0a-49b2-4818-a6f3-f54ef2652508","userId":"7b5452c9-137e-4f14-a7ca-13863e6e8c33","title":"Wagwan Castle 🏰","address":"1, Odiachi Street off Nnebisi Rd","city":"Asaba","state":"Delta","country":"Nigeria","tags":["Gym","Wi-Fi"],"listingType":"lease","propertyType":"duplex","undertampayContract":false,"agreedPercentage":null,"durationOfManagement":null,"propertyContractType":null,"propertySize":"320","propertyCategory":null,"propertySubcategory":null,"price":10000000,"paymentPlan":"one-time","totalUnits":4,"availableUnits":2,"buildingsOnLand":null,"bedrooms":0,"bathrooms":1,"description":"Comfi","amenities":["Gym","Spa"],"rules":null,"images":["https://res.cloudinary.com/dfei5jk9p/image/upload/v1706956604/tampay-production/listing-images/file_un4obo.jpg"],"tenancyAgreement":null,"isVerified":false,"createdAt":"2024-02-03T10:36:46.308Z","deletedAt":null},{"listingId":"a147a231-5ee7-486f-b50a-89140a3d9446","userId":"7b5452c9-137e-4f14-a7ca-13863e6e8c33","title":"Xtreme Villa","address":"1, Eziobodo","city":"Owerri","state":"Imo","country":"Nigeria","tags":["Gym","Wi-Fi"],"listingType":"sale","propertyType":"residential","undertampayContract":false,"agreedPercentage":null,"durationOfManagement":null,"propertyContractType":null,"propertySize":"320","propertyCategory":null,"propertySubcategory":null,"price":6500000,"paymentPlan":"one-time","totalUnits":2,"availableUnits":2,"buildingsOnLand":null,"bedrooms":2,"bathrooms":2,"description":"Exclusive and Beautiful","amenities":["Gym","Spa","Swimming pool","Security"],"rules":null,"images":["https://res.cloudinary.com/dfei5jk9p/image/upload/v1707010856/tampay-production/listing-images/file_kn4wxg.jpg"],"tenancyAgreement":null,"isVerified":false,"createdAt":"2024-02-04T01:40:56.639Z","deletedAt":null}],"page":1,"lastPage":1}

class ListingsResponseModel {
  ListingsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  ListingsResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;
  ListingsResponseModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      ListingsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// total : 2
/// listings : [{"listingId":"4ad76c0a-49b2-4818-a6f3-f54ef2652508","userId":"7b5452c9-137e-4f14-a7ca-13863e6e8c33","title":"Wagwan Castle 🏰","address":"1, Odiachi Street off Nnebisi Rd","city":"Asaba","state":"Delta","country":"Nigeria","tags":["Gym","Wi-Fi"],"listingType":"lease","propertyType":"duplex","undertampayContract":false,"agreedPercentage":null,"durationOfManagement":null,"propertyContractType":null,"propertySize":"320","propertyCategory":null,"propertySubcategory":null,"price":10000000,"paymentPlan":"one-time","totalUnits":4,"availableUnits":2,"buildingsOnLand":null,"bedrooms":0,"bathrooms":1,"description":"Comfi","amenities":["Gym","Spa"],"rules":null,"images":["https://res.cloudinary.com/dfei5jk9p/image/upload/v1706956604/tampay-production/listing-images/file_un4obo.jpg"],"tenancyAgreement":null,"isVerified":false,"createdAt":"2024-02-03T10:36:46.308Z","deletedAt":null},{"listingId":"a147a231-5ee7-486f-b50a-89140a3d9446","userId":"7b5452c9-137e-4f14-a7ca-13863e6e8c33","title":"Xtreme Villa","address":"1, Eziobodo","city":"Owerri","state":"Imo","country":"Nigeria","tags":["Gym","Wi-Fi"],"listingType":"sale","propertyType":"residential","undertampayContract":false,"agreedPercentage":null,"durationOfManagement":null,"propertyContractType":null,"propertySize":"320","propertyCategory":null,"propertySubcategory":null,"price":6500000,"paymentPlan":"one-time","totalUnits":2,"availableUnits":2,"buildingsOnLand":null,"bedrooms":2,"bathrooms":2,"description":"Exclusive and Beautiful","amenities":["Gym","Spa","Swimming pool","Security"],"rules":null,"images":["https://res.cloudinary.com/dfei5jk9p/image/upload/v1707010856/tampay-production/listing-images/file_kn4wxg.jpg"],"tenancyAgreement":null,"isVerified":false,"createdAt":"2024-02-04T01:40:56.639Z","deletedAt":null}]
/// page : 1
/// lastPage : 1

class Data {
  Data({
    this.total,
    this.listings,
    this.page,
    this.lastPage,
  });

  Data.fromJson(dynamic json) {
    total = json['total'];
    if (json['listings'] != null) {
      listings = [];
      json['listings'].forEach((v) {
        listings?.add(ListingData.fromJson(v));
      });
    }
    page = json['page'];
    lastPage = json['lastPage'];
  }
  num? total;
  List<ListingData>? listings;
  num? page;
  num? lastPage;
  Data copyWith({
    num? total,
    List<ListingData>? listings,
    num? page,
    num? lastPage,
  }) =>
      Data(
        total: total ?? this.total,
        listings: listings ?? this.listings,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (listings != null) {
      map['listings'] = listings?.map((v) => v.toJson()).toList();
    }
    map['page'] = page;
    map['lastPage'] = lastPage;
    return map;
  }
}

/// listingId : "4ad76c0a-49b2-4818-a6f3-f54ef2652508"
/// userId : "7b5452c9-137e-4f14-a7ca-13863e6e8c33"
/// title : "Wagwan Castle 🏰"
/// address : "1, Odiachi Street off Nnebisi Rd"
/// city : "Asaba"
/// state : "Delta"
/// country : "Nigeria"
/// tags : ["Gym","Wi-Fi"]
/// listingType : "lease"
/// propertyType : "duplex"
/// undertampayContract : false
/// agreedPercentage : null
/// durationOfManagement : null
/// propertyContractType : null
/// propertySize : "320"
/// propertyCategory : null
/// propertySubcategory : null
/// price : 10000000
/// paymentPlan : "one-time"
/// totalUnits : 4
/// availableUnits : 2
/// buildingsOnLand : null
/// bedrooms : 0
/// bathrooms : 1
/// description : "Comfi"
/// amenities : ["Gym","Spa"]
/// rules : null
/// images : ["https://res.cloudinary.com/dfei5jk9p/image/upload/v1706956604/tampay-production/listing-images/file_un4obo.jpg"]
/// tenancyAgreement : null
/// isVerified : false
/// createdAt : "2024-02-03T10:36:46.308Z"
/// deletedAt : null

class ListingData {
  ListingData({
    this.listingId,
    this.listingCode,
    this.userId,
    this.title,
    this.address,
    this.city,
    this.state,
    this.country,
    this.tags,
    this.listingType,
    this.propertyType,
    this.undertampayContract,
    this.agreedPercentage,
    this.durationOfManagement,
    this.propertyContractType,
    this.propertySize,
    this.propertyCategory,
    this.propertySubcategory,
    this.price,
    this.paymentPlan,
    this.totalUnits,
    this.availableUnits,
    this.buildingsOnLand,
    this.bedrooms,
    this.bathrooms,
    this.description,
    this.amenities,
    this.rules,
    this.images,
    this.tenancyAgreement,
    this.parkInDuration,
    this.isVerified,
    this.isApproved,
    this.isFrozen,
    this.createdAt,
    this.deletedAt,
    this.fees,
    this.user,
    this.rentalStatus,
    this.listingVerificationStatus,
    this.extendedValidationStatus,
  });

  ListingData.fromJson(dynamic json) {
    listingId = json['listingId'];
    listingCode = json['listingCode'];
    userId = json['userId'];
    title = json['title'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    listingType = json['listingType'];
    propertyType = json['propertyType'];
    undertampayContract = json['undertampayContract'];
    agreedPercentage = json['agreedPercentage'];
    durationOfManagement = json['durationOfManagement'];
    propertyContractType = json['propertyContractType'];
    propertySize = json['propertySize'];
    propertyCategory = json['propertyCategory'];
    propertySubcategory = json['propertySubcategory'];
    price = json['price'];
    paymentPlan = json['paymentPlan'];
    totalUnits = json['totalUnits'];
    availableUnits = json['availableUnits'];
    buildingsOnLand = json['buildingsOnLand'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    description = json['description'];
    amenities = json['amenities'];
    rules = json['rules'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    tenancyAgreement = json['tenancyAgreement'];
    parkInDuration = json['parkInDuration'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isFrozen = json['isFrozen'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    if (json['Fees'] != null) {
      fees = [];
      json['Fees'].forEach((v) {
        fees?.add(Fees.fromJson(v));
      });
    }
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    rentalStatus = json['rentalStatus'];
    listingVerificationStatus = json['listingVerificationStatus'];
    extendedValidationStatus = json['extendedValidationStatus'];
  }
  String? listingId;
  dynamic listingCode;
  String? userId;
  String? title;
  String? address;
  String? city;
  String? state;
  String? country;
  List<String>? tags;
  String? listingType;
  String? propertyType;
  bool? undertampayContract;
  dynamic agreedPercentage;
  dynamic durationOfManagement;
  dynamic propertyContractType;
  String? propertySize;
  dynamic propertyCategory;
  dynamic propertySubcategory;
  num? price;
  String? paymentPlan;
  num? totalUnits;
  num? availableUnits;
  dynamic buildingsOnLand;
  num? bedrooms;
  num? bathrooms;
  String? description;
  dynamic amenities;
  dynamic rules;
  List<String>? images;
  dynamic tenancyAgreement;
  dynamic parkInDuration;
  num? isVerified;
  bool? isApproved;
  bool? isFrozen;
  String? createdAt;
  dynamic deletedAt;
  List<Fees>? fees;
  User? user;
  num? rentalStatus;
  num? listingVerificationStatus;
  num? extendedValidationStatus;
  ListingData copyWith({
    String? listingId,
    dynamic listingCode,
    String? userId,
    String? title,
    String? address,
    String? city,
    String? state,
    String? country,
    List<String>? tags,
    String? listingType,
    String? propertyType,
    bool? undertampayContract,
    dynamic agreedPercentage,
    dynamic durationOfManagement,
    dynamic propertyContractType,
    String? propertySize,
    dynamic propertyCategory,
    dynamic propertySubcategory,
    num? price,
    String? paymentPlan,
    num? totalUnits,
    num? availableUnits,
    dynamic buildingsOnLand,
    num? bedrooms,
    num? bathrooms,
    String? description,
    dynamic amenities,
    dynamic rules,
    List<String>? images,
    dynamic tenancyAgreement,
    dynamic parkInDuration,
    num? isVerified,
    bool? isApproved,
    bool? isFrozen,
    String? createdAt,
    dynamic deletedAt,
    List<Fees>? fees,
    User? user,
    num? rentalStatus,
    num? listingVerificationStatus,
    num? extendedValidationStatus,
  }) =>
      ListingData(
        listingId: listingId ?? this.listingId,
        listingCode: listingCode ?? this.listingCode,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        tags: tags ?? this.tags,
        listingType: listingType ?? this.listingType,
        propertyType: propertyType ?? this.propertyType,
        undertampayContract: undertampayContract ?? this.undertampayContract,
        agreedPercentage: agreedPercentage ?? this.agreedPercentage,
        durationOfManagement: durationOfManagement ?? this.durationOfManagement,
        propertyContractType: propertyContractType ?? this.propertyContractType,
        propertySize: propertySize ?? this.propertySize,
        propertyCategory: propertyCategory ?? this.propertyCategory,
        propertySubcategory: propertySubcategory ?? this.propertySubcategory,
        price: price ?? this.price,
        paymentPlan: paymentPlan ?? this.paymentPlan,
        totalUnits: totalUnits ?? this.totalUnits,
        availableUnits: availableUnits ?? this.availableUnits,
        buildingsOnLand: buildingsOnLand ?? this.buildingsOnLand,
        bedrooms: bedrooms ?? this.bedrooms,
        bathrooms: bathrooms ?? this.bathrooms,
        description: description ?? this.description,
        amenities: amenities ?? this.amenities,
        rules: rules ?? this.rules,
        images: images ?? this.images,
        tenancyAgreement: tenancyAgreement ?? this.tenancyAgreement,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        fees: fees ?? this.fees,
        user: user ?? this.user,
        rentalStatus: rentalStatus ?? this.rentalStatus,
        listingVerificationStatus: listingVerificationStatus ?? this.listingVerificationStatus,
        extendedValidationStatus: extendedValidationStatus ?? this.extendedValidationStatus,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['listingId'] = listingId;
    map['listingCode'] = listingCode;
    map['userId'] = userId;
    map['title'] = title;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['tags'] = tags;
    map['listingType'] = listingType;
    map['propertyType'] = propertyType;
    map['undertampayContract'] = undertampayContract;
    map['agreedPercentage'] = agreedPercentage;
    map['durationOfManagement'] = durationOfManagement;
    map['propertyContractType'] = propertyContractType;
    map['propertySize'] = propertySize;
    map['propertyCategory'] = propertyCategory;
    map['propertySubcategory'] = propertySubcategory;
    map['price'] = price;
    map['paymentPlan'] = paymentPlan;
    map['totalUnits'] = totalUnits;
    map['availableUnits'] = availableUnits;
    map['buildingsOnLand'] = buildingsOnLand;
    map['bedrooms'] = bedrooms;
    map['bathrooms'] = bathrooms;
    map['description'] = description;
    map['amenities'] = amenities;
    map['rules'] = rules;
    map['images'] = images;
    map['tenancyAgreement'] = tenancyAgreement;
    map['parkInDuration'] = parkInDuration;
    map['isVerified'] = isVerified;
    map['isApproved'] = isApproved;
    map['isFrozen'] = isFrozen;
    map['createdAt'] = createdAt;
    map['deletedAt'] = deletedAt;
    if (fees != null) {
      map['Fees'] = fees?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['User'] = user?.toJson();
    }
    map['rentalStatus'] = rentalStatus;
    map['listingVerificationStatus'] = listingVerificationStatus;
    map['extendedValidationStatus'] = extendedValidationStatus;
    return map;
  }

}


class User {
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.showContactInfo,
    this.profileImage,
    this.email,
  });

  User.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    showContactInfo = json['showContactInfo'];
    profileImage = json['profileImage'];
    email = json['email'];
  }
  String? userId;
  String? firstName;
  String? lastName;
  bool? showContactInfo;
  dynamic phoneNumber;
  String? profileImage;
  String? email;
  User copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    dynamic phoneNumber,
    String? profileImage,
    String? email,
  }) =>
      User(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileImage: profileImage ?? this.profileImage,
        email: email ?? this.email,
        showContactInfo: showContactInfo ?? this.showContactInfo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phoneNumber'] = phoneNumber;
    map['profileImage'] = profileImage;
    map['email'] = email;
    map['showContactInfo'] = showContactInfo;
    return map;
  }
}

class Fees {
  Fees({
    this.feeId,
    this.listingId,
    this.feeType,
    this.amount,
  });

  Fees.fromJson(dynamic json) {
    feeId = json['feeId'];
    listingId = json['listingId'];
    feeType = json['feeType'];
    amount = json['amount'];
  }
  String? feeId;
  String? listingId;
  String? feeType;
  num? amount;
  Fees copyWith({
    String? feeId,
    String? listingId,
    String? feeType,
    num? amount,
  }) =>
      Fees(
        feeId: feeId ?? this.feeId,
        listingId: listingId ?? this.listingId,
        feeType: feeType ?? this.feeType,
        amount: amount ?? this.amount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feeId'] = feeId;
    map['listingId'] = listingId;
    map['feeType'] = feeType;
    map['amount'] = amount;
    return map;
  }
}
