import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ex3.g.dart';

@HiveType(typeId: 2)
class JobOffer {
  JobOffer(
      {required this.companyName,
      required this.salary,
      required this.status,
      required this.details});

  @HiveField(0)
  String companyName;

  @HiveField(1)
  int salary;

  @HiveField(2)
  int status; // 0 -> cadre, 1 -> non cadre

  @HiveField(3)
  String details;

  @override
  String toString() {
    return companyName;
  }
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JobOfferAdapter());
  await Hive.openBox('jobOffers');
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
      home: const MyHomePage(title: 'Exercice 3'),
    );
  }
}

class NewJobOfferPage extends StatefulWidget {
  const NewJobOfferPage(
      {Key? key,
      required this.companyName,
      required this.annualSalary,
      required this.status,
      required this.details,
      required this.position})
      : super(key: key);

  final String companyName;
  final int annualSalary;
  final int status;
  final String details;
  final int position;

  @override
  State<NewJobOfferPage> createState() => _CreateNewJobOfferPageState();
}

class _CreateNewJobOfferPageState extends State<NewJobOfferPage> {
  // TextEditControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _annualSalaryController = TextEditingController();
  final TextEditingController _monthlySalaryController =
      TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  var _nameValidate = false;
  var _annualSalaryValidate = false;
  var _monthlySalaryValidate = false;

  // Hive
  late Box _box;

  int _radioStatus = 0;

  void _handleStatusRadioButtons(int? value) {
    _monthlySalaryController.text = ((int.parse(_annualSalaryController.text) *
                ((value == 0) ? 0.75 : 0.78)) /
            12)
        .toString();

    setState(() {
      _radioStatus = value ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _box = Hive.box("jobOffers");
    _radioStatus = widget.status;

    _nameController.text = widget.companyName;
    _annualSalaryController.text = widget.annualSalary.toString();
    _monthlySalaryController.text =
        ((widget.annualSalary * ((widget.status == 0) ? 0.75 : 0.78)) / 12)
            .toString();
    _detailsController.text = widget.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle offre de Job'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Entreprise',
                  errorText: (_nameValidate) ? 'Veuillez entrer un nom' : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: TextFormField(
                          controller: _annualSalaryController,
                          onChanged: (text) {
                            _monthlySalaryController.text = ((int.parse(text) *
                                        ((_radioStatus == 0) ? 0.75 : 0.78)) /
                                    12)
                                .toString();
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'Salaire Annuel Brut',
                            errorText: (_annualSalaryValidate)
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: TextFormField(
                          controller: _monthlySalaryController,
                          onChanged: (text) {
                            _annualSalaryController.text = ((int.parse(text) /
                                        ((_radioStatus == 0) ? 0.75 : 0.78)) *
                                    12)
                                .toString();
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'Salaire Mensuel Net',
                            errorText: (_monthlySalaryValidate)
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
                  ],
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

                      if (_annualSalaryController.text.isEmpty) {
                        _annualSalaryValidate = true;
                      }

                      if (_nameController.text.isNotEmpty &&
                          _annualSalaryController.text.isNotEmpty) {
                        if (widget.position == -1) {
                          _box.add(JobOffer(
                              companyName: _nameController.text,
                              salary: int.parse(_annualSalaryController.text),
                              status: _radioStatus,
                              details: _detailsController.text));
                        } else {
                          _box.putAt(
                              widget.position,
                              JobOffer(
                                  companyName: _nameController.text,
                                  salary:
                                      int.parse(_annualSalaryController.text),
                                  status: _radioStatus,
                                  details: _detailsController.text));
                        }
                        Navigator.pop(context);
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
  final HashMap _displayDetails = HashMap<String, bool>();

  // Hive
  late Box _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box("jobOffers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice 3'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_box.length != 0)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _box.length,
                      itemBuilder: (BuildContext context, int position) {
                        JobOffer jobOffer = _box.getAt(position);
                        return _buildJobOfferCard(
                            jobOffer.companyName,
                            jobOffer.salary,
                            jobOffer.status,
                            jobOffer.details,
                            position);
                      },
                    ),
                  ),
                ),
              if (_box.length == 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Vous n'avez aucun jobs",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NewJobOfferPage(
                    companyName: "",
                    annualSalary: 0,
                    status: 0,
                    details: "",
                    position: -1)),
          ).then((value) => {
                setState(() {
                  _box = Hive.box("jobOffers");
                })
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter nouveau job'),
      ),
    );
  }

  Card _buildJobOfferCard(
    _companyName,
    _annualSalary,
    _status,
    _details,
    _position,
  ) {
    var _monthlySalary = (_annualSalary * ((_status == 0) ? 0.75 : 0.78)) / 12;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: const Color(0xffe7e0ec),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                _companyName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Salaire brut annuel : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$_annualSalary€',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Salaire net mensuel : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$_monthlySalary€',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Statut proposé : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (_status == 0) ? 'Cadre (25%)' : 'Non cadre (22%)',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      if (_displayDetails[_companyName] ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Details : ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _details,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Voulez vous vraiment supprimer ce job ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    _box.deleteAt(_position);
                                                    setState(() {
                                                      _box =
                                                          Hive.box('jobOffers');
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Oui'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Non'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete_outlined,
                                    ),
                                    label: const Text('Supprimer'),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewJobOfferPage(
                                              companyName: _companyName,
                                              annualSalary: _annualSalary,
                                              status: _status,
                                              details: _details,
                                              position: _position),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                    label: const Text('Modifier'),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 30,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _displayDetails[_companyName] =
                        (_displayDetails[_companyName] != null)
                            ? !_displayDetails[_companyName]
                            : true;
                  });
                },
                icon: (_displayDetails[_companyName] ?? false)
                    ? const Icon(Icons.expand_less_outlined)
                    : const Icon(Icons.expand_more_outlined),
                label: const Text(""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
