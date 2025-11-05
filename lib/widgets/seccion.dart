import 'package:app_demo/screens/screens.dart';

class Seccion extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Widget child;
  final Color color;

  const Seccion(
      {super.key,
      required this.titulo,
      required this.icono,
      required this.child,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 0),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icono, color: color),
                  const SizedBox(width: 12),
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          )),
    );
  }
}
