// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.src.registry;

import "package:reflectable/reflectable.dart";
import "package:quiver_collection/collection.dart";

import "package:pointycastle/api.dart";

import "factory_config.dart";
export "factory_config.dart";

part "registrable.dart";



final FactoryRegistry registry = new FactoryRegistry();

/// How the factory search algorithm works right now is as follows:
/// - The [Registrable] class has a reflector annotation with a
///   [subtypeQuantifyCapability] capability, so all subclasses of [Registrable]
///   will be included in the reflected set of classes.
/// - The algorithms goes over all these classes and checks for the presence of
///   a static `FACTORY_CONFIG` variable.
class FactoryRegistry {

  static const String FIELD = "FACTORY_CONFIG";

  static const int CONSTRUCTOR_CACHE_SIZE = 25;

  static const Reflectable reflector = const RegistryImplementationReflector();
  static final ClassMirror registrable = reflector.annotatedClasses.firstWhere(
      (cm) => cm.qualifiedName == "pointycastle.src.registry.Registrable");

  final Map<Type, Map<String, RegistrableConstructor>> staticFactories;
  final Map<Type, Set<DynamicFactoryConfig>> dynamicFactories;

  final LruMap<String, RegistrableConstructor> constructorCache =
  new LruMap<String, RegistrableConstructor>(maximumSize: CONSTRUCTOR_CACHE_SIZE);

  FactoryRegistry()
    : staticFactories  = new Map<Type, Map<String, RegistrableConstructor>>(),
      dynamicFactories = new Map<Type, Set<DynamicFactoryConfig>>();

  Registrable create(Type type, String registrableName) {
    RegistrableConstructor constructor = getConstructor(type, registrableName);
    Registrable result = constructor();
    return result;
  }

  RegistrableConstructor getConstructor(Type type, String registrableName) {
    RegistrableConstructor constructor = constructorCache["$type.$registrableName"];
    if (constructor == null) {
      constructor = createConstructor(type, registrableName);
      constructorCache["$type.$registrableName"] = constructor;
    }
    return constructor;
  }

  RegistrableConstructor createConstructor(Type type, String registrableName) {
    // Init lazy
    _checkInit();
    // Look for a static factory
    if (staticFactories.containsKey(type) &&
        staticFactories[type].containsKey(registrableName)) {
      return staticFactories[type][registrableName];
    }
    // Look for a dynamic factory
    if (dynamicFactories.containsKey(type)) {
      for (DynamicFactoryConfig factory in dynamicFactories[type]) {
        RegistrableConstructor constructor = factory.tryFactory(
          registrableName);
        if (constructor != null) {
          return constructor;
        }
      }
    }
    // No factory found
    throw new RegistryFactoryException.unknown(registrableName, type);
  }

  bool initialized = false;
  void _checkInit() {
    if (!initialized) {
      initialize();
    }
  }

  void initialize() {
    for(ClassMirror mirror in reflector.annotatedClasses) {
      if (!mirror.staticMembers.containsKey(FIELD)) {
        // no factory found
        continue;
      }
      FactoryConfig config = mirror.invokeGetter(FIELD);
      // check if dynamic or static factory
      if (config is StaticFactoryConfig) {
        // static factory
        _addStaticFactoryConfig(config, mirror);
      } else if (config is DynamicFactoryConfig) {
        // dynamic factory
        _addDynamicFactoryConfig(config);
      }
    }
    initialized = true;
  }

  void _addStaticFactoryConfig(StaticFactoryConfig config, ClassMirror mirror) {
    Map factories = staticFactories.putIfAbsent(config.type,
        () => new Map<String, RegistrableConstructor>());
    factories[config.algorithmName] = _createStaticFactory(mirror);
  }

  void _addDynamicFactoryConfig(DynamicFactoryConfig config) {
    Set factories = dynamicFactories.putIfAbsent(config.type,
      () => new Set<DynamicFactoryConfig>());
    factories.add(config);
  }

}


class RegistryImplementationReflector extends Reflectable {
  const RegistryImplementationReflector()
    : super(
      declarationsCapability,
      newInstanceCapability,
      staticInvokeCapability,
      subtypeQuantifyCapability
    );
}

RegistrableConstructor _createStaticFactory(ClassMirror classMirror) =>
    () => classMirror.newInstance("", []);

