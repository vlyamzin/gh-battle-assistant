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
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'PirataOne',
                shadows: outlinedText(
                  strokeColor: Color(0x10FFFFFF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
