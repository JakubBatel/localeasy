import 'dart:math';

import 'package:localeasy/src/plural_case.dart';
import 'package:meta/meta.dart';

abstract class PluralTranslator {
  static const byLocale = {
    'af': EsPluralTranslator(),
    'am': HiPluralTranslator(),
    'ar': ArPluralTranslator(),
    'az': EsPluralTranslator(),
    'be': BePluralTranslator(),
    'bg': EsPluralTranslator(),
    'bn': HiPluralTranslator(),
    'br': BrPluralTranslator(),
    'bs': SrPluralTranslator(),
    'ca': EnPluralTranslator(),
    'chr': EsPluralTranslator(),
    'cs': CsPluralTranslator(),
    'cy': CyPluralTranslator(),
    'da': DaPluralTranslator(),
    'de': EnPluralTranslator(),
    'de_AT': EnPluralTranslator(),
    'de_CH': EnPluralTranslator(),
    'el': EsPluralTranslator(),
    'en': EnPluralTranslator(),
    'en_AU': EnPluralTranslator(),
    'en_CA': EnPluralTranslator(),
    'en_GB': EnPluralTranslator(),
    'en_IE': EnPluralTranslator(),
    'en_IN': EnPluralTranslator(),
    'en_SG': EnPluralTranslator(),
    'en_US': EnPluralTranslator(),
    'en_ZA': EnPluralTranslator(),
    'es': EsPluralTranslator(),
    'es_419': EsPluralTranslator(),
    'es_ES': EsPluralTranslator(),
    'es_MX': EsPluralTranslator(),
    'es_US': EsPluralTranslator(),
    'et': EnPluralTranslator(),
    'eu': EsPluralTranslator(),
    'fa': HiPluralTranslator(),
    'fi': EnPluralTranslator(),
    'fil': FilPluralTranslator(),
    'fr': FrPluralTranslator(),
    'fr_CA': FrPluralTranslator(),
    'ga': GaPluralTranslator(),
    'gl': EnPluralTranslator(),
    'gsw': EsPluralTranslator(),
    'gu': HiPluralTranslator(),
    'he': HePluralTranslator(),
    'hi': HiPluralTranslator(),
    'hr': SrPluralTranslator(),
    'hu': EsPluralTranslator(),
    'hy': FrPluralTranslator(),
    'is': IsPluralTranslator(),
    'it': EnPluralTranslator(),
    'iw': HePluralTranslator(),
    'ka': EsPluralTranslator(),
    'kk': EsPluralTranslator(),
    'kn': HiPluralTranslator(),
    'ky': EsPluralTranslator(),
    'ln': AkPluralTranslator(),
    'lt': LtPluralTranslator(),
    'lv': LvPluralTranslator(),
    'mk': MkPluralTranslator(),
    'ml': EsPluralTranslator(),
    'mn': EsPluralTranslator(),
    'mo': RoPluralTranslator(),
    'mr': HiPluralTranslator(),
    'mt': MtPluralTranslator(),
    'nb': EsPluralTranslator(),
    'ne': EsPluralTranslator(),
    'nl': EnPluralTranslator(),
    'no': EsPluralTranslator(),
    'no_NO': EsPluralTranslator(),
    'or': EsPluralTranslator(),
    'pa': AkPluralTranslator(),
    'pl': PlPluralTranslator(),
    'pt': PtPluralTranslator(),
    'pt_BR': PtPluralTranslator(),
    'pt_PT': PtPtPluralTranslator(),
    'ro': RoPluralTranslator(),
    'ru': RuPluralTranslator(),
    'sh': SrPluralTranslator(),
    'si': SiPluralTranslator(),
    'sk': CsPluralTranslator(),
    'sl': SlPluralTranslator(),
    'sr': SrPluralTranslator(),
    'sr_Latn': SrPluralTranslator(),
    'sv': EnPluralTranslator(),
    'sw': EnPluralTranslator(),
    'ta': EsPluralTranslator(),
    'te': EsPluralTranslator(),
    'tl': FilPluralTranslator(),
    'tr': EsPluralTranslator(),
    'uk': RuPluralTranslator(),
    'ur': EnPluralTranslator(),
    'uz': EsPluralTranslator(),
    'zu': HiPluralTranslator(),
  };
  static const fallback = DefaultPluralTranslator();

  const PluralTranslator();

  PluralCase getPluralCase(num value, [int precision = 0]);

  @protected
  int getIntegerPart(num value) {
    return value.toInt();
  }

  @protected
  int getNumberOfVisibleFractionDigits(num value, int precision) {
    return precision;
  }

  @protected
  int getVisibleFractionDigits(num value, int precision) {
    final b = pow(10, getNumberOfVisibleFractionDigits(value, precision)).toInt();
    return (value * b).floor() % b;
  }

  @protected
  int getVisibleFractionDigitsWithoutTrailingZeros(value, precision) {
    var f = getVisibleFractionDigits(value, precision);

    if (f == 0) {
      return 0;
    }

    while ((f % 10) == 0) {
      f = (f / 10).floor();
    }

    return f;
  }
}

class DefaultPluralTranslator extends PluralTranslator {
  const DefaultPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    return PluralCase.other;
  }
}

class AkPluralTranslator extends PluralTranslator {
  const AkPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value >= 0 && value <= 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class ArPluralTranslator extends PluralTranslator {
  const ArPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value == 0) {
      return PluralCase.zero;
    }
    if (value == 1) {
      return PluralCase.one;
    }
    if (value == 2) {
      return PluralCase.two;
    }
    if (value % 100 >= 3 && value % 100 <= 10) {
      return PluralCase.few;
    }
    if (value % 100 >= 11 && value % 100 <= 99) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class BePluralTranslator extends PluralTranslator {
  const BePluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value % 10 == 1 && value % 100 != 11) {
      return PluralCase.one;
    }
    if (value % 10 >= 2 && value % 10 <= 4 && (value % 100 < 12 || value % 100 > 14)) {
      return PluralCase.few;
    }
    if (value % 10 == 0 || value % 10 >= 5 && value % 10 <= 9 || value % 100 >= 11 && value % 100 <= 14) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class BrPluralTranslator extends PluralTranslator {
  const BrPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value % 10 == 1 && value % 100 != 11 && value % 100 != 71 && value % 100 != 91) {
      return PluralCase.one;
    }
    if (value % 10 == 2 && value % 100 != 12 && value % 100 != 72 && value % 100 != 92) {
      return PluralCase.two;
    }
    if ((value % 10 >= 3 && value % 10 <= 4 || value % 10 == 9) &&
        (value % 100 < 10 || value % 100 > 19) &&
        (value % 100 < 70 || value % 100 > 79) &&
        (value % 100 < 90 || value % 100 > 99)) {
      return PluralCase.few;
    }
    if (value != 0 && value % 1000000 == 0) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class CsPluralTranslator extends PluralTranslator {
  const CsPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (i == 1 && v == 0) {
      return PluralCase.one;
    }
    if (i >= 2 && i <= 4 && v == 0) {
      return PluralCase.few;
    }
    if (v != 0) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class CyPluralTranslator extends PluralTranslator {
  const CyPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value == 0) {
      return PluralCase.zero;
    }
    if (value == 1) {
      return PluralCase.one;
    }
    if (value == 2) {
      return PluralCase.two;
    }
    if (value == 3) {
      return PluralCase.few;
    }
    if (value == 6) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class DaPluralTranslator extends PluralTranslator {
  const DaPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final t = getVisibleFractionDigitsWithoutTrailingZeros(value, precision);

    if (value == 1 || t != 0 && (i == 0 || i == 1)) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class EnPluralTranslator extends PluralTranslator {
  const EnPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (value == 1 && v == 0) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class EsPluralTranslator extends PluralTranslator {
  const EsPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class FilPluralTranslator extends PluralTranslator {
  const FilPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final f = getVisibleFractionDigits(value, precision);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (v == 0 && (i == 1 || i == 2 || i == 3) ||
        v == 0 && i % 10 != 4 && i % 10 != 6 && i % 10 != 9 ||
        v != 0 && f % 10 != 4 && f % 10 != 6 && f % 10 != 9) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class FrPluralTranslator extends PluralTranslator {
  const FrPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);

    if (i == 0 || i == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class GaPluralTranslator extends PluralTranslator {
  const GaPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value == 1) {
      return PluralCase.one;
    }
    if (value == 2) {
      return PluralCase.two;
    }
    if (value >= 3 && value <= 6) {
      return PluralCase.few;
    }
    if (value >= 7 && value <= 10) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class HePluralTranslator extends PluralTranslator {
  const HePluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (i == 1 && v == 0) {
      return PluralCase.one;
    }
    if (i == 2 && v == 0) {
      return PluralCase.two;
    }
    if (v == 0 && (value < 0 || value > 10) && value % 10 == 0) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class HiPluralTranslator extends PluralTranslator {
  const HiPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);

    if (i == 0 || value == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class IsPluralTranslator extends PluralTranslator {
  const IsPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final t = getVisibleFractionDigitsWithoutTrailingZeros(value, precision);

    if (t == 0 && i % 10 == 1 && i % 100 != 11 || t != 0) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class LtPluralTranslator extends PluralTranslator {
  const LtPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final f = getVisibleFractionDigits(value, precision);

    if (value % 10 == 1 && (value % 100 < 11 || value % 100 > 19)) {
      return PluralCase.one;
    }
    if (value % 10 >= 2 && value % 10 <= 9 && (value % 100 < 11 || value % 100 > 19)) {
      return PluralCase.few;
    }
    if (f != 0) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class LvPluralTranslator extends PluralTranslator {
  const LvPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final f = getVisibleFractionDigits(value, precision);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (value % 10 == 0 || value % 100 >= 11 && value % 100 <= 19 || v == 2 && f % 100 >= 11 && f % 100 <= 19) {
      return PluralCase.zero;
    }
    if (value % 10 == 1 && value % 100 != 11 || v == 2 && f % 10 == 1 && f % 100 != 11 || v != 2 && f % 10 == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class MkPluralTranslator extends PluralTranslator {
  const MkPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final f = getVisibleFractionDigits(value, precision);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (v == 0 && i % 10 == 1 || f % 10 == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class MtPluralTranslator extends PluralTranslator {
  const MtPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value == 1) {
      return PluralCase.one;
    }
    if (value == 0 || value % 100 >= 2 && value % 100 <= 10) {
      return PluralCase.few;
    }
    if (value % 100 >= 11 && value % 100 <= 19) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class PlPluralTranslator extends PluralTranslator {
  const PlPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (i == 1 && v == 0) {
      return PluralCase.one;
    }
    if (v == 0 && i % 10 >= 2 && i % 10 <= 4 && (i % 100 < 12 || i % 100 > 14)) {
      return PluralCase.few;
    }
    if (v == 0 && i != 1 && i % 10 >= 0 && i % 10 <= 1 ||
        v == 0 && i % 10 >= 5 && i % 10 <= 9 ||
        v == 0 && i % 100 >= 12 && i % 100 <= 14) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class PtPluralTranslator extends PluralTranslator {
  const PtPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    if (value >= 0 && value <= 2 && value != 2) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class PtPtPluralTranslator extends PluralTranslator {
  const PtPtPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (value == 1 && v == 0) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class RoPluralTranslator extends PluralTranslator {
  const RoPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (i == 1 && v == 0) {
      return PluralCase.one;
    }
    if (v != 0 || value == 0 || value != 1 && value % 100 >= 1 && value % 100 <= 19) {
      return PluralCase.few;
    }
    return PluralCase.other;
  }
}

class RuPluralTranslator extends PluralTranslator {
  const RuPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (v == 0 && i % 10 == 1 && i % 100 != 11) {
      return PluralCase.one;
    }
    if (v == 0 && i % 10 >= 2 && i % 10 <= 4 && (i % 100 < 12 || i % 100 > 14)) {
      return PluralCase.few;
    }
    if (v == 0 && i % 10 == 0 || v == 0 && i % 10 >= 5 && i % 10 <= 9 || v == 0 && i % 100 >= 11 && i % 100 <= 14) {
      return PluralCase.many;
    }
    return PluralCase.other;
  }
}

class SiPluralTranslator extends PluralTranslator {
  const SiPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final f = getVisibleFractionDigits(value, precision);

    if ((value == 0 || value == 1) || i == 0 && f == 1) {
      return PluralCase.one;
    }
    return PluralCase.other;
  }
}

class SlPluralTranslator extends PluralTranslator {
  const SlPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (v == 0 && i % 100 == 1) {
      return PluralCase.one;
    }
    if (v == 0 && i % 100 == 2) {
      return PluralCase.two;
    }
    if (v == 0 && i % 100 >= 3 && i % 100 <= 4 || v != 0) {
      return PluralCase.few;
    }
    return PluralCase.other;
  }
}

class SrPluralTranslator extends PluralTranslator {
  const SrPluralTranslator();

  @override
  PluralCase getPluralCase(num value, [int precision = 0]) {
    final i = getIntegerPart(value);
    final f = getVisibleFractionDigits(value, precision);
    final v = getNumberOfVisibleFractionDigits(value, precision);

    if (v == 0 && i % 10 == 1 && i % 100 != 11 || f % 10 == 1 && f % 100 != 11) {
      return PluralCase.one;
    }
    if (v == 0 && i % 10 >= 2 && i % 10 <= 4 && (i % 100 < 12 || i % 100 > 14) ||
        f % 10 >= 2 && f % 10 <= 4 && (f % 100 < 12 || f % 100 > 14)) {
      return PluralCase.few;
    }
    return PluralCase.other;
  }
}
