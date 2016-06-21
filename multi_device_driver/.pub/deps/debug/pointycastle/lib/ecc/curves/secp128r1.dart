

// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.impl.ec_domain_parameters.secp128r1;

import "package:bignum/bignum.dart";

import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/ecc_base.dart";
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/src/ec_standard_curve_constructor.dart";

class ECCurve_secp128r1 extends ECDomainParametersImpl {

  static final FactoryConfig FACTORY_CONFIG =
  new StaticFactoryConfig(ECDomainParameters, "secp128r1");

  factory ECCurve_secp128r1() => constructFpStandardCurve("secp128r1",
    ECCurve_secp128r1._make,
    q: new BigInteger("fffffffdffffffffffffffffffffffff", 16),
    a: new BigInteger("fffffffdfffffffffffffffffffffffc", 16),
    b: new BigInteger("e87579c11079f43dd824993c2cee5ed3", 16),
    g: new BigInteger("04161ff7528b899b2d0c28607ca52c5b86cf5ac8395bafeb13c02da292dded7a83", 16),
    n: new BigInteger("fffffffe0000000075a30d1b9038a115", 16),
    h: new BigInteger("1", 16),
    seed: new BigInteger("000e0d4d696e6768756151750cc03a4473d03679", 16)
  );

  static ECCurve_secp128r1 _make(domainName, curve, G, n, _h, seed) =>
    new ECCurve_secp128r1._super(domainName, curve, G, n, _h, seed);

  ECCurve_secp128r1._super(domainName, curve, G, n, _h, seed)
    : super(domainName, curve, G, n, _h, seed);

}