class MafiaRole {
  final String id;
  final String name;
  final String description;
  final String emoji;

  const MafiaRole({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
  });
}

const mafiaRoles = [
  MafiaRole(
    id: 'mafia',
    name: 'মাফিয়া',
    description:
        'রাতে একজন খেলোয়াড়কে টার্গেট করো।',
    emoji: '🔪',
  ),
  MafiaRole(
    id: 'doctor',
    name: 'ডাক্তার',
    description:
        'রাতে একজন খেলোয়াড়কে বাঁচানোর চেষ্টা করো।',
    emoji: '👨‍⚕️',
  ),
  MafiaRole(
    id: 'detective',
    name: 'ডিটেকটিভ',
    description:
        'রাতে একজন খেলোয়াড়ের পরিচয় তদন্ত করো।',
    emoji: '🕵️',
  ),
  MafiaRole(
    id: 'villager',
    name: 'গ্রামবাসী',
    description:
        'মাফিয়াকে খুঁজে বের করো এবং ভোট দাও।',
    emoji: '🧑',
  ),
];