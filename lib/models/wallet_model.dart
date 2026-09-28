class WalletModel {
  final String id;
  final double balance;
  final String currency;
  final int vipLevel;
  final double totalDeposited;
  final double totalWithdrawn;

  WalletModel({
    required this.id,
    required this.balance,
    required this.currency,
    required this.vipLevel,
    this.totalDeposited = 0.0,
    this.totalWithdrawn = 0.0,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      vipLevel: json['vipLevel'] ?? 0,
      totalDeposited: (json['totalDeposited'] ?? 0).toDouble(),
      totalWithdrawn: (json['totalWithdrawn'] ?? 0).toDouble(),
    );
  }

  WalletModel copyWith({
    String? id,
    double? balance,
    String? currency,
    int? vipLevel,
    double? totalDeposited,
    double? totalWithdrawn,
  }) {
    return WalletModel(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      vipLevel: vipLevel ?? this.vipLevel,
      totalDeposited: totalDeposited ?? this.totalDeposited,
      totalWithdrawn: totalWithdrawn ?? this.totalWithdrawn,
    );
  }
}
