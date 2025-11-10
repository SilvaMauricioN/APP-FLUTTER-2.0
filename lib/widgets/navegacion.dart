import 'package:app_demo/screens/screens.dart';

class Navegacion extends StatefulWidget {
  const Navegacion({super.key});
  @override
  State<Navegacion> createState() => _NavegacionBar();
}

class _NavegacionBar extends State<Navegacion> {
  static const List<Widget> _widgetOptions = <Widget>[
    GaleriaObrasScreen(),
    ArtistaScreen(),
    ObrasArtistaScreen(),
    ObraDetalleScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PaginaHandler>(context, listen: true);

    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text(
          'Museo Risjk',
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(page.paginaActual),
        //_selectedIndex
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            label: 'Galeria',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            activeIcon: Icon(
              Icons.search,
            ),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            activeIcon: Icon(
              Icons.person,
            ),
            label: 'Artista',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
            ),
            activeIcon: Icon(
              Icons.image,
            ),
            label: 'Cuadro',
          ),
        ],
        currentIndex: page.paginaActual,
        onTap: (value) {
          page.paginaActual = value;
        },
        iconSize: 20,
      ),
    );
  }
}
