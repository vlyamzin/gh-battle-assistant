import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/direct_select/widget.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

import '../../../di.dart';

class AddUnitScreen extends StatefulWidget {
  final EnemiesBloc enemiesBloc;
  const AddUnitScreen({
    Key? key,
    required this.enemiesBloc,
  }) : super(key: key);

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddUnitCubit(di<EnemiesRepository>(), widget.enemiesBloc),
      child: Builder(
        builder: (context) {
          return CupertinoPageScaffold(
            navigationBar: _navBar(context),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImageService.cardBackground),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: BlocConsumer<AddUnitCubit, AddUnitState>(
                  listener: (context, state) {
                    if (state is UnitAddedS) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    Widget levelSelector = Container();

                    if (state is UnitTypeSelectedS) {
                      var showLevelSelector = context
                          .read<AddUnitCubit>()
                          .displayLevelSelector(state.stack);
                      levelSelector = showLevelSelector
                          ? _unitLevelSelector(context)
                          : Container();
                    }

                    if (state is AddUnitInitial || state is FilteredUnitsS) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: UnitSearchInput(),
                      );
                    } else {
                      return Builder(builder: (context) {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                UnitSearchInput(),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: UnitNumberSelector(),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: SizedBox(
                                width: 120,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    levelSelector,
                                    ElevatedButton(
                                        onPressed: () => context
                                            .read<AddUnitCubit>()
                                            .shuffleUnits(),
                                        child: const Text('randomize')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        onPressed: () => Navigator.pop(context),
      ),
      middle: Text('Add Unit'),
      trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () => context.read<AddUnitCubit>().saveSelection(),
          child: Text('Add')),
    );
  }

  Widget _unitLevelSelector(BuildContext context) {
    final unitLevels = context.read<AddUnitCubit>().unitLevels;

    return Container(
      child: BlocSelector<AddUnitCubit, AddUnitState, int?>(
        selector: (state) {
          return state.maybeWhen(
              selectedUnitType: (_, int unitLevel) {
                return unitLevel;
              },
              orElse: () => null);
        },
        builder: (context, level) {
          if (level == null) return Container();

          return DirectSelect(
            width: 120,
            height: 250,
            child: SizedBox(
              height: 60,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text('Level ${level.toString()}'),
                ),
              ),
            ),
            items: unitLevels.map((l) {
              return SizedBox(
                height: 60,
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: Text(
                      'Level ${l.toString()}',
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                  ),
                ),
              );
            }).toList(),
            selectedIndex: unitLevels[level],
            onSelectedItemChanged: (int? item) {
              if (item != null)
                context.read<AddUnitCubit>().changeUnitLevel(item);
            },
            itemExtent: 35,
          );
        },
      ),
    );
  }
}
