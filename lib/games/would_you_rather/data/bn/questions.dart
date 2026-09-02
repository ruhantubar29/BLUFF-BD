class WouldYouRatherQuestion {
  final String category;
  final String question;
  final String optionA;
  final String optionB;

  const WouldYouRatherQuestion({
    required this.category,
    required this.question,
    required this.optionA,
    required this.optionB,
  });
}

const List<WouldYouRatherQuestion> wouldYouRatherQuestions = [
  // ─────────────────────────
  // CLASSIC
  // ─────────────────────────

  WouldYouRatherQuestion(
    category: 'Classic',
    question: 'তুমি কি উড়তে পারতে চাও নাকি অদৃশ্য হতে চাও?',
    optionA: 'উড়তে পারা',
    optionB: 'অদৃশ্য হওয়া',
  ),

  WouldYouRatherQuestion(
    category: 'Classic',
    question: 'তুমি কি অতীতে যেতে চাও নাকি ভবিষ্যতে যেতে চাও?',
    optionA: 'অতীতে যাওয়া',
    optionB: 'ভবিষ্যতে যাওয়া',
  ),

  WouldYouRatherQuestion(
    category: 'Classic',
    question: 'তুমি কি কখনো ঘুমের প্রয়োজন না হওয়া বেছে নেবে নাকি কখনো ক্ষুধার্ত না হওয়া?',
    optionA: 'ঘুমের প্রয়োজন না হওয়া',
    optionB: 'কখনো ক্ষুধার্ত না হওয়া',
  ),

  // ─────────────────────────
  // PARTY
  // ─────────────────────────

  WouldYouRatherQuestion(
    category: 'Party',
    question: 'তুমি কি পার্টিতে সবার সামনে নাচবে নাকি গান গাইবে?',
    optionA: 'নাচব',
    optionB: 'গান গাইব',
  ),

  WouldYouRatherQuestion(
    category: 'Party',
    question: 'তুমি কি সারাজীবন শুধু মজার পার্টিতে যেতে চাও নাকি শুধু মজার ভ্রমণে যেতে চাও?',
    optionA: 'পার্টি',
    optionB: 'ভ্রমণ',
  ),

  // ─────────────────────────
  // SPICY
  // ─────────────────────────

  WouldYouRatherQuestion(
    category: 'Spicy',
    question: 'তুমি কি তোমার ক্রাশকে মেসেজ পাঠাতে চাও নাকি তাকে ফোন করতে চাও?',
    optionA: 'মেসেজ পাঠানো',
    optionB: 'ফোন করা',
  ),

  WouldYouRatherQuestion(
    category: 'Spicy',
    question: 'তুমি কি তোমার ক্রাশের সাথে একা ডেটে যেতে চাও নাকি বন্ধুদের সামনে ডেটে যেতে চাও?',
    optionA: 'একা ডেট',
    optionB: 'বন্ধুদের সামনে ডেট',
  ),

  // ─────────────────────────
  // TABOO & CRINGE
  // ─────────────────────────

  WouldYouRatherQuestion(
    category: 'Taboo & Cringe',
    question: 'তুমি কি ভুল ব্যক্তিকে ব্যক্তিগত মেসেজ পাঠাতে চাও নাকি ভুল ব্যক্তিকে ছবি পাঠাতে চাও?',
    optionA: 'ভুল মেসেজ',
    optionB: 'ভুল ছবি',
  ),

  WouldYouRatherQuestion(
    category: 'Taboo & Cringe',
    question: 'তুমি কি সবার সামনে হোঁচট খেতে চাও নাকি সবার সামনে নিজের নাম ভুল বলতে চাও?',
    optionA: 'হোঁচট খাওয়া',
    optionB: 'নাম ভুল বলা',
  ),

  // ─────────────────────────
  // DEEP & DARK
  // ─────────────────────────

  WouldYouRatherQuestion(
    category: 'Deep & Dark',
    question: 'তুমি কি তোমার জীবনের সব ভুল জানতে চাও নাকি ভবিষ্যতের সব ভুল জানতে চাও?',
    optionA: 'অতীতের ভুল',
    optionB: 'ভবিষ্যতের ভুল',
  ),

  WouldYouRatherQuestion(
    category: 'Deep & Dark',
    question: 'তুমি কি এমন একটি সত্য জানতে চাও যা তোমাকে কষ্ট দেবে নাকি এমন একটি মিথ্যা বিশ্বাস করতে চাও যা তোমাকে সুখী রাখবে?',
    optionA: 'কষ্টদায়ক সত্য',
    optionB: 'সুখী করা মিথ্যা',
  ),
];