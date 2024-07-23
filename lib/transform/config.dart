const List<String> financeNames = [
  "美元 USD",
  "人民币 CNY",
  "欧元 EUR",
  "英镑 GBP",
  "日元 JPY",
  "韩元 KRW",
  "泰铢 THB",
  "港币 HKD",
  "澳大利亚元 AUD",
  "加拿大元 CAD",
  "新加坡元 SGD",
  "瑞士法郎 CHF",
  "新西兰元 NZD",
  "印度卢比 INR",
  "俄罗斯卢布 RUB",
  "南非兰特 ZAR",
  "菲律宾比索 PHP",
  "马来西亚林吉特 MYR",
  "印尼盾 IDR",
  "越南盾 VND",
  "巴西雷亚尔 BRL",
  "土耳其里拉 TRY",
  "墨西哥比索 MXN",
  "阿联酋迪拉姆 AED",
];

const Map<String, double> exchangeRatesToCNY = {
  "美元 USD": 6.75,
  "人民币 CNY": 1.0,
  "欧元 EUR": 7.32,
  "英镑 GBP": 8.55,
  "日元 JPY": 0.045,
  "韩元 KRW": 0.0051,
  "泰铢 THB": 0.19,
  "港币 HKD": 0.86,
  "澳大利亚元 AUD": 4.86,
  "加拿大元 CAD": 5.17,
  "新加坡元 SGD": 4.98,
  "瑞士法郎 CHF": 7.38,
  "新西兰元 NZD": 4.34,
  "印度卢比 INR": 0.090,
  "俄罗斯卢布 RUB": 0.092,
  "南非兰特 ZAR": 0.45,
  "菲律宾比索 PHP": 0.13,
  "马来西亚林吉特 MYR": 1.62,
  "印尼盾 IDR": 0.00047,
  "越南盾 VND": 0.00029,
  "巴西雷亚尔 BRL": 1.27,
  "土耳其里拉 TRY": 0.36,
  "墨西哥比索 MXN": 0.34,
  "阿联酋迪拉姆 AED": 1.84,
};


class CurrencyConverter {
  // 转换任意货币到人民币
  double convertToCNY(String currency, double amount) {
    if (exchangeRatesToCNY.containsKey(currency)) {
      return amount * exchangeRatesToCNY[currency]!;
    }
    throw ArgumentError("Invalid currency: $currency");
  }
}

