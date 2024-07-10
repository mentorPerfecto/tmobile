class TenantOnboardStatusResponse {
  TenantOnboardStatusResponse({
      this.result, 
      this.misc,});

  TenantOnboardStatusResponse.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    misc = json['misc'] != null ? Misc.fromJson(json['misc']) : null;
  }
  List<Result>? result;
  Misc? misc;
TenantOnboardStatusResponse copyWith({  List<Result>? result,
  Misc? misc,
}) => TenantOnboardStatusResponse(  result: result ?? this.result,
  misc: misc ?? this.misc,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    if (misc != null) {
      map['misc'] = misc?.toJson();
    }
    return map;
  }

}

class Misc {
  Misc({
      this.tokensGenerated, 
      this.tokensRemaining, 
      this.tokensUsed,});

  Misc.fromJson(dynamic json) {
    tokensGenerated = json['tokensGenerated'];
    tokensRemaining = json['tokensRemaining'];
    tokensUsed = json['tokensUsed'];
  }
  num? tokensGenerated;
  num? tokensRemaining;
  num? tokensUsed;
Misc copyWith({  num? tokensGenerated,
  num? tokensRemaining,
  num? tokensUsed,
}) => Misc(  tokensGenerated: tokensGenerated ?? this.tokensGenerated,
  tokensRemaining: tokensRemaining ?? this.tokensRemaining,
  tokensUsed: tokensUsed ?? this.tokensUsed,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tokensGenerated'] = tokensGenerated;
    map['tokensRemaining'] = tokensRemaining;
    map['tokensUsed'] = tokensUsed;
    return map;
  }

}

class Result {
  Result({
      this.listingTokenId, 
      this.userId, 
      this.listingId, 
      this.tenantId, 
      this.tokenValue, 
      this.status, 
      this.createdAt, 
      this.listing, 
      this.tenant,});

  Result.fromJson(dynamic json) {
    listingTokenId = json['listingTokenId'];
    userId = json['userId'];
    listingId = json['listingId'];
    tenantId = json['tenantId'];
    tokenValue = json['tokenValue'];
    status = json['status'];
    createdAt = json['createdAt'];
    listing = json['Listing'];
    tenant = json['Tenant'];
  }
  String? listingTokenId;
  String? userId;
  String? listingId;
  dynamic tenantId;
  String? tokenValue;
  String? status;
  String? createdAt;
  dynamic listing;
  dynamic tenant;
Result copyWith({  String? listingTokenId,
  String? userId,
  String? listingId,
  dynamic tenantId,
  String? tokenValue,
  String? status,
  String? createdAt,
  dynamic listing,
  dynamic tenant,
}) => Result(  listingTokenId: listingTokenId ?? this.listingTokenId,
  userId: userId ?? this.userId,
  listingId: listingId ?? this.listingId,
  tenantId: tenantId ?? this.tenantId,
  tokenValue: tokenValue ?? this.tokenValue,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
  listing: listing ?? this.listing,
  tenant: tenant ?? this.tenant,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['listingTokenId'] = listingTokenId;
    map['userId'] = userId;
    map['listingId'] = listingId;
    map['tenantId'] = tenantId;
    map['tokenValue'] = tokenValue;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['Listing'] = listing;
    map['Tenant'] = tenant;
    return map;
  }

}