import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/widgets/dream_post_header.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/text_ful_divider.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_element.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamDetail extends StatefulWidget {
  final String identifier;

  const DreamDetail({Key key, @required this.identifier}) : super(key: key);

  @override
  _DreamDetailState createState() => _DreamDetailState();
}

class _DreamDetailState extends State<DreamDetail> {
  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: ChangeNotifierProvider(
        create: (context) => DreamViewModel()..loadDream(widget.identifier),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DreamConsumer<DreamViewModel>(
            builder: (context, dreamVewModel, child) {
              final Dream dream = dreamVewModel.dream.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DreamPostHeader(dream: dream),
                    SizedBox(height: 16),
                    Text(dream.text),
                    SizedBox(height: 16),
                    _dreamDivider(context, "Elements"),
                    SizedBox(height: 8),
                    _elements(dream, context),
                    _dreamDivider(context, "Feelings"),
                    SizedBox(height: 8),
                    _feelings(dream),
                    SizedBox(height: 8),
                    _dreamDivider(context, "Dream Transparency"),
                    SizedBox(height: 8),
                    _linearProgress(
                      dream.dreamClearance + 1,
                      5,
                      dream.dreamClearanceDisplay,
                    ),
                  ],
                ),
              );
            },
            loadingBuilder: (context, dream, child) => Column(
              children: [
                Text("Loading"),
              ],
            ),
            errorBuilder: (context, dream, child) => Column(
              children: [
                Text("Ops! ${dream.errorMessage}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _feelings(Dream dream) {
    return Column(
      children: [
        ...dream.feelings
            .map<Widget>(
              (Feeling feeling) => Column(
                children: [
                  Row(
                    children: [
                      Text(
                        feeling.feelingParent.capitalize(),
                      ),
                      Text(" - "),
                      Text(
                        feeling.feelingDisplay(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _linearProgress(
                      feeling.rate,
                      Constants.maxFeelingSlider,
                      "${feeling.rate}/${Constants.maxFeelingSlider}",
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
            .toList()
      ],
    );
  }

  ClipRRect _linearProgress(int value, int maxValue, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 8,
              value: value / maxValue,
              valueColor: AlwaysStoppedAnimation<Color>(
                Constants.secondaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(label),
          ),
        ],
      ),
    );
  }

  TextFulDivider _dreamDivider(context, text) {
    return TextFulDivider(
      startFlex: 0,
      text: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
      endFlex: 1,
    );
  }

  Column _elements(Dream dream, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...dream.elements
            .map<Widget>(
              (DreamElement element) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.type.capitalize(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    children: [
                      ...element.elements
                          .map<Widget>(
                            (String e) => Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Constants.accentColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(e),
                            ),
                          )
                          .toList()
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
