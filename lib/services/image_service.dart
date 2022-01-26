import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';

enum IconSize { s32, s64, s128 }

class ImageService {
  static const unitImageBaseUrl = 'assets/unit_images/';
  static const unitIconBaseUrl = 'assets/unit_icons/';
  static const iconsBaseUrl = 'assets/images/icons';
  static const mainBackground = 'assets/images/home_bg.png';
  static const headerBackground = 'assets/images/header_bg.jpg';
  static const cardBackground = 'assets/images/ability_front_2.jpg';
  static const actionCardBackground = 'assets/images/action_front.png';
  static const actionCardBackgroundLeftPart =
      'assets/images/action_front_left_part.png';
  static const initiativeBackground = 'assets/images/initiative_bg.png';

  static final _unitImageMap = <UnitType, String>{
    UnitType.ancientArtillery:
        '${ImageService.unitImageBaseUrl}Ancient-Artillery-214x300.jpg',
    UnitType.banditArcher:
        '${ImageService.unitImageBaseUrl}Bandit-Archer-214x300.jpg',
    UnitType.banditGuard:
        '${ImageService.unitImageBaseUrl}Bandit-Guard-214x300.jpg',
    UnitType.banditLeader:
        '${ImageService.unitImageBaseUrl}Bandit-Leader-214x300.jpg',
    UnitType.blackImp: '${ImageService.unitImageBaseUrl}Black-Imp-214x300.jpg',
    UnitType.caveBear: '${ImageService.unitImageBaseUrl}Cave-Bear-214x300.jpg',
    UnitType.cityArcher:
        '${ImageService.unitImageBaseUrl}City-Archer-214x300.jpg',
    UnitType.cityGuard:
        '${ImageService.unitImageBaseUrl}City-Guard-214x300.jpg',
    UnitType.cultist: '${ImageService.unitImageBaseUrl}Cultist-214x300.jpg',
    UnitType.darkRider:
        '${ImageService.unitImageBaseUrl}Dark-Rider-small-214x300.jpg',
    UnitType.deepTerror:
        '${ImageService.unitImageBaseUrl}Deep-Terror-214x300.jpg',
    UnitType.earthDemon:
        '${ImageService.unitImageBaseUrl}Earth-Demon-214x300.jpg',
    UnitType.elderDrake:
        '${ImageService.unitImageBaseUrl}Elder-Drake-214x300.jpg',
    UnitType.flameDemon:
        '${ImageService.unitImageBaseUrl}Flame-Demon-214x300.jpg',
    UnitType.forestImp:
        '${ImageService.unitImageBaseUrl}Forest-Sprite-214x300.jpg',
    UnitType.frostDemon:
        '${ImageService.unitImageBaseUrl}Frost-Demon-214x300.jpg',
    UnitType.giantViper:
        '${ImageService.unitImageBaseUrl}Giant-Viper-214x300.jpg',
    UnitType.guardCaptain:
        '${ImageService.unitImageBaseUrl}Guard-Captain-214x300.jpg',
    UnitType.harrowerInfester:
        '${ImageService.unitImageBaseUrl}Harrower-Infester-214x300.jpg',
    UnitType.hound: '${ImageService.unitImageBaseUrl}Hound-214x300.jpg',
    UnitType.inoxArcher:
        '${ImageService.unitImageBaseUrl}Inox-Archer-214x300.jpg',
    UnitType.inoxBodyguard:
        '${ImageService.unitImageBaseUrl}Inox-Bodyguard-214x300.jpg',
    UnitType.inoxGuard:
        '${ImageService.unitImageBaseUrl}Inox-Guard-214x300.jpg',
    UnitType.inoxShaman:
        '${ImageService.unitImageBaseUrl}Inox-Shaman-214x300.jpg',
    UnitType.jekserah: '${ImageService.unitImageBaseUrl}Jekserah-214x300.jpg',
    UnitType.livingBones:
        '${ImageService.unitImageBaseUrl}Skeleton-214x300.jpg',
    UnitType.livingCorpse: '${ImageService.unitImageBaseUrl}Zombie-214x300.jpg',
    UnitType.livingSpirit: '${ImageService.unitImageBaseUrl}Ghost-214x300.jpg',
    UnitType.lurker: '${ImageService.unitImageBaseUrl}Lurker-214x300.jpg',
    UnitType.mercilessOverseer:
        '${ImageService.unitImageBaseUrl}Merciless-Overseer-214x300.jpg',
    UnitType.nightDemon:
        '${ImageService.unitImageBaseUrl}Night-Demon-214x300.jpg',
    UnitType.ooze: '${ImageService.unitImageBaseUrl}Ooze-214x300.jpg',
    UnitType.primeDemon:
        '${ImageService.unitImageBaseUrl}Prime-Demon-214x300.jpg',
    UnitType.rendingDrake:
        '${ImageService.unitImageBaseUrl}Vicious-Drake-214x300.jpg',
    UnitType.savassIcestorm:
        '${ImageService.unitImageBaseUrl}Savvas-Icestorm-214x300.jpg',
    UnitType.savassLavaflow:
        '${ImageService.unitImageBaseUrl}Savvas-Lavaflow-214x300.jpg',
    UnitType.spiritDrake:
        '${ImageService.unitImageBaseUrl}Spitting-Drake-214x300.jpg',
    UnitType.stoneGolem:
        '${ImageService.unitImageBaseUrl}Stone-Golem-214x300.jpg',
    UnitType.sunDemon: '${ImageService.unitImageBaseUrl}Sun-Demon-214x300.jpg',
    UnitType.bertayer:
        '${ImageService.unitImageBaseUrl}The-Bertayer-214x300.jpg',
    UnitType.colorless:
        '${ImageService.unitImageBaseUrl}The-Colorless-214x300.jpg',
    UnitType.gloom: '${ImageService.unitImageBaseUrl}The-Gloom-214x300.jpg',
    UnitType.sightlessEye:
        '${ImageService.unitImageBaseUrl}The-Sightless-Eye-214x300.jpg',
    UnitType.vermlingScout:
        '${ImageService.unitImageBaseUrl}Vermling-Scout-214x300.jpg',
    UnitType.vermlingShaman:
        '${ImageService.unitImageBaseUrl}Vermling-Shaman-214x300.jpg',
    UnitType.windDemon:
        '${ImageService.unitImageBaseUrl}Wind-Demon-214x300.jpg',
    UnitType.wingedHorror:
        '${ImageService.unitImageBaseUrl}Winged-Horror-214x300.jpg',
  };

  static final _unitPortraitMap = <UnitType, Map<UnitNormality, String>>{
    UnitType.ancientArtillery: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Ancient_Artillery_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Ancient_Artillery_elite_256.png',
    },
    UnitType.banditArcher: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Bandit_Archer_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Bandit_Archer_elite_256.png',
    },
    UnitType.banditGuard: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Bandit_Guard_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Bandit_Guard_elite_256.png',
    },
    UnitType.jekserah: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Jekserah_boss_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Jekserah_boss_256.png',
    },
    UnitType.livingBones: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Living_Bones_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Living_Bones_elite_256.png',
    },
    UnitType.cultist: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Cultist_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Cultist_elite_256.png',
    },
    UnitType.nightDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Night_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Night_Demon_elite_256.png',
    },
    UnitType.livingCorpse: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Living_Corpse_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Living_Corpse_elite_256.png',
    },
    UnitType.ooze: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Ooze_normal_256.png',
      UnitNormality.elite: '${ImageService.unitIconBaseUrl}Ooze_elite_256.png',
    },
    UnitType.giantViper: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Giant_Viper_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Giant_Viper_elite_256.png',
    },
    UnitType.livingSpirit: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Living_Spirit_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Living_Spirit_elite_256.png',
    },
    UnitType.caveBear: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Cave_Bear_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Cave_Bear_elite_256.png',
    },
    UnitType.frostDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Frost_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Frost_Demon_elite_256.png',
    },
    UnitType.harrowerInfester: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Harrower_Infester_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Harrower_Infester_elite_256.png',
    },
    UnitType.cityGuard: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}City_Guard_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}City_Guard_elite_256.png',
    },
    UnitType.cityArcher: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}City_Archer_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}City_Archer_elite_256.png',
    },
    UnitType.inoxGuard: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Inox_Guard_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Inox_Guard_elite_256.png',
    },
    UnitType.inoxArcher: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Inox_Archer_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Inox_Archer_elite_256.png',
    },
    UnitType.vermlingScout: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Vermling_Scout_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Vermling_Scout_elite_256.png',
    },
    UnitType.vermlingShaman: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Vermling_Shaman_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Vermling_Shaman_elite_256.png',
    },
    UnitType.flameDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Flame_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Flame_Demon_elite_256.png',
    },
    UnitType.earthDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Earth_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Earth_Demon_elite_256.png',
    },
    UnitType.windDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Wind_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Wind_Demon_elite_256.png',
    },
    UnitType.sunDemon: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Sun_Demon_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Sun_Demon_elite_256.png',
    },
    UnitType.forestImp: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Forest_Imp_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Forest_Imp_elite_256.png',
    },
    UnitType.hound: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Hound_normal_256.png',
      UnitNormality.elite: '${ImageService.unitIconBaseUrl}Hound_elite_256.png',
    },
    UnitType.stoneGolem: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Stone_Golem_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Stone_Golem_elite_256.png',
    },
    UnitType.rendingDrake: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Rending_Drake_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Rending_Drake_elite_256.png',
    },
    UnitType.blackImp: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Black_Imp_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Black_Imp_elite_256.png',
    },
    UnitType.deepTerror: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Deep_Terror_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Deep_Terror_elite_256.png',
    },
    UnitType.lurker: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Lurker_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Lurker_elite_256.png',
    },
    UnitType.savassIcestorm: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Savvas_Icestorm_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Savvas_Icestorm_elite_256.png',
    },
    UnitType.savassLavaflow: {
      UnitNormality.normal:
          '${ImageService.unitIconBaseUrl}Savvas_Lavaflow_normal_256.png',
      UnitNormality.elite:
          '${ImageService.unitIconBaseUrl}Savvas_Lavaflow_elite_256.png',
    },
    // UnitType.banditLeader: '${ImageService.unitIconBaseUrl}Bandit-Leader-214x300.jpg',
    // UnitType.blackImp: '${ImageService.unitIconBaseUrl}Black-Imp-214x300.jpg',
    // UnitType.caveBear: '${ImageService.unitIconBaseUrl}Cave-Bear-214x300.jpg',
    // UnitType.cityArcher: '${ImageService.unitIconBaseUrl}City-Archer-214x300.jpg',
    // UnitType.cityGuard: '${ImageService.unitIconBaseUrl}City-Guard-214x300.jpg',
    // UnitType.darkRider: '${ImageService.unitIconBaseUrl}Dark-Rider-small-214x300.jpg',
    // UnitType.deepTerror: '${ImageService.unitIconBaseUrl}Deep-Terror-214x300.jpg',
    // UnitType.earthDemon: '${ImageService.unitIconBaseUrl}Earth-Demon-214x300.jpg',
    // UnitType.elderDrake: '${ImageService.unitIconBaseUrl}Elder-Drake-214x300.jpg',
    // UnitType.flameDemon: '${ImageService.unitIconBaseUrl}Flame-Demon-214x300.jpg',
    // UnitType.forestImp: '${ImageService.unitIconBaseUrl}Forest-Sprite-214x300.jpg',
    // UnitType.frostDemon: '${ImageService.unitIconBaseUrl}Frost-Demon-214x300.jpg',
    // UnitType.giantViper: '${ImageService.unitIconBaseUrl}Giant-Viper-214x300.jpg',
    // UnitType.guardCaptain: '${ImageService.unitIconBaseUrl}Guard-Captain-214x300.jpg',
    // UnitType.harrowerInfester: '${ImageService.unitIconBaseUrl}Harrower-Infester-214x300.jpg',
    // UnitType.hound: '${ImageService.unitIconBaseUrl}Hound-214x300.jpg',
    // UnitType.inoxArcher: '${ImageService.unitIconBaseUrl}Inox-Archer-214x300.jpg',
    // UnitType.inoxBodyguard: '${ImageService.unitIconBaseUrl}Inox-Bodyguard-214x300.jpg',
    // UnitType.inoxGuard: '${ImageService.unitIconBaseUrl}Inox-Guard-214x300.jpg',
    // UnitType.inoxShaman: '${ImageService.unitIconBaseUrl}Inox-Shaman-214x300.jpg',
    // UnitType.livingSpirit: '${ImageService.unitIconBaseUrl}Ghost-214x300.jpg',
    // UnitType.lurker: '${ImageService.unitIconBaseUrl}Lurker-214x300.jpg',
    // UnitType.mercilessOverseer: '${ImageService.unitIconBaseUrl}Merciless-Overseer-214x300.jpg',
    // UnitType.ooze: '${ImageService.unitIconBaseUrl}Ooze-214x300.jpg',
    // UnitType.primeDemon: '${ImageService.unitIconBaseUrl}Prime-Demon-214x300.jpg',
    // UnitType.rendingDrake: '${ImageService.unitIconBaseUrl}Vicious-Drake-214x300.jpg',
    // UnitType.savassIcestorm: '${ImageService.unitIconBaseUrl}Savvas-Icestorm-214x300.jpg',
    // UnitType.savassLavaflow: '${ImageService.unitIconBaseUrl}Savvas-Lavaflow-214x300.jpg',
    // UnitType.spiritDrake: '${ImageService.unitIconBaseUrl}Spitting-Drake-214x300.jpg',
    // UnitType.stoneGolem: '${ImageService.unitIconBaseUrl}Stone-Golem-214x300.jpg',
    // UnitType.sunDemon: '${ImageService.unitIconBaseUrl}Sun-Demon-214x300.jpg',
    // UnitType.bertayer: '${ImageService.unitIconBaseUrl}The-Bertayer-214x300.jpg',
    // UnitType.colorless: '${ImageService.unitIconBaseUrl}The-Colorless-214x300.jpg',
    // UnitType.gloom: '${ImageService.unitIconBaseUrl}The-Gloom-214x300.jpg',
    // UnitType.sightlessEye: '${ImageService.unitIconBaseUrl}The-Sightless-Eye-214x300.jpg',
    // UnitType.vermlingScout: '${ImageService.unitIconBaseUrl}Vermling-Scout-214x300.jpg',
    // UnitType.vermlingShaman: '${ImageService.unitIconBaseUrl}Vermling-Shaman-214x300.jpg',
    // UnitType.windDemon: '${ImageService.unitIconBaseUrl}Wind-Demon-214x300.jpg',
    // UnitType.wingedHorror: '${ImageService.unitIconBaseUrl}Winged-Horror-214x300.jpg',
  };

  static final _iconsMap32 = <String, String>{
    'ae': '$iconsBaseUrl/32/all_elements_32.png',
    'atk': '$iconsBaseUrl/32/attack_32.png',
    'dark': '$iconsBaseUrl/32/dark_32.png',
    'fire': '$iconsBaseUrl/32/fire_32.png',
    'frost': '$iconsBaseUrl/32/frost_32.png',
    'heal': '$iconsBaseUrl/32/heal_32.png',
    'sfr': '$iconsBaseUrl/32/suffer_32.png',
    'ha': '$iconsBaseUrl/32/hit_area_32.png',
    'jmp': '$iconsBaseUrl/32/jump_32.png',
    'leaf': '$iconsBaseUrl/32/leaf_32.png',
    'light': '$iconsBaseUrl/32/light_32.png',
    'lt': '$iconsBaseUrl/32/loot_32.png',
    'mv': '$iconsBaseUrl/32/move_32.png',
    'nha': '$iconsBaseUrl/32/neutral_hit_area_32.png',
    'ndark': '$iconsBaseUrl/32/no_dark_32.png',
    'ne': '$iconsBaseUrl/32/no_elements_32.png',
    'nfire': '$iconsBaseUrl/32/no_fire_32.png',
    'nfrost': '$iconsBaseUrl/32/no_frost_32.png',
    'nleaf': '$iconsBaseUrl/32/no_leaf_32.png',
    'nlight': '$iconsBaseUrl/32/no_light_32.png',
    'nwind': '$iconsBaseUrl/32/no_wind_32.png',
    'rng': '$iconsBaseUrl/32/range_32.png',
    'rtlt': '$iconsBaseUrl/32/retaliate_32.png',
    'shld': '$iconsBaseUrl/32/shield_32.png',
    'wind': '$iconsBaseUrl/32/wind_32.png',
    'bless': '$iconsBaseUrl/32/bless_32.png',
    'crs': '$iconsBaseUrl/32/curse_32.png',
    'darm': '$iconsBaseUrl/32/disarm_32.png',
    'fl': '$iconsBaseUrl/32/flight_32.png',
    'imbz': '$iconsBaseUrl/32/immobilize_32.png',
    'inv': '$iconsBaseUrl/32/invis_32.png',
    'mud': '$iconsBaseUrl/32/muddle_32.png',
    'prc': '$iconsBaseUrl/32/pierce_32.png',
    'poi': '$iconsBaseUrl/32/poison_32.png',
    'pull': '$iconsBaseUrl/32/pull_32.png',
    'push': '$iconsBaseUrl/32/push_32.png',
    'str': '$iconsBaseUrl/32/strenght_32.png',
    'stn': '$iconsBaseUrl/32/stun_32.png',
    'trgt': '$iconsBaseUrl/32/target_32.png',
    'wnd': '$iconsBaseUrl/32/wound_32.png',
    'xp': '$iconsBaseUrl/32/xp_32.png',
    '1r': '$iconsBaseUrl/area/1_round.png',
    '1rg': '$iconsBaseUrl/area/1_round_grey.png',
    '1rgv2': '$iconsBaseUrl/area/1_round_grey_v2.png',
    '3lg': '$iconsBaseUrl/area/3_line_grey.png',
    '3p': '$iconsBaseUrl/area/3_points.png',
    '3pg': '$iconsBaseUrl/area/3_points_grey.png',
    '4lg': '$iconsBaseUrl/area/4_line_grey.png',
    '4lgv2': '$iconsBaseUrl/area/4_line_grey_v2.png',
    '4pg': '$iconsBaseUrl/area/4_points_grey.png',
    '4pgv2': '$iconsBaseUrl/area/4_points_grey_v2.png',
    '6lg': '$iconsBaseUrl/area/6_line_grey.png',
    '6pg': '$iconsBaseUrl/area/6_points_grey.png',
  };

  static final _iconsMap64 = <String, String>{
    'ae': '$iconsBaseUrl/64/all_elements_64.png',
    'atk': '$iconsBaseUrl/64/attack_64.png',
    'dark': '$iconsBaseUrl/64/dark_64.png',
    'fire': '$iconsBaseUrl/64/fire_64.png',
    'frost': '$iconsBaseUrl/64/frost_64.png',
    'heal': '$iconsBaseUrl/64/heal_64.png',
    'sfr': '$iconsBaseUrl/64/suffer_64.png',
    'ha': '$iconsBaseUrl/64/hit_area_64.png',
    'jmp': '$iconsBaseUrl/64/jump_64.png',
    'leaf': '$iconsBaseUrl/64/leaf_64.png',
    'light': '$iconsBaseUrl/64/light_64.png',
    'lt': '$iconsBaseUrl/64/loot_64.png',
    'mv': '$iconsBaseUrl/64/move_64.png',
    'nha': '$iconsBaseUrl/64/neutral_hit_area_64.png',
    'ndark': '$iconsBaseUrl/64/no_dark.png',
    'ne': '$iconsBaseUrl/64/no_elements_64.png',
    'nfire': '$iconsBaseUrl/64/no_fire_64.png',
    'nfrost': '$iconsBaseUrl/64/no_frost_64.png',
    'nleaf': '$iconsBaseUrl/64/no_leaf_64.png',
    'nlight': '$iconsBaseUrl/64/no_light_64.png',
    'nwind': '$iconsBaseUrl/64/no_wind_64.png',
    'rng': '$iconsBaseUrl/64/range_64.png',
    'rtlt': '$iconsBaseUrl/64/retaliate_64.png',
    'shld': '$iconsBaseUrl/64/shield_64.png',
    'wind': '$iconsBaseUrl/64/wind_64.png',
    'bless': '$iconsBaseUrl/64/bless_64.png',
    'crs': '$iconsBaseUrl/64/curse_64.png',
    'darm': '$iconsBaseUrl/64/disarm_64.png',
    'fl': '$iconsBaseUrl/64/flight_64.png',
    'imbz': '$iconsBaseUrl/64/immobilize_64.png',
    'inv': '$iconsBaseUrl/64/invis_64.png',
    'mud': '$iconsBaseUrl/64/muddle_64.png',
    'prc': '$iconsBaseUrl/64/pierce_64.png',
    'poi': '$iconsBaseUrl/64/poison_64.png',
    'pull': '$iconsBaseUrl/64/pull_64.png',
    'push': '$iconsBaseUrl/64/push_64.png',
    'str': '$iconsBaseUrl/64/strenght_64.png',
    'stn': '$iconsBaseUrl/64/stun_64.png',
    'trgt': '$iconsBaseUrl/64/target_64.png',
    'wnd': '$iconsBaseUrl/64/wound_64.png',
    'xp': '$iconsBaseUrl/64/xp_64.png',
  };

  // TODO remove as unused [99a4863a801df53df73aa20aa2fcab52]
  final _iconsMap128 = <String, String>{
    'ae': '$iconsBaseUrl/128/all_elements_128.png',
    'atk': '$iconsBaseUrl/128/attack_128.png',
    'dark': '$iconsBaseUrl/128/dark_128.png',
    'fire': '$iconsBaseUrl/128/fire_128.png',
    'frost': '$iconsBaseUrl/128/frost_128.png',
    'heal': '$iconsBaseUrl/128/heal_128.png',
    'ha': '$iconsBaseUrl/128/hit_area_128.png',
    'jmp': '$iconsBaseUrl/128/jump_128.png',
    'leaf': '$iconsBaseUrl/128/leaf_128.png',
    'light': '$iconsBaseUrl/128/light_128.png',
    'lt': '$iconsBaseUrl/128/loot_128.png',
    'mv': '$iconsBaseUrl/128/move_128.png',
    'nha': '$iconsBaseUrl/128/neutral_hit_area_128.png',
    'ndark': '$iconsBaseUrl/128/no_dark.png',
    'ne': '$iconsBaseUrl/128/no_elements_128.png',
    'nfire': '$iconsBaseUrl/128/no_fire_128.png',
    'nfrost': '$iconsBaseUrl/128/no_frost_128.png',
    'nleaf': '$iconsBaseUrl/128/no_leaf_128.png',
    'nlight': '$iconsBaseUrl/128/no_light_128.png',
    'nwind': '$iconsBaseUrl/128/no_wind_128.png',
    'rng': '$iconsBaseUrl/128/range_128.png',
    'rtlt': '$iconsBaseUrl/128/retaliate_128.png',
    'shld': '$iconsBaseUrl/128/shield_128.png',
    'wind': '$iconsBaseUrl/128/wind_128.png',
  };

  final _attackEffects32 = {
    ActivityType.attack: ImageService._iconsMap32['atk']!,
    ActivityType.heal: ImageService._iconsMap32['heal']!,
    ActivityType.suffer: ImageService._iconsMap32['sfr']!,
    ActivityType.pierce: ImageService._iconsMap32['prc']!,
    ActivityType.poison: ImageService._iconsMap32['poi']!,
    ActivityType.wound: ImageService._iconsMap32['wnd']!,
    ActivityType.disarm: ImageService._iconsMap32['darm']!,
    ActivityType.stun: ImageService._iconsMap32['stn']!,
    ActivityType.muddle: ImageService._iconsMap32['mud']!,
    ActivityType.curse: ImageService._iconsMap32['crs']!,
    ActivityType.bless: ImageService._iconsMap32['bless']!,
    ActivityType.strengthen: ImageService._iconsMap32['str']!,
    ActivityType.immobilize: ImageService._iconsMap32['imbz']!,
    ActivityType.invisible: ImageService._iconsMap32['inv']!,
    ActivityType.pull: ImageService._iconsMap32['pull']!,
    ActivityType.push: ImageService._iconsMap32['push']!,
    ActivityType.target: ImageService._iconsMap32['trgt']!,
  };

  final _attackEffects64 = {
    ActivityType.attack: ImageService._iconsMap64['atk']!,
    ActivityType.heal: ImageService._iconsMap64['heal']!,
    ActivityType.suffer: ImageService._iconsMap64['sfr']!,
    ActivityType.pierce: ImageService._iconsMap64['prc']!,
    ActivityType.poison: ImageService._iconsMap64['poi']!,
    ActivityType.wound: ImageService._iconsMap64['wnd']!,
    ActivityType.disarm: ImageService._iconsMap64['darm']!,
    ActivityType.stun: ImageService._iconsMap64['stn']!,
    ActivityType.muddle: ImageService._iconsMap64['mud']!,
    ActivityType.curse: ImageService._iconsMap64['crs']!,
    ActivityType.bless: ImageService._iconsMap64['bless']!,
    ActivityType.strengthen: ImageService._iconsMap64['str']!,
    ActivityType.immobilize: ImageService._iconsMap64['imbz']!,
    ActivityType.invisible: ImageService._iconsMap64['inv']!,
    ActivityType.pull: ImageService._iconsMap64['pull']!,
    ActivityType.push: ImageService._iconsMap64['push']!,
    ActivityType.target: ImageService._iconsMap64['trgt']!,
  };

  String getUnitImageByType(UnitType type) => _unitImageMap[type] ?? '';

  String getUnitPortraitByType(UnitType type, UnitNormality normality) =>
      _unitPortraitMap[type]?[normality] ?? '';

  Map<ActivityType, String> getAttackEffect([IconSize size = IconSize.s32]) {
    if (size == IconSize.s64)
      return _attackEffects64;
    else
      return _attackEffects32;
  }

  String getIcon(String key, [IconSize size = IconSize.s32]) {
    switch (size) {
      case IconSize.s32:
        {
          return _iconsMap32[key] ?? '';
        }
      case IconSize.s64:
        {
          return _iconsMap64[key] ?? '';
        }
      case IconSize.s128:
        {
          return _iconsMap128[key] ?? '';
        }
    }
  }
}
