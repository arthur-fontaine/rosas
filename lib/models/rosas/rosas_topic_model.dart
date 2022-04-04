part of 'rosas_model.dart';

class RosasTopic {
  String name;

  RosasTopic(this.name);

  factory RosasTopic.fromJSON(Map<String, dynamic> json) {
    return RosasTopic(json['name']);
  }

  Map<String, dynamic> toJSON() {
    return {'name': name};
  }
}
