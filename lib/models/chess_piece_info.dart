import 'package:flutter/material.dart';

class ChessPieceInfo {
  final String name;
  final String imageUrl;
  final Widget detailPage;

  ChessPieceInfo({
    required this.name,
    required this.imageUrl,
    required this.detailPage,
  });
}
