import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ExerciseHistoryTable extends StatefulWidget {
  const ExerciseHistoryTable({super.key, required this.dataList});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;

  @override
  State<ExerciseHistoryTable> createState() => _ExerciseHistoryTableState();
}

class _ExerciseHistoryTableState extends State<ExerciseHistoryTable> {
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

  late final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;
  @override
  void initState() {
    super.initState();
    dataList = widget.dataList;
  }

  bool _showMore = false;
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(),
          },
          children: [
            /// Title Row
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Date",
                    style: context.textTheme.labelLarge!.copyWith(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Rep",
                    style: context.textTheme.labelLarge!.copyWith(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Weight",
                    style: context.textTheme.labelLarge!.copyWith(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Rpe",
                    style: context.textTheme.labelLarge!.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),

            /// Data Rows
            ...dataList.map(
              (e) {
                //FIXME: When I tap showMoreDetail button it shows all data's detail.
                index++;
                final date = DateFormat.yMd().format(e.data()["date"].toDate());
                final Map lastData = e.data()["data"].last;
                final List data = e.data()["data"];
                data.removeLast();
                return TableRow(
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
                                onTap: () => setState(
                                  () {
                                    _showMore = !_showMore;
                                  },
                                ),
                                child: Icon(
                                  color: AppColors.kButtonColor,
                                  _showMore
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                ),
                              ),
                              Text(
                                date.toString(),
                                style: context.textTheme.labelSmall!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
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
                            style: context.textTheme.labelSmall!
                                .copyWith(fontSize: 12),
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
                            style: context.textTheme.labelSmall!
                                .copyWith(fontSize: 12),
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
                            style: context.textTheme.labelSmall!
                                .copyWith(fontSize: 12),
                          ),
                          moreDetail(_showMore, data, "rpe"),
                        ],
                      ),
                    ),
                  ],
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
  const DataRows(
      {super.key,
      required this.lastData,
      required this.data,
      required this.date});

  final Map lastData;
  final List data;
  final String date;
}

class DataRowsa extends StatefulWidget {
  const DataRowsa(
      {super.key,
      required this.lastData,
      required this.data,
      required this.date});

  final Map lastData;
  final List data;
  final String date;
  @override
  State<DataRowsa> createState() => _DataRowsaState();
}

class _DataRowsaState extends State<DataRowsa> {
  late final Map lastData;
  late final List data;
  late final String date;

  @override
  void initState() {
    super.initState();
    lastData = widget.lastData;
    data = widget.data;
    date = widget.date;
  }

  bool _showMore = false;
  Widget moreDetail(bool showMore, List data, String key) {
    return Visibility(
      visible: showMore,
      child: Column(
        children: [
          ...data.reversed.map((e) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                e[key] + (key == "weight" ? " Kg" : ""),
                style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
              ),
            );
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    onTap: () => setState(
                      () {
                        _showMore = !_showMore;
                      },
                    ),
                    child: Icon(
                      color: AppColors.kButtonColor,
                      _showMore
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                  Text(
                    date.toString(),
                    style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                  ),
                ],
              ),
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
    );
  }
}
