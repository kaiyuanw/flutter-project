

// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.impl.ec_domain_parameters.secp160r2;

import "package:bignum/bignum.dart";

import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/ecc_base.dart";
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/src/ec_standard_curve_constructor.dart";

class ECCurve_secp160r2 extends ECDomainParametersImpl {

  static final FactoryConfig FACTORY_CONFIG =
  new StaticFactoryConfig(ECDomainParameters, "secp160r2");

  factory ECCurve_secp160r2() => constructFpStandardCurve("secp160r2",
    ECCurve_secp160r2._make,
    q: new BigInteger("fffffffffffffffffffffffffffffffeffffac73", 16),
    a: new BigInteger("fffffffffffffffffffffffffffffffeffffac70", 16),
    b: new BigInteger("b4e134d3fb59eb8bab57274904664d5af50388ba", 16),
    g: new BigInteger("0452dcb034293a117e1f4ff11b30f7199d3144ce6dfeaffef2e331f296e071fa0df9982cfea7d43f2e", 16),
    n: new BigInteger("100000000000000000000351ee786a818f3a1a16b", 16),
    h: new BigInteger("1", 16),
    seed: new BigInteger("b99b99b099b323e02709a4d696e6768756151751", 16)
  );

  static ECCurve_secp160r2 _make(domainName, curve, G, n, _h, seed) =>
    new ECCurve_secp160r2._super(domainName, curve, G, n, _h, seed);

  ECCurve_secp160r2._super(domainName, curve, G, n, _h, seed)
    : super(domainName, curve, G, n, _h, seed);

}