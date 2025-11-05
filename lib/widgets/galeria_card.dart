import 'package:app_demo/screens/screens.dart';

class GaleriaCard extends StatelessWidget {
  const GaleriaCard({
    super.key,
    required this.titulo,
    required this.subTitulo,
    required this.url,
    required this.objectNumber,
    required this.context,
  });

  final String titulo;
  final String subTitulo;
  final String url;
  final String objectNumber;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(5),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          url.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/loadingImg.gif'),
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset('assets/images/Image_not_available.png'),
          Container(
            //padding: const  EdgeInsets.all(20),
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    handler.numeroObjeto = objectNumber;
                    handler.paginaActual = 3;
                  },
                  child: Text(
                    titulo,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subTitulo,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
