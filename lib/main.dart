import 'package:app_demo/screens/screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PaginaHandler()),
      ChangeNotifierProvider(create: (context) => ObraProvider()),
      ChangeNotifierProvider(create: (context) => ArtistaProvider()),
      ChangeNotifierProvider(create: (context) => ObraDetalleProvider()),
      ChangeNotifierProvider(create: (context) => OcupacionProvider()),
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(isDarkMode: false)),
    ],
    child: const MyApp(),
  ));
  await dotenv.load(fileName: ".env");
  //const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App Museo',
      theme: Provider.of<ThemeProvider>(context, listen: true).temaActual,
      initialRoute: 'Inicio',
      routes: {
        'Inicio': (context) => const Inicio(),
        'Navegacion': (context) => const Navegacion()
      },
    );
  }
}
