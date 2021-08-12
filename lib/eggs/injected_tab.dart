import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/prototyping/pb_prototype_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_inherited_intermediate.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_injected_intermediate.dart';
import 'package:parabeac_core/generation/generators/plugins/pb_plugin_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_prototype_enabled.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/layouts/temp_group_layout_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_instance.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_master_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/child_strategy.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'dart:math';

class Tab extends PBEgg implements PBInjectedIntermediate, PrototypeEnable {
  @override
  PrototypeNode prototypeNode;

  Tab(
    String UUID,
    Rectangle frame,
    String name, {
    this.prototypeNode,
  }) : super(
          UUID,
          frame,
          name,
        ) {
    generator = PBTabGenerator();
    childrenStrategy = OneChildStrategy('child');
  }

  @override
  String semanticName;

  @override
  PBEgg generatePluginNode(Rectangle frame, PBIntermediateNode originalNode) {
    if (originalNode is PBInheritedIntermediate) {
      var tab = Tab(
        UUID,
        frame,
        originalNode.name,
        prototypeNode: (originalNode as PBInheritedIntermediate).prototypeNode,
      );
      if (originalNode is! TempGroupLayoutNode) {
        var designNode = _convertWrapper(originalNode);

        ///Clean the node so that it doesn't get interpreted as a plugin again.
        // designNode.interpretNode(currentContext).then(tab.addChild);
        tab.addChild(designNode);
      }
      return tab;
    }

    return null;
  }

  @override
  List<PBIntermediateNode> layoutInstruction(List<PBIntermediateNode> layer) {
    return layer;
  }

  PBIntermediateNode _convertWrapper(PBIntermediateNode node) {
    /// This is for plugins
    var str = '${node.name}';
    node.name = str.replaceAll(RegExp(r'\<.*?\>'), '');

    ///This is for symbol master
    if (node is PBSharedMasterNode) {
      /// Convert to AbstractGroup?

    }

    ///This is for symbol Instance
    if (node is PBSharedInstanceIntermediateNode) {}
    return node;
  }

  @override
  void extractInformation(PBIntermediateNode incomingNode) {
    // TODO: implement extractInformation
  }
}

class PBTabGenerator extends PBGenerator {
  PBTabGenerator() : super();

  @override
  String generate(PBIntermediateNode source, PBContext generatorContext) {
    if (source is Tab) {
      var buffer = StringBuffer();
      buffer.write('BottomNavigationBarItem(');
      buffer.write(source.child != null
          ? 'icon: ${source.child.generator.generate(source.child, generatorContext)}'
          : '');
      buffer.write(')');
      return buffer.toString();
    } else {
      return '';
    }
  }
}
