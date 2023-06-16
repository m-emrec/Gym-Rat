import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ExerciseHistoryTable extends StatefulWidget {
  ExerciseHistoryTable({super.key, required this.dataList});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;
  bool _showMore = false;

  @override
  State<ExerciseHistoryTable> createState() => _ExerciseHistoryTableState();
}

class _ExerciseHistoryTableState extends State<ExerciseHistoryTable> {
  Widget moreDetail(bool showMore, List data, String key) {
    return Visibility(
      visible: showMore,
      child: Column(
        children: [
          ...data.reversed.map((e) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                e[key],
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
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            ...widget.dataList.map((e) {
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
                              onTap: () => setState(() {
                                widget._showMore = !widget._showMore;
                              }),
                              child: Icon(
                                color: AppColors.kButtonColor,
                                widget._showMore
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
                          visible: widget._showMore,
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
                          lastData["rep"],
                          style: context.textTheme.labelSmall!
                              .copyWith(fontSize: 12),
                        ),
                        moreDetail(widget._showMore, data, "rep"),
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
                        moreDetail(widget._showMore, data, "weight"),
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
                          lastData["rpe"],
                          style: context.textTheme.labelSmall!
                              .copyWith(fontSize: 12),
                        ),
                        moreDetail(widget._showMore, data, "rpe"),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
