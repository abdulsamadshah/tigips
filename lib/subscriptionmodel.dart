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
    required this.amount,
  });
  late final String id;
  late final String amount;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['amount'] = amount;
    return _data;
  }
}