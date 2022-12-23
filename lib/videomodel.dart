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
    required this.type,
    required this.youtubeid,
  });
  late final String id;
  late final String name;
  late final String type;
  late final String youtubeid;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    youtubeid = json['youtubeid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['youtubeid'] = youtubeid;
    return _data;
  }
}