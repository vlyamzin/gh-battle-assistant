part of 'unit_action_card.dart';

class CardTitle extends StatelessWidget with TextOutline {
  final String title;
  const CardTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 25, fontFamily: 'PirataOne'),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Consumer<UnitStack>(
              builder: (context, stack, _) {
                final action = stack.actions.currentAction ?? null;
                return Text(
                  action != null ? action.initiative.toString() : '',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PirataOne',
                    shadows: outlinedText(
                      strokeColor: Color(0xFFFFFFFF),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}