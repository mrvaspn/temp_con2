import 'package:flutter/material.dart';
import 'service.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final temperatureService = TemperatureService();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter temperature in celcius",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some value";
                }

                return null;
              },
              controller: myController,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      double celcius = double.parse(myController.text);
                      double fahrenheit = temperatureService.convertTemperature(celcius); // Utilize the TemperatureService

                      return AlertDialog(
                        content: Text("$celcius Celsius in Fahrenheit is $fahrenheit"),
                      );
                    },
                  );
                },
                child: const Text("Enter"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
