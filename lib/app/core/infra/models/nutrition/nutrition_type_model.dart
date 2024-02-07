import 'package:equatable/equatable.dart';

class ListNutritionsModel extends Equatable {
  final String type;
  final List<String> list;

  const ListNutritionsModel({
    required this.type,
    required this.list,
  });

  @override
  List<Object> get props => [type, list];

  @override
  bool get stringify => true;

  factory ListNutritionsModel.fromMap(Map<String, dynamic> map) {
    return ListNutritionsModel(
      type: map['type'],
      list: map['nutrition'],
    );
  }
}
