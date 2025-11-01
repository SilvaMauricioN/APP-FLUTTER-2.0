import 'package:app_demo/screens/screens.dart';

class GaleriaArtista extends StatelessWidget {
  const GaleriaArtista({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final museumService = Provider.of<MuseumService>(context, listen: false);
    String artista = handler.artistaSeleccionado;

    return FutureBuilder<List<Obra>>(
      future: museumService.getObrasPorArtista(artista),
      builder: (BuildContext context, AsyncSnapshot<List<Obra>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          // Manejo de errores
          return Text('Error: ${snapshot.error}');
        } else {
          // Si la llamada a la API es exitosa
          List<Obra> listaObras = snapshot.data!;

          return Column(
            children: <Widget>[
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      'ARTISTA',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        artista,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listaObras.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullScreen(
                                url: listaObras[index].webImage.url,
                                context: context)));
                      },
                      child: Hero(
                        tag: 'imageHero$index',
                        child: GaleriaCard(
                            titulo: listaObras[index].title,
                            subTitulo: listaObras[index].longTitle,
                            url: listaObras[index].webImage.url,
                            objectNumber: listaObras[index].objectNumber,
                            context: context),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
      },
    );
  }
}
