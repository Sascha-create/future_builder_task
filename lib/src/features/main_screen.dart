import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // TODO: initiate controllers --> erledigt
  // }

  TextEditingController zipController = TextEditingController();

  Future<String> zipFuture = Future.value("Ergebnis: Noch keine PLZ gesucht");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: zipController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {
                  // TODO: implementiere Suche --> erledigt
                  setState(() {
                    zipFuture = getCityFromZip(zipController.text);
                  });
                },
                child: const Text("Suche"),
              ),
              const SizedBox(height: 32),
              FutureBuilder(
                future: zipFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text("Error");
                    } else if (snapshot.hasData) {
                      final String zip = snapshot.data ?? "keine Ort gefunden";

                      return Text("Ergebnis: $zip",
                          style: Theme.of(context).textTheme.labelLarge);
                    }
                  }
                  return const Text("Unbekannter Fehler");
                },
              )
              // Text("Ergebnis: Noch keine PLZ gesucht",
              //     style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: dispose controllers  <-- nichts hilfreiches zu dispose gefunden

    zipController.dispose();

    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
