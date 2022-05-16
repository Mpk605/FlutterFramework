import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  double _sliderValue = 0;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Entreprise',
                                errorText: (_nameValidate)
                                    ? 'Veuillez entrer un nom'
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "SÉLECTIONNEZ VOTRE STATUT :",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Card(
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
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                  Card(
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
                  Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Entreprise',
                            errorText: (_nameValidate)
                                ? 'Veuillez entrer un nom'
                                : null,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Entreprise',
                            errorText: (_nameValidate)
                                ? 'Veuillez entrer un nom'
                                : null,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
