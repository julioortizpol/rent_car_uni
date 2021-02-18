import 'package:flutter/material.dart';
import 'package:open_source_pro/components/client/client_component.dart';
import 'package:open_source_pro/components/inspection/inspection_component.dart';
import 'package:open_source_pro/components/vehicles/vehicles_component.dart';
import 'package:open_source_pro/utilities/local_storage_web.dart';

import 'add_rent_and_return_component.dart';

class CreateRentComponent extends StatefulWidget {
  CreateRentComponent();

  @override
  _CreateRentComponentState createState() => _CreateRentComponentState();
}

class _CreateRentComponentState extends State<CreateRentComponent> {
  int currentStep = 0;
  bool complete = false;

  next() async {
    if (validateStep(currentStep)) {
      currentStep + 1 != _steps().length
          ? goTo(currentStep + 1)
          : setState(() {});
    }
  }

  bool validateStep(stepNumber) {
    switch (stepNumber) {
      case 0:
        return true;
        break;
      default:
        return true;
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.6),
      child: Stepper(
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[],
          );
        },
        type: StepperType.horizontal,
        steps: _steps(),
        currentStep: this.currentStep,
        onStepContinue: next,
        onStepTapped: (step) {
          if (currentStep > step) {
            goTo(step);
          }
        },
        onStepCancel: cancel,
      ),
    );
  }

  List<Step> _steps() {
    return [
      Step(
        title: const Text('Cliente'),
        isActive: currentStep >= 0,
        state: (currentStep == 0) ? StepState.editing : StepState.indexed,
        content: SizedBox(
          height: (MediaQuery.of(context).size.height * 0.6),
          child: ClientComponent(
            rentFlow: true,
            toEditComponent: (value) {
              WebLocalStorage().save(value.id, "clientId");
              next();
            },
          ),
        ),
      ),
      Step(
          isActive: currentStep >= 1,
          state: (currentStep == 2) ? StepState.editing : StepState.indexed,
          title: const Text("Vehiculo"),
          content: SizedBox(
            height: (MediaQuery.of(context).size.height * 0.6),
            child: VehicleComponent(
              action: (value) async {
                await WebLocalStorage().save(value.id, "vehicleId");
                next();
              },
              rentFlow: true,
            ),
          )),
      Step(
          isActive: currentStep >= 2,
          state: (currentStep == 3) ? StepState.editing : StepState.indexed,
          title: const Text('Inspeccion'),
          content: AddInspectionComponent(
            action: (value) async {
              await WebLocalStorage().save(value, "inspectionId");
              next();
            },
          )),
      Step(
          isActive: currentStep >= 3,
          state: (currentStep == 4) ? StepState.editing : StepState.indexed,
          title: const Text('Formulario'),
          content: AddRentAndReturnComponent())
    ];
  }
}
