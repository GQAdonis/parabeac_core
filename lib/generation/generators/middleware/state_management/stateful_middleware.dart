import 'package:parabeac_core/generation/flutter_project_builder/import_helper.dart';
import 'package:parabeac_core/generation/generators/middleware/state_management/state_management_middleware.dart';
import 'package:parabeac_core/generation/generators/pb_generation_manager.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/commands/write_symbol_command.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/pb_file_structure_strategy.dart';
import 'package:parabeac_core/generation/generators/value_objects/generation_configuration/pb_generation_configuration.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_instance.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_symbol_storage.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as p;

class StatefulMiddleware extends StateManagementMiddleware {
  StatefulMiddleware(PBGenerationManager generationManager,
      GenerationConfiguration configuration)
      : super(generationManager, configuration);

  String getImportPath(PBSharedInstanceIntermediateNode node,
      FileStructureStrategy fileStrategy) {
    var symbolMaster =
        PBSymbolStorage().getSharedMasterNodeBySymbolID(node.SYMBOL_ID);
    var path = p.join(
        fileStrategy.GENERATED_PROJECT_PATH,
        FileStructureStrategy.RELATIVE_VIEW_PATH,
        ImportHelper.getName(symbolMaster.name).snakeCase,
        node.functionCallName.snakeCase);
    return path;
  }

  @override
  Future<PBIntermediateNode> handleStatefulNode(
      PBIntermediateNode node, PBContext context) {
    var fileStrategy = configuration.fileStructureStrategy;

    if (node is PBSharedInstanceIntermediateNode) {
      addImportToCache(node.SYMBOL_ID, getImportPath(node, fileStrategy));
      return Future.value(node);
    }

    fileStrategy.commandCreated(WriteSymbolCommand(context.tree.UUID,
        node.name.snakeCase, generationManager.generate(node, context)));

    stmgHelper.getStateGraphOfNode(node).states?.forEach((state) {
      // state.variation.node.currentContext.tree.data = node.managerData;
      fileStrategy.commandCreated(WriteSymbolCommand(
          'TODO',
          // state.variation.node.currentContext.tree.UUID,
          state.name.snakeCase,
          generationManager.generate(state, context)));
    });
    return Future.value(null);
  }
}
