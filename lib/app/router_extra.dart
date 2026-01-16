import 'package:go_router/go_router.dart';

/// Extra values passed in router navigation.
class RouterExtra {
  /// Extra values stored internally.
  final Map<String, dynamic> _args;

  RouterExtra(Map<String, dynamic> args)
    : _args = Map<String, dynamic>.from(args);

  /// Validates the extra values.
  /// Throws ArgumentError if any of the specified names are missing.
  static RouterExtra validate(GoRouterState state, List<String> names) {
    final extra = state.extra as RouterExtra?;
    if (extra == null) {
      throw ArgumentError("no extra value provided");
    }
    for (final name in names) {
      if (!extra._hasValue(name)) {
        throw ArgumentError("No extra value found for $name");
      }
    }
    return extra;
  }

  /// Returns the extra value for the given name, or null if not found.
  dynamic getValue(String name) {
    return _hasValue(name) ? _args[name] : null;
  }

  /// Returns whether an extra value exists for the given name.
  bool _hasValue(String name) {
    return _args.containsKey(name);
  }
}
