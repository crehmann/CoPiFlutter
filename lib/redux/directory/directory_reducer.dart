import 'package:built_collection/built_collection.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/directory/directory_actions.dart';
import 'package:flutter_app/redux/directory/directory_state.dart';
import 'package:redux/redux.dart';

final directoryReducer = combineReducers<BuiltMap<String, DirectoryState>>([
  TypedReducer<BuiltMap<String, DirectoryState>, RequestingDirectoryAction>(
      _requestingDirectory),
  TypedReducer<BuiltMap<String, DirectoryState>, ReceivedDirectoryAction>(
      _receivedDirectory),
  TypedReducer<BuiltMap<String, DirectoryState>, ErrorLoadingDirectoryAction>(
      _errorLoadingDirectory),
]);

BuiltMap<String, DirectoryState> _requestingDirectory(
    BuiltMap<String, DirectoryState> state, RequestingDirectoryAction action) {
  var builder = state.toBuilder();
  builder.addAll({action.fullPath: DirectoryState.initial()});
  return builder.build();
}

BuiltMap<String, DirectoryState> _receivedDirectory(
    BuiltMap<String, DirectoryState> state, ReceivedDirectoryAction action) {
  var builder = state.toBuilder();
  builder[action.fullPath] = state[action.fullPath]
      .copyWith(loadingStatus: LoadingStatus.success, content: action.content);
  return builder.build();
}

BuiltMap<String, DirectoryState> _errorLoadingDirectory(
    BuiltMap<String, DirectoryState> state,
    ErrorLoadingDirectoryAction action) {
  var builder = state.toBuilder();
  builder[action.fullPath] =
      state[action.fullPath].copyWith(loadingStatus: LoadingStatus.error);
  return builder.build();
}
