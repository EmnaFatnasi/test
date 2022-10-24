import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class SortingEmployees extends StatefulWidget {
  const SortingEmployees({Key? key}) : super(key: key);

  @override
  State<SortingEmployees> createState() => _SortingEmployeesState();
}

class _SortingEmployeesState extends State<SortingEmployees> {
  final textEditingController = TextEditingController();
  String message = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String verifyEmployeeIdentification(String id) {
    var msg = "";

    if (id.length != 10) {
      msg = "Veuillez vérifier l'identifiant $id!";
    } else {
      int i = 0;
      while (msg.isEmpty && i < 10) {
        if (i == 0 || i == 9) {
          if (isAlpha(id[i]) == false || isUppercase(id[i]) == false) {
            msg =
                "Un identifiant doit commencer et terminet par une lettre majuscule!";
            break;
          }
        } else {
          if (isNumeric(id[i]) == false) {
            msg =
                "L'identifiant doit avoir huit chiffres entre les deux lettres!";
            break;
          }
        }
        i++;
      }
    }
    return msg;
  }

  void sortEmployees() {
    List<String> result = textEditingController.text.split(' ');

    for (int i = 0; i < result.length; i++) {
      setState(() {
        message = verifyEmployeeIdentification(result[i]);
      });
      if (message.isNotEmpty) break;
    }

    result.sort((a, b) {
      return a[9].compareTo(b[9]);
    });

    result.sort((a, b) {
      return a[0].compareTo(b[0]);
    });

    for (int i = 0; i < result.length - 1; i++) {
      // if : le code ASCII du dernier caractère de result[i] est supérieur au code ASCII du dernier caractère de result[i+1], 
      // on fait une permutation
      // else if : ils sont égaux on compare les chiffres 
      // else:  on passe.
      if (result[i].codeUnitAt(9) > result[i + 1].codeUnitAt(9) &&
          result[i].codeUnitAt(0) == result[i + 1].codeUnitAt(0)) {
        var aux = result[i];
        result[i] = result[i + 1];
        result[i + 1] = aux;
        break;
  
      } else if (result[i].codeUnitAt(9) == result[i + 1].codeUnitAt(9) &&
          result[i].codeUnitAt(0) == result[i + 1].codeUnitAt(0)) {
        for (int k = 0; k < result[i].length; k++) {
          if (result[i].codeUnitAt(k) < result[i + 1].codeUnitAt(k)) {
            var aux = result[i];
            result[i] = result[i + 1];
            result[i + 1] = aux;
            break;
          }
        }
        break;
      } else {
        break;
      }
    }

    message = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    labelText: "Entrer la liste d'identification des employés"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sortEmployees();
              },
              child: const Text(
                'Tier',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Text(message)
          ],
        ),
      ),
    ));
  }
}
