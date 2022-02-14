part of 'unit_action_card.dart';

class UnitActionCardBackSide extends StatelessWidget with CardBorderRadius {
  static const imagePath = 'assets/images/ability_back.jpg';
  final VoidCallback backButtonCallback, deleteButtonCallback;
  final String title;
  final List<BackSideButton>? buttons;

  const UnitActionCardBackSide({
    Key? key,
    required this.backButtonCallback,
    required this.deleteButtonCallback,
    required this.title,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Stack(
        children: [
          _backgroundImage(),
          _title(),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(getRadius()),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget _title() {
    return SizedBox.expand(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Builder(
            builder: (BuildContext context) {
              return Text(
                title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PirataOne',
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(offset: Offset(1.5, 1.5), color: Color(0xFF333333))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _actionButtons() {
    var buttonsWidget = buttons ?? [];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BackSideButton(
            icon: Icons.arrow_back_rounded,
            action: backButtonCallback,
          ),
          ...buttonsWidget,
          BackSideButton(
            icon: Icons.delete_rounded,
            action: deleteButtonCallback,
          ),
        ],
      ),
    );
  }
}
