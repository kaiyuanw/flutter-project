

// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.impl.ec_domain_parameters.gostr3410_2001_cryptopro_xchb;

import "package:bignum/bignum.dart";

import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/ecc_base.dart";
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/src/ec_standard_curve_constructor.dart";

class ECCurve_gostr3410_2001_cryptopro_xchb extends ECDomainParametersImpl {

  static final FactoryConfig FACTORY_CONFIG =
  new StaticFactoryConfig(ECDomainParameters, "GostR3410-2001-CryptoPro-XchB");

  factory ECCurve_gostr3410_2001_cryptopro_xchb() => constructFpStandardCurve("GostR3410-2001-CryptoPro-XchB",
    ECCurve_gostr3410_2001_cryptopro_xchb._make,
    q: new BigInteger("9b9f605f5a858107ab1ec85e6b41c8aacf846e86789051d37998f7b9022d759b", 16),
    a: new BigInteger("9b9f605f5a858107ab1ec85e6b41c8aacf846e86789051d37998f7b9022d7598", 16),
    b: new BigInteger("805a", 16),
    g: new BigInteger("04000000000000000000000000000000000000000000000000000000000000000041ece55743711a8c3cbf3783cd08c0ee4d4dc440d4641a8f366e550dfdb3bb67", 16),
    n: new BigInteger("9b9f605f5a858107ab1ec85e6b41c8aa582ca3511eddfb74f02f3a6598980bb9", 16),
    h: new BigInteger("1", 16),
    seed: null
  );

  static ECCurve_gostr3410_2001_cryptopro_xchb _make(domainName, curve, G, n, _h, seed) =>
    new ECCurve_gostr3410_2001_cryptopro_xchb._super(domainName, curve, G, n, _h, seed);

  ECCurve_gostr3410_2001_cryptopro_xchb._super(domainName, curve, G, n, _h, seed)
    : super(domainName, curve, G, n, _h, seed);

}