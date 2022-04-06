part of 'rosas_model.dart';

class RosasTopic extends Equatable {
  String name;

  RosasTopic(this.name);

  factory RosasTopic.fromJSON(Map<String, dynamic> json) {
    return RosasTopic(json['name']);
  }

  Map<String, dynamic> toJSON() {
    return {'name': name};
  }

  @override
  List<Object?> get props => [name];
}
