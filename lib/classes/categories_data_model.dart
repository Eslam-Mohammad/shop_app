class CategoryModel {
  bool? status;
  CategoryDataModel? data;
  CategoryModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);

  }
}


class CategoryDataModel{
  List<CategoryDetails> data2 = [];
  CategoryDataModel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element){
      data2.add(CategoryDetails.fromJson(element));
    });
  }

}

class CategoryDetails{
  int? id;
  String? name;
  String? image;
  CategoryDetails.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}