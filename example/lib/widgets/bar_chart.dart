import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/chart.dart';

typedef DataToValue<T> = double Function(T item);
typedef DataToAxis<T> = String Function(int item);

String defaultAxisValues(int item) => '$item';

class BarChart<T> extends StatelessWidget {
  const BarChart({
    @required this.data,
    @required this.dataToValue,
    this.height = 240.0,
    this.backgroundDecorations,
    this.foregroundDecorations,
    this.itemOptions,
    this.chartOptions,
    Key key,
  }) : super(key: key);

  final List<T> data;
  final DataToValue<T> dataToValue;
  final double height;

  final ChartItemOptions itemOptions;
  final ChartOptions chartOptions;
  final List<DecorationPainter> backgroundDecorations;
  final List<DecorationPainter> foregroundDecorations;

  @override
  Widget build(BuildContext context) {
    final _foregroundDecorations = foregroundDecorations ?? <DecorationPainter>[];
    final _backgroundDecorations = backgroundDecorations ?? <DecorationPainter>[];

    // Map values
    final _values = data.map((e) => BarValue(dataToValue(e))).toList();

    return AnimatedChart(
      height: height,
      duration: const Duration(milliseconds: 2000),
      state: ChartState(
        _values,
        options: chartOptions,
        itemOptions: itemOptions,
        foregroundDecorations: _foregroundDecorations,
        backgroundDecorations: [
          ..._backgroundDecorations,
        ],
      ),
    );
  }
}
