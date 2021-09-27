import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:provider/provider.dart';

class ActivitySelector extends StatelessWidget {
  const ActivitySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UnitStatsProvider>();

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: provider.availableActivities
              .map(
                (activity) => GestureDetector(
                  onTap: () => provider.selectActivity(activity),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(5),
                    child: Image(
                      image: AssetImage(
                        activity.value,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
