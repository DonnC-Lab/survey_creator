import 'package:flutter/material.dart';
import 'package:survey_creator/creator.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SurveyCreatorApp());
}

class SurveyCreatorApp extends StatelessWidget {
  const SurveyCreatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Survey Creator App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: AppEntryPoint()),
      ),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('S-Creator'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add new survey',
        onPressed: () {
          // TODO: show dialog for user to provide initial & last step
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Creator(
                initialStep: InstructionStep(
                  title: 'Welcome to \nDonnC Survey',
                  text: 'Get ready for some few questions!',
                  buttonText: 'Start',
                  showAppBar: false,
                ),
                lastStep: CompletionStep(
                  stepIdentifier: StepIdentifier(),
                  text:
                      'Thanks for taking the survey, we will contact you soon!',
                  title: 'Done!',
                  buttonText: 'Submit survey',
                  showAppBar: false,
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Survey Creator'),
      ),
    );
  }
}
