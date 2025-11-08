import 'package:app_demo/screens/screens.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  bool isLoading = true;
  late List<Artista> listaArtistas = [];
  List<Artista> estadoInicial = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ArtistaProvider>(context, listen: false).fetchArtistas());
  }

  @override
  Widget build(BuildContext context) {
    final artistaProvider = context.watch<ArtistaProvider>();
    final handler = Provider.of<PaginaHandler>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'ARTISTAS',
              ),
            ),
            buscadorWidget(artistaProvider),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Stack(
            children: [
              Visibility(
                visible: !artistaProvider.isLoading,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 5.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3,
                  ),
                  itemCount: artistaProvider.listaArtistas.length,
                  itemBuilder: (context, index) {
                    final artista = artistaProvider.listaArtistas[index];
                    return TarjetaArtista(
                      artista: artista,
                      onTap: () {
                        handler.artistaSeleccionado = artista.name;
                        handler.paginaActual = 2;
                      },
                    );
                  },
                ),
              ),
              Visibility(
                visible: artistaProvider.isLoading,
                child: const Loading(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buscadorWidget(ArtistaProvider provider) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: TextField(
          onChanged: provider.filtrarBusqueda,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            labelText: "Buscar",
            hintText: "Buscar",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          enabled: !provider.isLoading,
        ),
      ),
    );
  }
}
