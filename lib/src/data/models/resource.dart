import 'package:json_annotation/json_annotation.dart';

part 'resource.g.dart';

@JsonSerializable()
class Resource {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantone_value;

  Resource({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantone_value
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);

}