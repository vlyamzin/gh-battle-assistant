// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenProvider _$HomeScreenProviderFromJson(Map<String, dynamic> json) {
  return HomeScreenProvider(
    monsters: (json['monsters'] as List<dynamic>?)
        ?.map((e) => UnitStack.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HomeScreenProviderToJson(HomeScreenProvider instance) =>
    <String, dynamic>{
      'monsters': instance.monsters.map((e) => e.toJson()).toList(),
    };
