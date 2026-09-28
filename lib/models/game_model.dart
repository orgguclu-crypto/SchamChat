class GameModel {
  final String id;
  final String name;
  final String type; // slot, wheel, fishing, card, board
  final String description;
  final double minBet;
  final double maxBet;
  final String? thumbnail;

  GameModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.minBet,
    required this.maxBet,
    this.thumbnail,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? 'slot',
      description: json['description'] ?? '',
      minBet: (json['minBet'] ?? 1).toDouble(),
      maxBet: (json['maxBet'] ?? 1000).toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
