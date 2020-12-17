import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/widgets/text_ful_divider.dart';
import 'package:dreamer/models/analytics/feeling_summarize.dart';
import 'package:dreamer/view_models/statics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaticsPage extends StatefulWidget {
  final int duration;

  const StaticsPage({Key key, @required this.duration}) : super(key: key);

  @override
  _StaticsPageState createState() => _StaticsPageState();
}

TextFulDivider _dreamDivider(context, text) {
  return TextFulDivider(
    startFlex: 0,
    text: Text(
      text,
      style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
    ),
    endFlex: 1,
  );
}

class _StaticsPageState extends State<StaticsPage> {
  @override
  Widget build(BuildContext context) {
    // StaticsViewModel staticsViewModel = context.read<StaticsViewModel>();
    // staticsViewModel.loadStatics(widget.duration);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ChangeNotifierProvider<StaticsViewModel>(
          create: (context) => StaticsViewModel()..loadStatics(widget.duration),
          child: DreamConsumer<StaticsViewModel>(
            loadingBuilder: (context, statics, child) => Text("Loading"),
            builder: (context, statics, child) => Column(
              children: [
                _dreamDivider(context, "Word Cloud"),
                SizedBox(height: 16),
                Text(statics.statics.data.mainQuote),
                SizedBox(height: 16),
                Image.network(
                  statics.statics.data.wordCloud,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.file_download),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    )
                  ],
                ),
                _dreamDivider(context, "Emotion analysis"),
                feelingAnalysis(statics)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row feelingAnalysis(statics) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ...statics.statics.data.feelings.map<Widget>(
                (FeelingSummarize feelingSummarize) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(feelingSummarize.label.capitalize()),
                      Text("${((feelingSummarize.value * 100).toInt()).toString()}%")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 200,
            child: charts.PieChart(
              [
                charts.Series<FeelingSummarize, String>(
                  id: 'Segments',
                  // colorFn: (FeelingSummarize segment, _) =>
                  //     charts.ColorUtil.fromDartColor(Constants.deepPurple[100]),
                  domainFn: (FeelingSummarize segment, _) => segment.label,
                  measureFn: (FeelingSummarize segment, _) => segment.value,
                  data: statics.statics.data.feelings,
                )
              ],
              animate: true,
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 20,
                // startAngle: 4 / 5 * pi,
                // arcLength: 7 / 5 * pi,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
