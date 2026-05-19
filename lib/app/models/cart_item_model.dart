class CartItem {
  int? dbId;
  final String gameId;
  final String gameName;
  final String? backgroundImage;
  final double? rating;
  int quantity;
  final String username;

  CartItem({
    this.dbId,
    required this.gameId,
    required this.gameName,
    this.backgroundImage,
    this.rating,
    required this.quantity,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': dbId,                         
      'game_id': gameId,
      'game_name': gameName,
      'background_image': backgroundImage,
      'rating': rating,
      'quantity': quantity,
      'username': username,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      dbId: map['id'],
      gameId: map['game_id'],
      gameName: map['game_name'],
      backgroundImage: map['background_image'],
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      quantity: map['quantity'],
      username: map['username'],
    );
  }
}