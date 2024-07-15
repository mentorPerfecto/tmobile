class CryptoCoinResponse {
  Id? id;
  int? rate;
  String? symbol;

  CryptoCoinResponse({
    this.id,
    this.rate,
    this.symbol,
  });

  CryptoCoinResponse copyWith({
    Id? id,
    int? rate,
    String? symbol,
  }) {
    return CryptoCoinResponse(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'symbol': symbol,
    };
  }

  factory CryptoCoinResponse.fromJson(Map<String, dynamic> json) {
    return CryptoCoinResponse(
      id: json['id'] == null ? null : Id.fromJson(json['id'] as Map<String, dynamic>),
      rate: json['rate'] as int?,
      symbol: json['symbol'] as String?,
    );
  }

  @override
  String toString() => "CryptoCoinResponse(id: $id,rate: $rate,symbol: $symbol)";

  @override
  int get hashCode => Object.hash(id, rate, symbol);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rate == other.rate &&
          symbol == other.symbol;
}

class Id {
  String? name;
  String? acronym;

  Id({
    this.name,
    this.acronym,
  });

  Id copyWith({
    String? name,
    String? acronym,
  }) {
    return Id(
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'acronym': acronym,
    };
  }

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'] as String?,
      acronym: json['acronym'] as String?,
    );
  }

  @override
  String toString() => "Id(name: $name,acronym: $acronym)";

  @override
  int get hashCode => Object.hash(name, acronym);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Id &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          acronym == other.acronym;
}
