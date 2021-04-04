import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/data/utils/database_helper.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:sqflite/sqflite.dart';

class DataCartRepository extends CartRepository {
  static DataCartRepository _instance = DataCartRepository._internal();

  DataCartRepository._internal() {}

  factory DataCartRepository() => _instance;

  @override
  Future<void> addProductToCart(ProductEntity product) async {
    final Database db = await DatabaseHelper().getDatabase();
    CartItemMapper cartItem = await findItem(product.id, CartItemMapper.COUPON);
    if (cartItem == null)
      await db.insert('cart_items', CartItemMapper.withProduct(product).toMap());
    else{
      cartItem.quantity +=1;
      await db.update('cart_items',
          cartItem.toMap(), where: 'id = ?', whereArgs: [product.id]);
    }

  }

  @override
  Future<List<CartItemMapper>> getCartItems() async{
    final Database db = await DatabaseHelper().getDatabase();
    List<Map<String, dynamic>> cartItems = await db
        .query("cart_items");

    List<CartItemMapper> items = List<CartItemMapper>.from(cartItems
        .map((e) => CartItemMapper.createFromMap(e)).toList());
    return items;
  }

  @override
  Future<void> removeCouponFromCart(CartItemMapper coupon) async{
    final Database db = await DatabaseHelper().getDatabase();
    await db.delete('cart_items', where: 'id = ?', whereArgs: [coupon.productId]);
  }

  @override
  Future<CartItemMapper> findItem(int id, String type) async {
    final Database db = await DatabaseHelper().getDatabase();
    List<Map<String, dynamic>> cartItems = await db
        .query("cart_items", where: "id=? AND type=?", whereArgs: [id, type]);

    if(cartItems.length == 0){
      return null;
    }
    return
      cartItems
          .map((e) => CartItemMapper.createFromMap(e)).first;
  }

  @override
  Future<int> getQuantity() async {
    final Database db = await DatabaseHelper().getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT SUM(quantity) as quantity FROM cart_items'));
  }
}
