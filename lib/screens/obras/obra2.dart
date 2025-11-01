import 'package:app_demo/screens/screens.dart';

class Obra2 extends StatelessWidget {
  const Obra2({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final museumService = Provider.of<MuseumService>(context, listen: false);
    String idObjeto = handler.numeroObjeto;

    return FutureBuilder<ObraDetalle>(
        future: museumService.getObraPorId(idObjeto),
        builder: (BuildContext context, AsyncSnapshot<ObraDetalle> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            ObraDetalle obraDetalle = snapshot.data!;

            return ListView(
              children: [
                obraDetalle.url.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(obraDetalle.url),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset('assets/images/Image_not_available.png'),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Titulos(
                      title: obraDetalle.title,
                      longTitle: obraDetalle.longTitle,
                      principalMaker: obraDetalle.principalMaker),
                ),
                divisor(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Detalles(
                    year: obraDetalle.dating.yearEarly.toString(),
                    physicalMedium: obraDetalle.physicalMedium,
                    productionPlaces: obraDetalle.productionPlaces.isNotEmpty
                        ? obraDetalle.productionPlaces[0]
                        : 'Undetermined',
                  ),
                ),
                divisor(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Descripcion(description: obraDetalle.description),
                ),
              ],
            );
          }
        });
  }

  Padding divisor() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 1,
        color: Colors.black,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
