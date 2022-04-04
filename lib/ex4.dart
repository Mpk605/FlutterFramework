import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewJobOfferPage(),
    );
  }
}

class NewJobOfferPage extends StatefulWidget {
  const NewJobOfferPage({Key? key}) : super(key: key);

  @override
  State<NewJobOfferPage> createState() => _CreateNewJobOfferPageState();
}

class _CreateNewJobOfferPageState extends State<NewJobOfferPage> {
  // TextEditControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  var _nameValidate = false;
  var _salaryValidate = false;

  int _radioStatus = 0;

  void _handleStatusRadioButtons(int? value) {
    setState(() {
      _radioStatus = value ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Job Offer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Entreprise',
                      errorText:
                          (_nameValidate) ? 'Veuillez entrer un nom' : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Entreprise',
                      errorText:
                          (_nameValidate) ? 'Veuillez entrer un nom' : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: TextFormField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Salaire Annuel Brut',
                      errorText: (_salaryValidate)
                          ? 'Veuillez entrer un salaire'
                          : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(
                        Icons.euro_symbol,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioStatus,
                      onChanged: _handleStatusRadioButtons,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cadre (25%)',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Radio(
                      value: 1,
                      groupValue: _radioStatus,
                      onChanged: _handleStatusRadioButtons,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Non cadre (22%)',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: _detailsController,
                  minLines: 4,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        _nameValidate = true;
                      }

                      if (_salaryController.text.isEmpty) {
                        _salaryValidate = true;
                      }
                    },
                    child: const Text("Valider"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice 4'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Your job history is empty',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewJobOfferPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
