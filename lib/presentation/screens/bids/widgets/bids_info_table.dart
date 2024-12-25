import 'package:QuoteApp/data/models/bid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget bidsInfoTable(BuildContext context, Bid bid) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: [
        DataColumn(
            label: Text(
          "Item",
        )),
        DataColumn(
          label: Text("quantity"),
        ),
        DataColumn(
          label: Text("warranty month"),
        ),
        DataColumn(
          label: Text("Price peer unit"),
        ),
        DataColumn(
          label: Text("Final Price"),
        )
      ],
      rows: _getTableRows(bid),
    ),
  );
}

List<DataRow> _getTableRows(Bid bid) {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  List<DataRow> products = [];
  for (final element in bid.selectedProducts) {
    final DataRow dataRow = DataRow(cells: [
      DataCell(
        Text(element.product.productName),
      ),
      DataCell(
        Text(
          element.quantity.toString(),
        ),
      ),
      DataCell(
        Text(
          element.warrantyMonths.toString(),
        ),
      ),
      DataCell(
        Text(
          oCcy.format(element.product.price),
        ),
      ),
      DataCell(
        Text(
          oCcy.format(
            (element.product.price * element.quantity),
          ),
        ),
      )
    ]);
    products.add(dataRow);
  }

  return products;
}
