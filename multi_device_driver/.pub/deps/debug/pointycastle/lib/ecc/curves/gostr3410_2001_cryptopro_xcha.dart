

// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.impl.ec_domain_parameters.gostr3410_2001_cryptopro_xcha;

import "package:bignum/bignum.dart";

import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/ecc_base.dart";
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/src/ec_standard_curve_constructor.dart";

class ECCurve_gostr3410_2001_cryptopro_xcha extends ECDomainParametersImpl {

  static final FactoryConfig FACTORY_CONFIG =
  new StaticFactoryConfig(ECDomainParameters, "GostR3410-2001-CryptoPro-XchA");

  factory ECCurve_gostr3410_2001_cryptopro_xcha() => constructFpStandardCurve("GostR3410-2001-CryptoPro-XchA",
    ECCurve_gostr3410_2001_cryptopro_xcha._make,
    q: new BigInteger("fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd97", 16),
    a: new BigInteger("fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd94", 16),
    b: new BigInteger("a6", 16),
    g: new BigInteger("0400000000000000000000000000000000000000000000000000000000000000018d91e471e0989cda27df505a453f2b7635294f2ddf23e3b122acc99c9e9f1e14", 16),
    n: new BigInteger("ffffffffffffffffffffffffffffffff6c611070995ad10045841b09b761b893", 16),
    h: new BigInteger("1", 16),
    seed: null
  );

  static ECCurve_gostr3410_2001_cryptopro_xcha _make(domainName, curve, G, n, _h, seed) =>
    new ECCurve_gostr3410_2001_cryptopro_xcha._super(domainName, curve, G, n, _h, seed);

  ECCurve_gostr3410_2001_cryptopro_xcha._super(domainName, curve, G, n, _h, seed)
    : super(domainName, curve, G, n, _h, seed);

}