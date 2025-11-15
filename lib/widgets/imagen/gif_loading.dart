import 'package:app_demo/screens/screens.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/loading.gif',
        width: 350,
        height: 350,
      ),
    );
  }
}
