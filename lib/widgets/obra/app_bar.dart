import 'package:app_demo/screens/screens.dart';

class ObraAppBar extends StatelessWidget {
  final ObraDetalle obraDetalle;

  const ObraAppBar({super.key, required this.obraDetalle});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen
            obraDetalle.webImage?.url.isNotEmpty ?? false
                ? FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/loadingImg.gif'),
                    image: NetworkImage(
                        obraDetalle.webImage!.url), //obraDetalle.webImage!.url
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/Image_not_available.png',
                    fit: BoxFit.cover,
                  ),
          ],
        ),
      ),
    );
  }
}
