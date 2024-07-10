class BackgroundCheckResponse {
  BackgroundCheckResponse({
      this.result, 
      this.misc,});

  BackgroundCheckResponse.fromJson(dynamic json) {
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
BackgroundCheckResponse copyWith({  List<Result>? result,
  Misc? misc,
}) => BackgroundCheckResponse(  result: result ?? this.result,
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
      this.backgroundCheckTokenId, 
      this.userId, 
      this.listingId, 
      this.tenantId, 
      this.tokenValue, 
      this.status, 
      this.reason, 
      this.createdAt, 
      this.listing, 
      this.tenant,});

  Result.fromJson(dynamic json) {
    backgroundCheckTokenId = json['backgroundCheckTokenId'];
    userId = json['userId'];
    listingId = json['listingId'];
    tenantId = json['tenantId'];
    tokenValue = json['tokenValue'];
    status = json['status'];
    reason = json['reason'];
    createdAt = json['createdAt'];
    listing = json['Listing'];
    tenant = json['Tenant'];
  }
  String? backgroundCheckTokenId;
  String? userId;
  String? listingId;
  dynamic tenantId;
  String? tokenValue;
  String? status;
  String? reason;
  String? createdAt;
  dynamic listing;
  dynamic tenant;
Result copyWith({  String? backgroundCheckTokenId,
  String? userId,
  String? listingId,
  dynamic tenantId,
  String? tokenValue,
  String? status,
  String? reason,
  String? createdAt,
  dynamic listing,
  dynamic tenant,
}) => Result(  backgroundCheckTokenId: backgroundCheckTokenId ?? this.backgroundCheckTokenId,
  userId: userId ?? this.userId,
  listingId: listingId ?? this.listingId,
  tenantId: tenantId ?? this.tenantId,
  tokenValue: tokenValue ?? this.tokenValue,
  status: status ?? this.status,
  reason: reason ?? this.reason,
  createdAt: createdAt ?? this.createdAt,
  listing: listing ?? this.listing,
  tenant: tenant ?? this.tenant,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backgroundCheckTokenId'] = backgroundCheckTokenId;
    map['userId'] = userId;
    map['listingId'] = listingId;
    map['tenantId'] = tenantId;
    map['tokenValue'] = tokenValue;
    map['status'] = status;
    map['reason'] = reason;
    map['createdAt'] = createdAt;
    map['Listing'] = listing;
    map['Tenant'] = tenant;
    return map;
  }

}