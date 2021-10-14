import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  int id;
  int userId;
  String date;
  List<Products> products;
  int iV;

  CartModel({this.id, this.userId, this.date, this.products, this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }

  @override
  List<Object> get props => [id, userId, date, products, iV];
}

class Products extends Equatable {
  int productId;
  int quantity;
  num productPrice;

  Products({this.productId, this.quantity,this.productPrice});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }

  @override
  List<Object> get props => [productId, quantity];
}
