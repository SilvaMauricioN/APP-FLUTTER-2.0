import 'package:app_demo/screens/screens.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  static const String url =
      'https://cdn3.iconfinder.com/data/icons/people-activities-scenes/64/painting-512.png';
  bool isLoading = true;
  late List<Artistas> listaArtistas = [];
  List<Artistas> estadoInicial = [];
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  //obtengo los datos de la api, y la lista Future la asigno a una lista de Artista
  Future<void> initializeData() async {
    setState(() {
      isLoading = true;
    });

    final museumService = Provider.of<MuseumService>(context, listen: false);
    List<Artistas> artistasApi = await museumService.getArtistas();
    //comprueba si el widget todavia esta en el arbol de widdget,
    if (mounted) {
      setState(() {
        listaArtistas = List.from(artistasApi);
        estadoInicial = listaArtistas;
        isLoading = false;
      });
    }
  }

  void filtrarBusqueda(String datoIngresado) {
    List<Artistas> resultadosFiltrados = [];
    for (Artistas artista in listaArtistas) {
      if (artista.name.toLowerCase().contains(datoIngresado.toLowerCase())) {
        resultadosFiltrados.add(artista);
      }
    }
    setState(() {
      estadoInicial = resultadosFiltrados;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            buscadorWidget(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 5.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 3.8,
                  ),
                  itemCount: estadoInicial.length,
                  itemBuilder: (context, index) {
                    return TarjetaArtista(
                        nombre: estadoInicial[index].name, url: url);
                  },
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const Loading(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buscadorWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: TextField(
          onChanged: (value) {
            filtrarBusqueda(value);
          },
          decoration: const InputDecoration(
            labelText: "Buscar",
            hintText: "Buscar",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          enabled: !isLoading,
        ),
      ),
    );
  }
}
