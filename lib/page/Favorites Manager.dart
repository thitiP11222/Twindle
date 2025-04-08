// lib/services/favorite_manager.dart
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;

  FavoriteManager._internal();

  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addFavorite(Product product, Seller seller) {
    final exists = _favorites.any((item) => item['product'].productId == product.productId);
    if (!exists) {
      _favorites.add({'product': product, 'seller': seller});
    }
  }

  void removeFavorite(Product product) {
  _favorites.removeWhere((item) => item['product'].productId == product.productId);
}

bool isFavorite(Product product) {
  return _favorites.any((item) => item['product'].productId == product.productId);
}

}
