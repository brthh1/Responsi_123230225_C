class Game {
  final String id;
  final String name;
  final String? released;
  final double? rating;
  final String? backgroundImage;
  final int? ratingsCount;
  final int? reviewsCount;
  final String? updatedAt;

  Game({
    required this.id,
    required this.name,
    this.released,
    this.rating,
    this.backgroundImage,
    this.ratingsCount,
    this.reviewsCount,
    this.updatedAt,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      released: json['released'],
      rating: (json['rating'] as num?)?.toDouble(),
      backgroundImage: json['background_image'],
      ratingsCount: json['ratings_count'],
      reviewsCount: json['reviews_count'],
      updatedAt: json['updated_at'],
    );
  }
}