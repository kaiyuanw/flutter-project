

// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.impl.ec_domain_parameters.secp160r1;

import "package:bignum/bignum.dart";

import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/ecc_base.dart";
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/src/ec_standard_curve_constructor.dart";

class ECCurve_secp160r1 extends ECDomainParametersImpl {

  static final FactoryConfig FACTORY_CONFIG =
  new StaticFactoryConfig(ECDomainParameters, "secp160r1");

  factory ECCurve_secp160r1() => constructFpStandardCurve("secp160r1",
    ECCurve_secp160r1._make,
    q: new BigInteger("ffffffffffffffffffffffffffffffff7fffffff", 16),
    a: new BigInteger("ffffffffffffffffffffffffffffffff7ffffffc", 16),
    b: new BigInteger("1c97befc54bd7a8b65acf89f81d4d4adc565fa45", 16),
    g: new BigInteger("044a96b5688ef573284664698968c38bb913cbfc8223a628553168947d59dcc912042351377ac5fb32", 16),
    n: new BigInteger("100000000000000000001f4c8f927aed3ca752257", 16),
    h: new BigInteger("1", 16),
    seed: new BigInteger("1053cde42c14d696e67687561517533bf3f83345", 16)
  );

  static ECCurve_secp160r1 _make(domainName, curve, G, n, _h, seed) =>
    new ECCurve_secp160r1._super(domainName, curve, G, n, _h, seed);

  ECCurve_secp160r1._super(domainName, curve, G, n, _h, seed)
    : super(domainName, curve, G, n, _h, seed);

}