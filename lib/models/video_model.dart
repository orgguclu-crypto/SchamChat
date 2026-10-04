class VideoItem {
  final String id;
  final String userName;
  final String handle;
  final String profileImage;
  final String caption;
  final String music;
  final String location;
  final String thumbnailUrl;
  final int likes;
  final int comments;
  final int shares;
  final bool isVerified;

  const VideoItem({
    required this.id,
    required this.userName,
    required this.handle,
    required this.profileImage,
    required this.caption,
    required this.music,
    required this.location,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isVerified = false,
  });
}

class LiveRoom {
  final String id;
  final String title;
  final String hostName;
  final String thumbnailUrl;
  final int viewers;
  final bool isHot;

  const LiveRoom({
    required this.id,
    required this.title,
    required this.hostName,
    required this.thumbnailUrl,
    required this.viewers,
    this.isHot = false,
  });
}

class CasinoGame {
  final String id;
  final String title;
  final String subtitle;
  final String accent;
  final double jackpot;
  final String icon;

  const CasinoGame({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.jackpot,
    required this.icon,
  });
}
