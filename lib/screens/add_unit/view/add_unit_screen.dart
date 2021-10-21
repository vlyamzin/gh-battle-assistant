import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:gh_battle_assistant/screens/add_unit/view/unit_number_selector.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/screens/add_unit/view/unit_search_input.dart';
import 'package:provider/provider.dart';

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
                              child: ElevatedButton(
                                  onPressed: () => null,
                                  child: const Text('randomize')),
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
}
