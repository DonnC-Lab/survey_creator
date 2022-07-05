import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

class Previewer extends StatefulWidget {
  const Previewer({Key? key, required this.steps}) : super(key: key);

  final List<Step> steps;

  @override
  _PreviewerState createState() => _PreviewerState();
}

class _PreviewerState extends State<Previewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Align(
          alignment: Alignment.center,
          child: SurveyKit(
            onResult: (SurveyResult result) {
              //print(result.finishReason);
              _res(result);
              Navigator.pushNamed(context, '/');
            },
            task: getPreviewerTask(),
            showProgress: true,
            surveyProgressbarConfiguration: SurveyProgressConfiguration(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _res(SurveyResult result) {
    final s = result.results;

    var aa;

    for (var item in s) {
      print('[OUTTER] $item');
      for (var itemIn in item.results) {
        print(
            '[INNER] ${itemIn.valueIdentifier} | ${itemIn.result} | ${itemIn.id}');
      }
    }
  }

  Task getPreviewerTask() {
    final t = NavigableTask(
      id: TaskIdentifier(),
      steps: widget.steps,
    );

    // todo: Plugin doesnt do toJson on answerformats
    print(t.toJson());

    return t;
  }
}
