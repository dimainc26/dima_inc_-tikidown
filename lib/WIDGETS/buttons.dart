import 'package:tikidown/CORE/core.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    required this.text,
    required this.color,
    required this.onTap,
    super.key,
  });

  final String text;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text("-- ${text} --"),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    required this.onTap,
    required this.color,
    super.key,
  });

  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 80,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: SvgPicture.asset(
          search_icon,
          width: 45,
          colorFilter: const ColorFilter.mode(secondColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.onTap,
    required this.color,
    required this.text,
    super.key,
  });

  final Function() onTap;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 80,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(onPressed: onTap, child: Text("--  $text  --", style:const TextStyle(fontSize: 16), )),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
  }) : super(key: key);

  final Function() onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 8,
//      minWidth: width ?? MediaQuery.of(context).size.width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // side: borderSide,
        ),

        height: 75,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            Text(
              title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
