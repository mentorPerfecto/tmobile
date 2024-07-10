/// userId : "541cb4c8-3302-4f2e-bde4-64c64856f34f"
/// accountNumber : "6315195768"
/// accountName : "NO ACCOUNT NAME FOUND"
/// bankName : "ZENITH MOBILE"
/// bankCode : "932"

class LandlordBankData {
  LandlordBankData(
      {this.userId,
      this.accountNumber,
      this.accountName,
      this.bankName,
      this.bankCode,
      this.isApproved});

  LandlordBankData.fromJson(dynamic json) {
    userId = json['userId'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    bankName = json['bankName'];
    bankCode = json['bankCode'];
    isApproved = json['isApproved'];
  }
  String? userId;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? bankCode;
  bool? isApproved;

  LandlordBankData copyWith({
    String? userId,
    String? accountNumber,
    String? accountName,
    String? bankName,
    String? bankCode,
    bool? isApproved,
  }) =>
      LandlordBankData(
        userId: userId ?? this.userId,
        accountNumber: accountNumber ?? this.accountNumber,
        accountName: accountName ?? this.accountName,
        bankName: bankName ?? this.bankName,
        bankCode: bankCode ?? this.bankCode,
        isApproved: isApproved ?? this.isApproved,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['accountNumber'] = accountNumber;
    map['accountName'] = accountName;
    map['bankName'] = bankName;
    map['bankCode'] = bankCode;
    map['isApproved'] = isApproved;
    return map;
  }
}
