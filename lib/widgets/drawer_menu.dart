import 'package:app_demo/screens/screens.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Drawer(
        child: Container(
          color: Colors.grey[850],
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(''),
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                title:
                    const Text('Salir', style: TextStyle(color: Colors.white)),
                trailing: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  exit(0);
                },
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                title:
                    const Text('Modo', style: TextStyle(color: Colors.white)),
                trailing: Switch(
                  value: themeProvider.temaActual == DefaultTheme.darkTheme,
                  onChanged: (value) {
                    if (value) {
                      themeProvider.setDark();
                    } else {
                      themeProvider.setLight();
                    }
                  },
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.white30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
