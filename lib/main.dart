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
        scaffoldBackgroundColor: const Color(0xffe74c3c),
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
  final TextEditingController _hourlyBrutController = TextEditingController();
  final TextEditingController _monthlyBrutController = TextEditingController();
  final TextEditingController _annualyBrutController = TextEditingController();
  final TextEditingController _hourlyNetController = TextEditingController();
  final TextEditingController _monthlyNetController = TextEditingController();
  final TextEditingController _annualyNetController = TextEditingController();

  final TextEditingController _monthlyNetTaxController =
      TextEditingController();
  final TextEditingController _annualyNetTaxController =
      TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  void _updateTextFields() {
    _monthlyBrutController.text = (double.parse(_hourlyBrutController.text) *
            (35 * 52 / 12) *
            (_workHoursSliderValue / 100))
        .round()
        .toString();
    _annualyBrutController.text =
        (double.parse(_monthlyBrutController.text) * (12 + _radioMonthNb))
            .round()
            .toString();
    _hourlyNetController.text = (double.parse(_hourlyBrutController.text) *
            ((_radioStatus == 0)
                ? 0.78
                : (_radioStatus == 1)
                    ? 0.75
                    : (_radioStatus == 2)
                        ? 0.85
                        : (_radioStatus == 3)
                            ? 0.55
                            : (_radioStatus == 4)
                                ? 0.49
                                : 0))
        .toStringAsFixed(2)
        .toString();

    _monthlyNetController.text =
        (double.parse(_hourlyNetController.text) * (35 * 52 / 12))
            .round()
            .toString();
    _annualyNetController.text =
        (double.parse(_monthlyNetController.text) * (12 + _radioMonthNb))
            .round()
            .toString();

    _monthlyNetTaxController.text = (double.parse(_monthlyNetController.text) *
            (1 - (_rateSliderValue / 100)))
        .round()
        .toString();
    _annualyNetTaxController.text =
        (double.parse(_monthlyNetTaxController.text) * (12 + _radioMonthNb))
            .round()
            .toString();
  }

  // Radio buttons
  int _radioStatus = 0;

  void _handleStatusRadioButtons(int? value) {
    setState(() {
      _radioStatus = value ?? 0;
    });

    _updateTextFields();
  }

  int _radioMonthNb = 0;

  void _handleMonthNbRadioButtons(int? value) {
    setState(() {
      _radioMonthNb = value ?? 0;
    });

    _updateTextFields();
  }

  // Sliders
  double _workHoursSliderValue = 100;
  double _rateSliderValue = 0;

  @override
  void initState() {
    super.initState();

    _hourlyBrutController.text = '0';
    _monthlyBrutController.text = '0';
    _annualyBrutController.text = '0';
    _hourlyNetController.text = '0';
    _monthlyNetController.text = '0';
    _annualyNetController.text = '0';
    _monthlyNetTaxController.text = '0';
    _annualyNetTaxController.text = '0';

    _nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Calcul Du Salaire Brut En Net',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTitle('INDIQUEZ VOTRE SALAIRE BRUT'),
                                buildTextField(
                                    _hourlyBrutController, 'Horaire brut', ''),
                                buildTextField(
                                    _monthlyBrutController,
                                    'Mensuel brut',
                                    (_radioStatus == 0)
                                        ? 'Non-cadre -22%'
                                        : (_radioStatus == 1)
                                            ? 'Cadre -25%'
                                            : (_radioStatus == 2)
                                                ? 'Public -15%'
                                                : (_radioStatus == 3)
                                                    ? 'Indé -45%'
                                                    : (_radioStatus == 4)
                                                        ? 'Port -51%'
                                                        : ''),
                                buildTextField(
                                    _annualyBrutController, 'Annuel brut', ''),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTitle('RÉSULTAT DE VOTRE SALAIRE NET'),
                                buildTextField(
                                    _hourlyNetController, 'Horaire net', ''),
                                buildTextField(
                                    _monthlyNetController, 'Mensuel net', ''),
                                buildTextField(
                                    _annualyNetController, 'Annuel net', ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildTitle('SÉLECTIONNEZ VOTRE STATUT :'),
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildRadio('Salarié non-cadre', 0, _radioStatus,
                                _handleStatusRadioButtons),
                            buildRadio('Salarié \n cadre', 1, _radioStatus,
                                _handleStatusRadioButtons),
                            buildRadio('Fonction publique', 2, _radioStatus,
                                _handleStatusRadioButtons),
                            buildRadio('Profession libérale', 3, _radioStatus,
                                _handleStatusRadioButtons),
                            buildRadio('Portage salarial', 4, _radioStatus,
                                _handleStatusRadioButtons),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitle('SÉLECTIONNEZ VOTRE TEMPS DE TRAVAIL : ' +
                          _workHoursSliderValue.round().toString() +
                          '%'),
                      buildSlider(10, 100, 9, 0),
                      buildTitle(
                          'SÉLECTIONNEZ LE NOMBRE DE MOIS DE PRIME CONVENTIONNELLE :'),
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildRadio('12 mois', 0, _radioMonthNb,
                                _handleMonthNbRadioButtons),
                            buildRadio('13 mois', 1, _radioMonthNb,
                                _handleMonthNbRadioButtons),
                            buildRadio('14 mois', 2, _radioMonthNb,
                                _handleMonthNbRadioButtons),
                            buildRadio('15 mois', 3, _radioMonthNb,
                                _handleMonthNbRadioButtons),
                            buildRadio('16 mois', 4, _radioMonthNb,
                                _handleMonthNbRadioButtons),
                          ],
                        ),
                      ),
                      buildTitle(
                          'SÉLECTIONNEZ LE TAUX DE PRÉLÈVEMENT À LA SOURCE : ' +
                              _rateSliderValue.toStringAsFixed(1).toString() +
                              '%'),
                      buildSlider(0, 43, 86, 1),
                      buildTitle(
                          'ESTIMATION DE VOTRE SALAIRE NET APRÈS LE PRÉLÈVEMENT À LA SOURCE'),
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: buildTextField(_monthlyNetTaxController,
                                  'Mensuel net après impôts', '')),
                          Flexible(
                              flex: 1,
                              child: buildTextField(_annualyNetTaxController,
                                  'Annuel net après impôts', '')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            _hourlyBrutController.text = '0';
                            _monthlyBrutController.text = '0';
                            _annualyBrutController.text = '0';
                            _hourlyNetController.text = '0';
                            _monthlyNetController.text = '0';
                            _annualyNetController.text = '0';
                            _monthlyNetTaxController.text = '0';
                            _annualyNetTaxController.text = '0';
                          },
                          child: const Text('EFFACER LES CHAMPS'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildSlider(double min, double max, int divisions, int value) {
    return Card(
      child: Slider(
        value: (value == 0) ? _workHoursSliderValue : _rateSliderValue,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: (newValue) {
          _updateTextFields();

          setState(() {
            if (value == 0) {
              _workHoursSliderValue = newValue;
            } else {
              _rateSliderValue = newValue;
            }
          });
        },
      ),
    );
  }

  Padding buildRadio(var label, int value, int valueGroup, callback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Radio(
            value: value,
            groupValue: valueGroup,
            onChanged: callback,
          ),
          SizedBox(
            width: 70,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xffe74c3c),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTitle(var title) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: Colors.white),
      ),
    );
  }

  Padding buildTextField(
      TextEditingController controller, var label, var chipText) {
    OutlineInputBorder inputBorder() {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0,
        ),
      );
    }

    OutlineInputBorder focusBorder() {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                if (chipText != "")
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Text(
                          chipText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffe74c3c),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: TextFormField(
              controller: controller,
              onChanged: (text) => _updateTextFields(),
              decoration: InputDecoration(
                border: inputBorder(),
                enabledBorder: inputBorder(),
                focusedBorder: focusBorder(),
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
