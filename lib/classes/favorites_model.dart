class StatusModelForFavorites{
 bool? status;




  StatusModelForFavorites.fromJson(Map<String, dynamic> json){

    status = json['status'];


  }
}


class FavoritesModel //to receive get favorites data
{
  bool? status;
  String? message;
  DataModelForFavorites? data;

  FavoritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModelForFavorites.fromJson(json['data']);
  }
}

class DataModelForFavorites{
  List<FavoritesProducts>? data2 = [];

  DataModelForFavorites.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element) {
      data2?.add(FavoritesProducts.fromJson(element));
    });
  }
}

class FavoritesProducts{
  int? id ;
  num? price;
  num? oldPrice;
  num ?discount;
  String? image;
  String? name;
  String?description;
  FavoritesProducts.fromJson(Map<String, dynamic> json){
    id = json['product']['id'];
    price = json['product']['price'];
    oldPrice = json['product']['old_price'];
    discount = json['product']['discount'];
    image = json['product']['image'];
    name = json['product']['name'];
    description = json['product']['description'];
  }



}