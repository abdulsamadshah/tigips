class AutoGenerate {
  AutoGenerate({
    required this.data,
  });
  late final List<Data> data;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.date,
    required this.file,
    required this.image,
  });
  late final String id;
  late final String name;
  late final String date;
  late final String file;
  late final String image;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    date = json['date'];
    file = json['file'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['date'] = date;
    _data['file'] = file;
    _data['image'] = image;
    return _data;
  }
}