class RoomModel {
  final String id;
  final String name;
  final String description;
  final int currentUsers;
  final int maxUsers;
  final String category;
  final bool isLive;
  final String? thumbnail;
  final String? creatorId;

  RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.currentUsers,
    required this.maxUsers,
    required this.category,
    required this.isLive,
    this.thumbnail,
    this.creatorId,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      currentUsers: json['currentUsers'] ?? 0,
      maxUsers: json['maxUsers'] ?? 10,
      category: json['category'] ?? 'talk',
      isLive: json['isLive'] ?? false,
      thumbnail: json['thumbnail'],
      creatorId: json['creatorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'currentUsers': currentUsers,
      'maxUsers': maxUsers,
      'category': category,
      'isLive': isLive,
      'thumbnail': thumbnail,
      'creatorId': creatorId,
    };
  }
}
