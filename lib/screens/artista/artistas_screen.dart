import 'package:app_demo/screens/screens.dart';

class ArtistaScreen extends StatefulWidget {
  const ArtistaScreen({super.key});

  @override
  State<ArtistaScreen> createState() => _BuscadorState();
}

class _BuscadorState extends State<ArtistaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ArtistaProvider>(context, listen: false)
        .getColeccionArtistas());
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
          child: Builder(builder: (context) {
            if (artistaProvider.isLoading) {
              return const Loading();
            }
            if (artistaProvider.hasError) {
              return WidgetError(
                  errorMsg: artistaProvider.errorMessage ??
                      'Error al obtener los datos');
            }
            if (artistaProvider.listaArtistas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      artistaProvider.listaArtistas.isEmpty
                          ? 'No hay artistas'
                          : 'No se encontraron artistas',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                Visibility(
                  visible: !artistaProvider.isLoading,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                    ),
                    itemCount: artistaProvider.listaArtistas.length,
                    itemBuilder: (context, index) {
                      final artista = artistaProvider.listaArtistas[index];
                      return TarjetaArtista(
                        artista: artista,
                        onTap: () {
                          //handler.artistaSeleccionado = artista;
                          handler.artistaSeleccionado = artista.name;
                          handler.editarArtista(artista);
                          handler.paginaActual = 2;
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }),
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: "Buscar Artista",
            hintText: "Buscar Artista",
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.blue,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
          ),
          enabled: !provider.isLoading,
        ),
      ),
    );
  }
}
