import 'package:equatable/equatable.dart';

class PhysicalActivityTypeModel extends Equatable {
  final String type;

  const PhysicalActivityTypeModel({
    required this.type,
  });

  @override
  List<Object> get props => [type];

  @override
  bool get stringify => true;
}
