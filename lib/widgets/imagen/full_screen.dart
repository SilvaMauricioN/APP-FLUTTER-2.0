import 'package:app_demo/screens/screens.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({
    super.key,
    required this.url,
    required this.context,
  });

  final String url;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Hero(
          tag: 'imageHero',
          child: url.isNotEmpty
          ? Image.network(
            url,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
          )
          : Image.asset(
            'assets/images/Image_not_available.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            ),
        ),
      ),
    );
  }
}