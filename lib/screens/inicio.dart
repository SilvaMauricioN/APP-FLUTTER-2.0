import 'package:app_demo/screens/screens.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => __InicioState();
}

class __InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/colosal.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          titulo(),
          boton(),
        ],
      ),
    );
  }

  Widget titulo() {
    return const Text(
      'Museo Rijks',
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget boton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'Navegacion');
        },
        style: ElevatedButton.styleFrom(
          //backgroundColor: Colors.amber[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 20.0,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        child: const Text(
          "INICIAR",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
