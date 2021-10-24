// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inherited_star.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InheritedStar _$InheritedStarFromJson(Map<String, dynamic> json) {
  return InheritedStar(
    json['UUID'] as String,
    Rectangle3D.fromJson(json['boundaryRectangle'] as Map<String, dynamic>),
    name: json['name'],
    prototypeNode: PrototypeNode.prototypeNodeFromJson(
        json['prototypeNodeUUID'] as String),
    constraints: json['constraints'] == null
        ? null
        : PBIntermediateConstraints.fromJson(
            json['constraints'] as Map<String, dynamic>),
  )
    ..subsemantic = json['subsemantic'] as String
    ..auxiliaryData = json['style'] == null
        ? null
        : IntermediateAuxiliaryData.fromJson(
            json['style'] as Map<String, dynamic>)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$InheritedStarToJson(InheritedStar instance) =>
    <String, dynamic>{
      'subsemantic': instance.subsemantic,
      'UUID': instance.UUID,
      'constraints': instance.constraints,
      'boundaryRectangle': Rectangle3D.toJson(instance.frame),
      'style': instance.auxiliaryData,
      'name': instance.name,
      'prototypeNodeUUID': instance.prototypeNode,
      'type': instance.type,
    };