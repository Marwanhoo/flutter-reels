class ReelsModel {
  final int id;
  final int roomId;
  final String videoUrl;
  final String previewUrl;
  final String size;
  final String duration;
  final int likesCount;
  final String likesCountTranslated;
  final bool authLikeStatus;

  ReelsModel({
    required this.id,
    required this.roomId,
    required this.videoUrl,
    required this.previewUrl,
    required this.size,
    required this.duration,
    required this.likesCount,
    required this.likesCountTranslated,
    required this.authLikeStatus,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) {
    return ReelsModel(
      id: json['id'],
      roomId: json['room_id'],
      videoUrl: json['video'],
      previewUrl: json['preview'],
      size: json['size'],
      duration: json['duration'],
      likesCount: json['likes_count'],
      likesCountTranslated: json['likes_count_translated'],
      authLikeStatus: json['auth_like_status'],
    );
  }
}
