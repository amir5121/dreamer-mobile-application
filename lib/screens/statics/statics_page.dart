import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/widgets/text_ful_divider.dart';
import 'package:dreamer/models/analytics/analytics.dart';
import 'package:dreamer/models/analytics/clearance_summarize.dart';
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
            builder: (context, statics, child) {
              final Analytics analytics = statics.statics.data;
              return analytics.dreamsCount == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No dream has been logged!",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "zzz time?",
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _dreamDivider(context, "Word Cloud"),
                        SizedBox(height: 16),
                        Text(analytics.mainQuote),
                        SizedBox(height: 16),
                        Image.network(
                          analytics.wordCloud,
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
                        feelingAnalysis(analytics),
                        _dreamDivider(context, "Transparency analysis"),
                        clearanceAnalysis(analytics),
                        // _dreamDivider(context, "Jungian Archetypes"),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Row clearanceAnalysis(Analytics analytics) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 16,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Constants.secondaryColor,
                Constants.deepPurple[900],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // color: Constants.deepPurple,
          ),
        ),
        Expanded(
          child: Container(
            height: 200,
            child: charts.TimeSeriesChart(
              [
                new charts.Series<ClearanceSummarize, DateTime>(
                  id: 'Clearance',
                  domainFn: (ClearanceSummarize row, _) => row.day,
                  measureFn: (ClearanceSummarize row, _) => row.average,
                  data: analytics.clearances,
                )
              ],
              animate: true,
              primaryMeasureAxis: new charts.NumericAxisSpec(
                tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                  desiredTickCount: 5,
                ),
                renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(dashPattern: [0, 16], thickness: 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row feelingAnalysis(Analytics analytics) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ...analytics.feelings.map<Widget>(
                (FeelingSummarize feelingSummarize) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: feelingSummarize.dartColor(),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(feelingSummarize.label.capitalize()),
                      Expanded(child: Container()),
                      Text("${((feelingSummarize.value * 100).toInt()).toString()}%")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Text(
                    analytics.dreamsCount.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text("Dream"),
                ],
              ),
              Container(
                height: 200,
                child: charts.PieChart(
                  [
                    charts.Series<FeelingSummarize, String>(
                      id: 'Feelings',
                      colorFn: (FeelingSummarize segment, _) =>
                          charts.ColorUtil.fromDartColor(segment.dartColor()),
                      domainFn: (FeelingSummarize segment, _) => segment.label,
                      measureFn: (FeelingSummarize segment, _) => segment.value,
                      data: analytics.feelings,
                    )
                  ],
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 20,
                    // startAngle: 4 / 5 * pi,
                    // arcLength: 7 / 5 * pi,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
