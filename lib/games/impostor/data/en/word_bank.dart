class WordEntry {
  const WordEntry({
    required this.word,
    required this.hints,
  });

  final String word;
  final List<String> hints;
}

class WordBank {
  WordBank._();

  static const Map<String, List<WordEntry>> bank = {
    "Animals": [
      WordEntry(word: "Elephant", hints: ["Big"]),
      WordEntry(word: "Tiger", hints: ["Jungle"]),
      WordEntry(word: "Lion", hints: ["King"]),
      WordEntry(word: "Giraffe", hints: ["Tall"]),
      WordEntry(word: "Monkey", hints: ["Tree"]),
      WordEntry(word: "Bear", hints: ["Honey"]),
      WordEntry(word: "Deer", hints: ["Forest"]),
      WordEntry(word: "Zebra", hints: ["Stripes"]),
      WordEntry(word: "Crocodile", hints: ["River"]),
      WordEntry(word: "Horse", hints: ["Race"]),
      WordEntry(word: "Dog", hints: ["Pet"]),
      WordEntry(word: "Cat", hints: ["Pet"]),
      WordEntry(word: "Rabbit", hints: ["Fast"]),
      WordEntry(word: "Penguin", hints: ["Ice"]),
      WordEntry(word: "Snake", hints: ["Venom"]),
    ],

    "Food": [
      WordEntry(word: "Biryani", hints: ["Rice"]),
      WordEntry(word: "Pizza", hints: ["Cheese"]),
      WordEntry(word: "Burger", hints: ["Bun"]),
      WordEntry(word: "Ice Cream", hints: ["Cold"]),
      WordEntry(word: "Chocolate", hints: ["Sweet"]),
      WordEntry(word: "Noodles", hints: ["Chinese"]),
      WordEntry(word: "Cake", hints: ["Birthday"]),
      WordEntry(word: "Samosa", hints: ["Fried"]),
      WordEntry(word: "Sandwich", hints: ["Bread"]),
      WordEntry(word: "Coffee", hints: ["Bitter"]),
      WordEntry(word: "Tea", hints: ["Cup"]),
      WordEntry(word: "Pasta", hints: ["Italy"]),
    ],

    "Superheroes": [
      WordEntry(word: "Batman", hints: ["Night"]),
      WordEntry(word: "Superman", hints: ["Flying"]),
      WordEntry(word: "Spider-Man", hints: ["Web"]),
      WordEntry(word: "Iron Man", hints: ["Armor"]),
      WordEntry(word: "Thor", hints: ["Thunder"]),
      WordEntry(word: "Hulk", hints: ["Angry"]),
      WordEntry(word: "Captain America", hints: ["Shield"]),
      WordEntry(word: "Wonder Woman", hints: ["Bracelets"]),
      WordEntry(word: "Flash", hints: ["Speed"]),
      WordEntry(word: "Aquaman", hints: ["Ocean"]),
      WordEntry(word: "Black Panther", hints: ["King"]),
      WordEntry(word: "Deadpool", hints: ["Funny"]),
    ],

    "Sports": [
      WordEntry(word: "Football", hints: ["Goal"]),
      WordEntry(word: "Cricket", hints: ["Bat"]),
      WordEntry(word: "Tennis", hints: ["Racket"]),
      WordEntry(word: "Badminton", hints: ["Shuttle"]),
      WordEntry(word: "Basketball", hints: ["Hoop"]),
      WordEntry(word: "Volleyball", hints: ["Net"]),
      WordEntry(word: "Boxing", hints: ["Gloves"]),
      WordEntry(word: "Swimming", hints: ["Water"]),
      WordEntry(word: "Golf", hints: ["Hole"]),
      WordEntry(word: "Cycling", hints: ["Wheels"]),
    ],

    "Countries": [
      WordEntry(word: "Bangladesh", hints: ["River"]),
      WordEntry(word: "India", hints: ["Taj Mahal"]),
      WordEntry(word: "Japan", hints: ["Sun"]),
      WordEntry(word: "Brazil", hints: ["Samba"]),
      WordEntry(word: "France", hints: ["Tower"]),
      WordEntry(word: "Australia", hints: ["Kangaroo"]),
      WordEntry(word: "USA", hints: ["Stars"]),
      WordEntry(word: "China", hints: ["Great Wall"]),
      WordEntry(word: "Germany", hints: ["Cars"]),
      WordEntry(word: "Italy", hints: ["Pizza"]),
    ],

    "Jobs": [
      WordEntry(word: "Doctor", hints: ["Hospital"]),
      WordEntry(word: "Teacher", hints: ["School"]),
      WordEntry(word: "Police Officer", hints: ["Uniform"]),
      WordEntry(word: "Farmer", hints: ["Field"]),
      WordEntry(word: "Chef", hints: ["Kitchen"]),
      WordEntry(word: "Pilot", hints: ["Cockpit"]),
      WordEntry(word: "Driver", hints: ["Steering"]),
      WordEntry(word: "Engineer", hints: ["Blueprint"]),
      WordEntry(word: "Photographer", hints: ["Camera"]),
      WordEntry(word: "Singer", hints: ["Microphone"]),
    ],

    "Fruits": [
      WordEntry(word: "Mango", hints: ["King"]),
      WordEntry(word: "Banana", hints: ["Monkey"]),
      WordEntry(word: "Apple", hints: ["Red"]),
      WordEntry(word: "Orange", hints: ["Juice"]),
      WordEntry(word: "Watermelon", hints: ["Summer"]),
      WordEntry(word: "Pineapple", hints: ["Spiky"]),
      WordEntry(word: "Grape", hints: ["Bunch"]),
      WordEntry(word: "Strawberry", hints: ["Red"]),
      WordEntry(word: "Papaya", hints: ["Seeds"]),
      WordEntry(word: "Coconut", hints: ["Water"]),
    ],

    "Cartoons": [
      WordEntry(word: "Tom and Jerry", hints: ["Chase"]),
      WordEntry(word: "Doraemon", hints: ["Pocket"]),
      WordEntry(word: "Shinchan", hints: ["Naughty"]),
      WordEntry(word: "Mickey Mouse", hints: ["Ears"]),
      WordEntry(word: "SpongeBob", hints: ["Ocean"]),
      WordEntry(word: "Scooby-Doo", hints: ["Dog"]),
      WordEntry(word: "Ben 10", hints: ["Watch"]),
      WordEntry(word: "Pokemon", hints: ["Ball"]),
      WordEntry(word: "The Lion King", hints: ["Savanna"]),
      WordEntry(word: "Frozen", hints: ["Ice"]),
    ],

    "Brands": [
      WordEntry(word: "Apple", hints: ["Bitten"]),
      WordEntry(word: "Samsung", hints: ["Galaxy"]),
      WordEntry(word: "Sony", hints: ["PlayStation"]),
      WordEntry(word: "Nike", hints: ["Swoosh"]),
      WordEntry(word: "Adidas", hints: ["Stripes"]),
      WordEntry(word: "McDonald's", hints: ["Burger"]),
      WordEntry(word: "Coca-Cola", hints: ["Red"]),
      WordEntry(word: "Pepsi", hints: ["Blue"]),
      WordEntry(word: "Toyota", hints: ["Car"]),
      WordEntry(word: "Google", hints: ["Search"]),
    ],

    "Anime": [
      WordEntry(word: "Naruto", hints: ["Ramen"]),
      WordEntry(word: "One Piece", hints: ["Pirates"]),
      WordEntry(word: "Bleach", hints: ["Soul"]),
      WordEntry(word: "Dragon Ball", hints: ["Saiyan"]),
      WordEntry(word: "Death Note", hints: ["Notebook"]),
      WordEntry(word: "Demon Slayer", hints: ["Demons"]),
      WordEntry(word: "Jujutsu Kaisen", hints: ["Curse"]),
      WordEntry(word: "Attack on Titan", hints: ["Giants"]),
      WordEntry(word: "One Punch Man", hints: ["Bald"]),
      WordEntry(word: "Pokémon", hints: ["Pokeball"]),
    ],
  };

  static List<WordEntry> entriesFor(String categoryName) {
    return bank[categoryName] ?? const [];
  }
}