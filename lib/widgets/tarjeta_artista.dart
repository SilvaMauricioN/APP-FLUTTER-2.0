import 'package:app_demo/screens/screens.dart';

class TarjetaArtista extends StatelessWidget {
  final Artista artista;
  final VoidCallback? onTap;
  final double alto;
  final double imageSize;

  const TarjetaArtista({
    Key? key,
    required this.artista,
    this.onTap,
    this.alto = 100,
    this.imageSize = 100,
  }) : super(key: key);

  String _getFechas() {
    if (artista.dateOfBirth.isNotEmpty && artista.dateOfDeath.isNotEmpty) {
      return '${artista.dateOfBirth} - ${artista.dateOfDeath}';
    } else if (artista.dateOfBirth.isNotEmpty) {
      return artista.dateOfBirth;
    } else if (artista.dateOfDeath.isNotEmpty) {
      return artista.dateOfDeath;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: alto,
      constraints: BoxConstraints(minHeight: alto),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen del artista
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    image: const DecorationImage(
                      image: AssetImage("assets/images/colosal.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      artista.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getFechas(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: const Icon(
                    Icons.burst_mode_outlined,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
