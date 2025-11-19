import 'package:app_demo/screens/screens.dart';

class ArtistaNoElegido extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final double? iconSize;

  const ArtistaNoElegido({
    Key? key,
    this.message,
    this.icon,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.person_outline,
            size: iconSize ?? 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'No has seleccionado ningún artista',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
