import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Column buildStatsColumn(int num, String label) {
  return Column(
    children: [
      Text(
        NumberFormat.compact(explicitSign: false, locale: 'en-US').format(num),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Container(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white70),
        ),
      ),
    ],
  );
}
