import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ExerciseHistoryTable extends StatefulWidget {
  const ExerciseHistoryTable({super.key, required this.dataList});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;

  @override
  State<ExerciseHistoryTable> createState() => _ExerciseHistoryTableState();
}

class _ExerciseHistoryTableState extends State<ExerciseHistoryTable> {
  late final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;

  @override
  void initState() {
    super.initState();
    dataList = widget.dataList;
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Table(
          columnWidths: const {
            // 0: FlexColumnWidth(3),
          },
          children: [
            /// Title Row
            TableRow(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///Date
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Date",
                          style: context.textTheme.labelLarge!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ),

                    /// Rep
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Rep",
                          style: context.textTheme.labelLarge!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ),

                    /// Weight
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Weight",
                          style: context.textTheme.labelLarge!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ),

                    /// Rpe
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Rpe",
                          style: context.textTheme.labelLarge!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

            /// Data Rows
            ...dataList.map(
              (e) {
                index++;
                final date = DateFormat.yMd().format(e.data()["date"].toDate());
                final Map lastData = e.data()["data"].last;
                final List data = e.data()["data"];
                data.removeLast();
                return DataRows(
                  context,
                  lastData: lastData,
                  data: data,
                  date: date,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}

class DataRows extends TableRow {
  DataRows(this.context,
      {super.key,
      required this.lastData,
      required this.data,
      required this.date});

  final Map lastData;
  final List data;
  final String date;
  final BuildContext context;
  Visibility moreDetail(bool showMore, List data, String entry) {
    return Visibility(
      visible: showMore,
      child: Column(
        children: [
          ...data.reversed.map(
            (e) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  e[entry].toString() + (entry == "weight" ? " Kg" : ""),
                  style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  bool _showMore = false;

  @override
  List<Widget> get children {
    return [
      StatefulBuilder(
        builder: (_, setState) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///* date
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      /// See More Details Button
                      GestureDetector(
                        onTap: () => setState(() {
                          _showMore = !_showMore;
                        }),
                        child: Icon(
                          color: AppColors.kButtonColor,
                          _showMore
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                        ),
                      ),

                      /// Date
                      Text(
                        date.toString(),
                        style: context.textTheme.labelSmall!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  // moreDetail(_showMore, data, "rpe"),

                  Visibility(
                    visible: _showMore,
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            (data.length - index).toString(),
                            style: context.textTheme.labelSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///* Rep
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lastData["rep"].toString(),
                    style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                  ),
                  moreDetail(_showMore, data, "rep"),
                ],
              ),
            ),

            ///* Weight
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${lastData["weight"]} Kg",
                    style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                  ),
                  moreDetail(_showMore, data, "weight"),
                ],
              ),
            ),

            ///* Rpe
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lastData["rpe"].toString(),
                    style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                  ),
                  moreDetail(_showMore, data, "rpe"),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
