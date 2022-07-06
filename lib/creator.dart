import 'package:flutter/material.dart' hide Step;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:survey_kit/survey_kit.dart';

import 'previewer.dart';

class Creator extends StatefulWidget {
  const Creator({
    Key? key,
    required this.initialStep,
    required this.lastStep,
  }) : super(key: key);

  ///
  /// ```dart
  /// 
  /// InstructionStep(
  ///        title: 'Welcome to \nABC Survey',
  ///        text: 'Get ready to start!',
  ///        buttonText: 'Start',
  ///      ),
  ///  ```
  ///
  final InstructionStep initialStep;

  ///
  /// ```dart
  ///
  /// CompletionStep(
  ///        stepIdentifier: StepIdentifier(),
  ///        text: 'Thanks for taking the survey',
  ///        title: 'Done!',
  ///        buttonText: 'Submit survey',
  ///      ),
  /// ```
  ///
  final CompletionStep lastStep;

  @override
  State<Creator> createState() => _CreatorState();
}

class _CreatorState extends State<Creator> {
  final TextEditingController _titleValue = TextEditingController();
  final TextEditingController _textValue = TextEditingController();

  bool isQsnOptional = true;

  // list of Steps
  List steps = [];

  final List _firstLastSteps = [];

  @override
  void initState() {
    super.initState();
    _firstLastSteps.addAll([widget.initialStep, widget.lastStep]);
  }

  @override
  void dispose() {
    _titleValue.dispose();
    _textValue.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _titleValue.clear();
      _textValue.clear();
    });
  }

  /// text answer format
  void _showQsnStepModalText(BuildContext ctx) {
    const double _spacer = 3;

    String _hint = '';
    String _maxLines = '1';

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New TextAnswer Qsn'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _titleValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'question title e.g About you',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _textValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                      hintText: 'question text e.g Tell us about yourself',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: _spacer),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      _hint = val;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Hint',
                      hintText: 'question hint',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    onChanged: (val) {
                      _maxLines = val;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max Lines',
                      hintText: 'input field max lines',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final q = QuestionStep(
                      title: _titleValue.text,
                      showAppBar: false,
                      text: _textValue.text,
                      isOptional: isQsnOptional,
                      answerFormat: TextAnswerFormat(
                        hint: _hint,
                        maxLines: int.tryParse(_maxLines) ?? 1,
                      ),
                    );

                    setState(() {
                      steps.add(q);
                    });

                    _reset();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  /// boolean answer format
  void _showQsnStepModalBool(BuildContext ctx) {
    const double _spacer = 3;

    String _positiveAnswer = 'Yes';
    String _negativeAnswer = 'No';

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Bool Answer Qsn'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _titleValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'question title e.g Medication?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _textValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                      hintText:
                          'question text e.g Are you using any medication?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: _spacer),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      _positiveAnswer = val;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Positive Text',
                      hintText: 'e.g Yes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    onChanged: (val) {
                      _negativeAnswer = val;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Negative Text',
                      hintText: 'e.g No',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final q = QuestionStep(
                      title: _titleValue.text,
                      showAppBar: false,
                      text: _textValue.text,
                      isOptional: isQsnOptional,
                      answerFormat: BooleanAnswerFormat(
                        positiveAnswer: _positiveAnswer,
                        negativeAnswer: _negativeAnswer,
                      ),
                    );

                    setState(() {
                      steps.add(q);
                    });

                    _reset();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  /// number answer format
  void _showQsnStepModalInteger(BuildContext ctx) {
    const double _spacer = 3;

    String _hint = '';
    String? _defaultValue;

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Number Answer Qsn'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _titleValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'question title e.g Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _textValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                      hintText: 'question text e.g Enter your age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: _spacer),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      _hint = val;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Hint',
                      hintText: 'question hint',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    onChanged: (val) {
                      _defaultValue = val;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Default Value',
                      hintText: 'field default value if any',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final q = QuestionStep(
                      title: _titleValue.text,
                      showAppBar: false,
                      text: _textValue.text,
                      isOptional: isQsnOptional,
                      answerFormat: IntegerAnswerFormat(
                        defaultValue: int.tryParse(_defaultValue ?? ''),
                        hint: _hint,
                      ),
                    );

                    setState(() {
                      steps.add(q);
                    });

                    _reset();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  /// time answer format
  void _showQsnStepModalTime(BuildContext ctx) {
    const double _spacer = 3;

    String _minute = '';
    String _hour = '';

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Time Answer Qsn'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _titleValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g What time do you eat?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _textValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Question Text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: _spacer),
                // todo: add time picker for default time
                ElevatedButton(
                  onPressed: () {
                    final q = QuestionStep(
                      title: _titleValue.text,
                      showAppBar: false,
                      text: _textValue.text,
                      isOptional: isQsnOptional,
                      answerFormat: const TimeAnswerFormat(),
                      // answerFormat: const TimeAnswerFormat(
                      //   defaultValue: TimeOfDay(
                      //     hour: 12,
                      //     minute: 0,
                      //   ),
                      // ),
                    );

                    setState(() {
                      steps.add(q);
                    });

                    _reset();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  /// date answer format
  void _showQsnStepModalDate(BuildContext ctx) {
    const double _spacer = 3;

    DateTime minDate = DateTime.utc(1970);
    DateTime defaultDate = DateTime.now();
    DateTime maxDate = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Date Answer Qsn'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _titleValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g When is your birthday?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_spacer),
                  child: TextField(
                    controller: _textValue,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Question Text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: _spacer),
                // todo: add date pickers
                ElevatedButton(
                  onPressed: () {
                    final q = QuestionStep(
                      title: _titleValue.text,
                      showAppBar: false,
                      text: _textValue.text,
                      isOptional: isQsnOptional,
                      answerFormat: DateAnswerFormat(),
                      // answerFormat: DateAnswerFormat(
                      //   minDate: DateTime.utc(1970),
                      //   defaultDate: DateTime.now(),
                      //   maxDate: DateTime.now(),
                      // ),
                    );

                    setState(() {
                      steps.add(q);
                    });

                    _reset();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        var row = steps.removeAt(oldIndex);
        steps.insert(newIndex, row);
      });
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          tooltip: 'new Question response type',
          icon: Icons.add,
          children: [
            SpeedDialChild(
              label: 'Text Response',
              child: Icon(matcher(TextAnswerFormat)),
              onTap: () {
                _showQsnStepModalText(context);
              },
            ),
            SpeedDialChild(
              label: 'Number Response',
              child: Icon(matcher(IntegerAnswerFormat)),
              onTap: () {
                _showQsnStepModalInteger(context);
              },
            ),
            SpeedDialChild(
              label: 'Bool Response',
              child: Icon(matcher(BooleanAnswerFormat)),
              onTap: () {
                _showQsnStepModalBool(context);
              },
            ),
            SpeedDialChild(
              label: 'Choice Response',
              child: Icon(matcher(SingleChoiceAnswerFormat)),
              onTap: () {
                _showQsnStepModalText(context);
              },
            ),
            SpeedDialChild(
              label: 'Multiple Response',
              child: Icon(matcher(MultipleChoiceAnswerFormat)),
              onTap: () {
                _showQsnStepModalText(context);
              },
            ),
            SpeedDialChild(
              label: 'Date Response',
              child: Icon(matcher(DateAnswerFormat)),
              onTap: () {
                _showQsnStepModalDate(context);
              },
            ),
            SpeedDialChild(
              label: 'Time Response',
              child: Icon(matcher(TimeAnswerFormat)),
              onTap: () {
                _showQsnStepModalTime(context);
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Creator'),
          actions: [
            IconButton(
              tooltip: 'preview survey',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      var _copy = _firstLastSteps;

                      _copy.insertAll(1, steps);

                      List<Step> _steps = List.from(_copy);

                      print(_steps.asMap());

                      return Previewer(steps: _steps);
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.visibility,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                _firstLastSteps.first.toJson()['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const Icon(Icons.receipt),
            ),
            Expanded(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (ctx, index) {
                  return ListTile(
                    key: ValueKey(
                        steps[index].toJson()['title'].toString().isEmpty
                            ? steps[index].toJson()['text'].toString()
                            : steps[index].toJson()['title'].toString()),
                    title: Text(
                      steps[index].toJson()['title'].toString().isEmpty
                          ? steps[index].toJson()['text'].toString()
                          : steps[index].toJson()['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.drag_handle),
                  );
                },
                itemCount: steps.length,
                onReorder: _onReorder,
              ),
            ),
            // Expanded(
            //   child: ListView.separated(
            //     itemBuilder: (ctx, index) {
            //       return ListTile(
            //         title: Text(
            //           steps[index].toJson()['title'],
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         //  leading: Icon(matcher(steps[index].answerFormat)),
            //       );
            //     },
            //     separatorBuilder: (ctx, x) => const SizedBox(height: 10),
            //     itemCount: steps.length,
            //   ),
            // ),
            ListTile(
              title: Text(
                _firstLastSteps.last.toJson()['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const Icon(Icons.receipt),
            )
          ],
        ),
      ),
    );
  }
}

IconData matcher(var answerFormat) {
  IconData? _icon = Icons.receipt;

  Map<dynamic, IconData> answerFormatMapper = {
    BooleanAnswerFormat: Icons.done,
    IntegerAnswerFormat: Icons.numbers,
    TextAnswerFormat: Icons.message,
    DateAnswerFormat: Icons.calendar_month,
    TimeAnswerFormat: Icons.timer,
    SingleChoiceAnswerFormat: Icons.mark_as_unread,
    MultipleChoiceAnswerFormat: Icons.select_all,
  };

  //print(answerFormat.runtimeType);

  if (answerFormat is BooleanAnswerFormat) {
    _icon = answerFormatMapper[BooleanAnswerFormat];
  }

  if (answerFormat is IntegerAnswerFormat) {
    _icon = answerFormatMapper[IntegerAnswerFormat];
  }

  if (answerFormat is TextAnswerFormat) {
    _icon = answerFormatMapper[TextAnswerFormat];
  }

  if (answerFormat is DateAnswerFormat) {
    _icon = answerFormatMapper[DateAnswerFormat];
  }

  if (answerFormat is TimeAnswerFormat) {
    _icon = answerFormatMapper[TimeAnswerFormat];
  }

  if (answerFormat is SingleChoiceAnswerFormat) {
    _icon = answerFormatMapper[SingleChoiceAnswerFormat];
  }

  if (answerFormat is MultipleChoiceAnswerFormat) {
    _icon = answerFormatMapper[MultipleChoiceAnswerFormat];
  }

  return _icon ??= Icons.receipt;
}

// class QsnAnswerMapper {
//   final IconData icon;
//   final List<String> fields;
// }
