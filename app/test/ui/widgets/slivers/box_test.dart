import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/slivers/box.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'box',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'Vertical',
            constraints: BoxConstraints.tight(const Size(100, 100)),
            child: const CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: Text('Item 1')),
                SliverSizedBox(height: 10),
                SliverToBoxAdapter(child: Text('Item 2')),
                SliverSizedBox(height: 20),
                SliverToBoxAdapter(child: Text('Item 3')),
              ],
            ),
          ),
          GoldenTestScenario(
            name: 'Horizontal',
            constraints: BoxConstraints.tight(const Size(170, 30)),
            child: const CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(child: Text('Item 1')),
                SliverSizedBox(width: 10),
                SliverToBoxAdapter(child: Text('Item 2')),
                SliverSizedBox(width: 20),
                SliverToBoxAdapter(child: Text('Item 3')),
              ],
            ),
          ),
        ],
      ),
    );
