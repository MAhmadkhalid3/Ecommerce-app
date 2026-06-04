class CouponHelper {
  CouponHelper._();

  static const Map<String, _CouponRule> _rules = {
    'WELCOME10': _CouponRule(percentOff: 10, minSubtotal: 50),
    'SAVE20': _CouponRule(percentOff: 20),
    'FREESHIP': _CouponRule(freeShipping: true),
    'FLASH50': _CouponRule(flatOff: 50, minSubtotal: 200),
  };

  static double applyDiscount({
    required String code,
    required double subtotal,
    required double shippingFee,
  }) {
    final rule = _rules[code.trim().toUpperCase()];
    if (rule == null) return 0;

    if (rule.minSubtotal != null && subtotal < rule.minSubtotal!) {
      return -1; // signal invalid for min amount
    }

    if (rule.percentOff != null) {
      return subtotal * (rule.percentOff! / 100);
    }
    if (rule.flatOff != null) {
      return rule.flatOff!;
    }
    return 0;
  }

  static bool grantsFreeShipping(String code) {
    return _rules[code.trim().toUpperCase()]?.freeShipping ?? false;
  }

  static bool isValidCode(String code) {
    return _rules.containsKey(code.trim().toUpperCase());
  }
}

class _CouponRule {
  final double? percentOff;
  final double? flatOff;
  final double? minSubtotal;
  final bool freeShipping;

  const _CouponRule({
    this.percentOff,
    this.flatOff,
    this.minSubtotal,
    this.freeShipping = false,
  });
}
