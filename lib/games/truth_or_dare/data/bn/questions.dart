class TruthOrDareQuestion {
  final String category;
  final String type;
  final String text;

  const TruthOrDareQuestion({
    required this.category,
    required this.type,
    required this.text,
  });
}

const List<TruthOrDareQuestion> truthOrDareQuestions = [

  // ─────────────────────────
  // TRUTH — CLASSIC
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Truth',
    text: 'তোমার সবচেয়ে বিব্রতকর মুহূর্ত কোনটি?',
  ),

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Truth',
    text: 'তুমি জীবনে সবচেয়ে বড় কোন মিথ্যাটি বলেছ?',
  ),

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Truth',
    text: 'তোমার সবচেয়ে অদ্ভুত অভ্যাস কী?',
  ),

  // ─────────────────────────
  // DARE — CLASSIC
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Dare',
    text: '৩০ সেকেন্ড ধরে একটি মজার নাচ করো।',
  ),

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Dare',
    text: 'পরের এক মিনিট শুধু গান গেয়ে কথা বলো।',
  ),

  TruthOrDareQuestion(
    category: 'Classic',
    type: 'Dare',
    text: 'তোমার পাশে থাকা একজনকে নিয়ে একটি মজার প্রশংসা করো।',
  ),

  // ─────────────────────────
  // TRUTH — PARTY
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Party',
    type: 'Truth',
    text: 'এই ঘরে কাকে সবচেয়ে বেশি বিশ্বাস করো?',
  ),

  TruthOrDareQuestion(
    category: 'Party',
    type: 'Truth',
    text: 'বন্ধুদের মধ্যে কার সাথে সবচেয়ে বেশি দুষ্টুমি করো?',
  ),

  // ─────────────────────────
  // DARE — PARTY
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Party',
    type: 'Dare',
    text: 'তোমার ফোনের শেষ ছবিটি সবাইকে দেখাও।',
  ),

  TruthOrDareQuestion(
    category: 'Party',
    type: 'Dare',
    text: 'একজন বন্ধুর মতো করে ৩০ সেকেন্ড অভিনয় করো।',
  ),

  // ─────────────────────────
  // TRUTH — SPICY
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Spicy',
    type: 'Truth',
    text: 'তোমার কি এখন কোনো ক্রাশ আছে?',
  ),

  TruthOrDareQuestion(
    category: 'Spicy',
    type: 'Truth',
    text: 'তুমি কি কখনো তোমার ক্রাশের প্রোফাইল গোপনে অনেকবার দেখেছ?',
  ),

  // ─────────────────────────
  // DARE — SPICY
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Spicy',
    type: 'Dare',
    text: 'তোমার ক্রাশকে একটি সাধারণ "হাই" মেসেজ পাঠাও।',
  ),

  // ─────────────────────────
  // TRUTH — TABOO & CRINGE
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Taboo & Cringe',
    type: 'Truth',
    text: 'তোমার সবচেয়ে ক্রিঞ্জ মুহূর্ত কোনটি?',
  ),

  TruthOrDareQuestion(
    category: 'Taboo & Cringe',
    type: 'Truth',
    text: 'তুমি কি কখনো ভুল ব্যক্তিকে মেসেজ পাঠিয়েছ?',
  ),

  // ─────────────────────────
  // DARE — TABOO & CRINGE
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Taboo & Cringe',
    type: 'Dare',
    text: 'তোমার সবচেয়ে অদ্ভুত মুখভঙ্গি করে ২০ সেকেন্ড থাকো।',
  ),

  TruthOrDareQuestion(
    category: 'Taboo & Cringe',
    type: 'Dare',
    text: 'এক মিনিট ধরে খুব নাটকীয়ভাবে নিজের পরিচয় দাও।',
  ),

  // ─────────────────────────
  // TRUTH — DEEP & DARK
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Deep & Dark',
    type: 'Truth',
    text: 'তোমার জীবনের কোন সিদ্ধান্তটি তুমি বদলাতে চাইতে?',
  ),

  TruthOrDareQuestion(
    category: 'Deep & Dark',
    type: 'Truth',
    text: 'কোন বিষয়টি তোমাকে সবচেয়ে বেশি ভয় দেখায়?',
  ),

  // ─────────────────────────
  // DARE — DEEP & DARK
  // ─────────────────────────

  TruthOrDareQuestion(
    category: 'Deep & Dark',
    type: 'Dare',
    text: 'তোমার জীবনের একটি সত্যি কথা বলো যা খুব কম মানুষ জানে।',
  ),
];