import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/SplashScreen.dart';

List<Map<String, dynamic>> allProductsList = [
  {
    "categoryName": "Dusky Sky",
    "productName": "OCEAN MIST",
    "color": Color(0xff3793D6),
    "textColor": Color(0xff1A3F72),
    "imgUrl": "assets/category_intro/dusky_sky/ocean_mist/img1.png",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "alignment": "left",
    "productDescription":
        "MAKE CALMNESS FALL AT YOUR FEET AS U AMASS THE BEAUTY OF OCEAN MIST",
    "productImages": [
      "assets/product_final/dusky_sky/ocean_mist/img1.png",
      "assets/product_final/dusky_sky/ocean_mist/img2.png",
      "assets/product_final/dusky_sky/ocean_mist/img3.png",
      "assets/product_final/dusky_sky/ocean_mist/img4.png",
      "assets/product_final/dusky_sky/ocean_mist/img5.png",
      "assets/product_final/dusky_sky/ocean_mist/img6.png",
    ]
  },
  {
    "categoryName": "Dusky Sky",
    "productName": "ALMOND",
    "color": Color(0xffB49768),
    "textColor": Color(0xff3B2906),
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "imgUrl": "assets/category_intro/dusky_sky/almond/img1.png",
    "alignment": "right",
    "productDescription":
        "MAKES YOUR VISION AS SHARP AS THE MEMORY ENHANCED BY A WALNUT",
    "productImages": [
      "assets/product_final/dusky_sky/almond/img1.png",
      "assets/product_final/dusky_sky/almond/img2.png",
      "assets/product_final/dusky_sky/almond/img3.png",
      "assets/product_final/dusky_sky/almond/img4.png",
      "assets/product_final/dusky_sky/almond/img5.png",
      "assets/product_final/dusky_sky/almond/img6.png",
    ]
  },
  {
    "categoryName": "Dusky Sky",
    "productName": "TORNADO",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xff7A8D86),
    "textColor": Color(0xff3A3B3B),
    "imgUrl": "assets/category_intro/dusky_sky/tornado/img1.png",
    "alignment": "left",
    "productDescription":
        "REACH FOR THE SKIES WHILE ROLLING UP ALL YOUR OBSTACLES LIKE A TORNADO",
    "productImages": [
      "assets/product_final/dusky_sky/tornado/img1.png",
      "assets/product_final/dusky_sky/tornado/img2.png",
      "assets/product_final/dusky_sky/tornado/img3.png",
      "assets/product_final/dusky_sky/tornado/img4.png",
      "assets/product_final/dusky_sky/tornado/img5.png",
      "assets/product_final/dusky_sky/tornado/img6.png",
    ]
  },
  {
    "categoryName": "Dusky Sky",
    "productName": "LAVENDER",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xffC18CD5),
    "textColor": Color(0xff340140),
    "imgUrl": "assets/category_intro/dusky_sky/lavender/img1.png",
    "alignment": "right",
    "productDescription":
        "ROLL OUT SERENITY WHILE BLOOMING WITH THE ROYALTY AND ELEGANCE OF LAVENDER",
    "productImages": [
      "assets/product_final/dusky_sky/lavender/img1.png",
      "assets/product_final/dusky_sky/lavender/img2.png",
      "assets/product_final/dusky_sky/lavender/img3.png",
      "assets/product_final/dusky_sky/lavender/img4.png",
      "assets/product_final/dusky_sky/lavender/img5.png",
    ]
  },
  {
    "categoryName": "Natural Sky",
    "productName": "STARDUST",
    "color": Color(0xffC9C8C8),
    "textColor": Color(0xff625D5D),
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "imgUrl": "assets/category_intro/natural_sky/stardust/img1.png",
    "alignment": "left",
    "productDescription":
        "CATCH THE STARS WHILE U HAVE THE STARDUST SHIELDING YOUR EYES",
    "productImages": [
      "assets/product_final/natural_sky/stardust/img1.png",
      "assets/product_final/natural_sky/stardust/img2.png",
      "assets/product_final/natural_sky/stardust/img3.png",
      "assets/product_final/natural_sky/stardust/img4.png",
      "assets/product_final/natural_sky/stardust/img5.png",
      "assets/product_final/natural_sky/stardust/img6.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "ASTEROID",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xff6293B1),
    "textColor": Color(0xff053A5A),
    "imgUrl": "assets/category_intro/natural_sky/asteroid/img1.png",
    "alignment": "right",
    "productDescription":
        "WEAR ASTEROIDS IN YOUR EYES AND EXPERIENCE THE BEAUTY OF UNIVERSE IN YOUR LOOKS",
    "productImages": [
      "assets/product_final/natural_sky/asteroid/img2.png",
      "assets/product_final/natural_sky/asteroid/img3.png",
      "assets/product_final/natural_sky/asteroid/img4.png",
      "assets/product_final/natural_sky/asteroid/img1.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "MERMAID",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xff0C6755),
    "textColor": Color(0xff01241F),
    "imgUrl": "assets/category_intro/natural_sky/mermaid/img1.png",
    "alignment": "left",
    "productDescription":
        "DELUGE IN THE BLISS OF THE WATERS WITH THE STUPENDOUS SIGHT OF THE MERMAID",
    "productImages": [
      "assets/product_final/natural_sky/mermaid/img1.png",
      "assets/product_final/natural_sky/mermaid/img2.png",
      "assets/product_final/natural_sky/mermaid/img3.png",
      "assets/product_final/natural_sky/mermaid/img4.png",
      "assets/product_final/natural_sky/mermaid/img5.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "CAT EYE",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xff65861B),
    "textColor": Color(0xff144502),
    "imgUrl": "assets/category_intro/natural_sky/cat_eye/img1.png",
    "alignment": "right",
    "productDescription":
        "DAZZLE THE WORLD WITH THE FRIENDLINESS OF A CAT WHILE ENTICING THEM WITH YOUR CATS EYE",
    "productImages": [
      "assets/product_final/natural_sky/cat_eye/img1.png",
      "assets/product_final/natural_sky/cat_eye/img2.png",
      "assets/product_final/natural_sky/cat_eye/img3.png",
      "assets/product_final/natural_sky/cat_eye/img4.png",
      "assets/product_final/natural_sky/cat_eye/img5.png",
      "assets/product_final/natural_sky/cat_eye/img6.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "URANUS",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xff608D95),
    "textColor": Color(0xff0A4A4A),
    "imgUrl": "assets/category_intro/natural_sky/uranus/img1.png",
    "alignment": "left",
    "productDescription":
        "ENGAGE THE HUBBLE SPACE TELESCOPE TO FOLLOW YOU BY KEEPING URANUS UNDER YOUR CHECK",
    "productImages": [
      "assets/product_final/natural_sky/uranus/img1.png",
      "assets/product_final/natural_sky/uranus/img2.png",
      "assets/product_final/natural_sky/uranus/img3.png",
      "assets/product_final/natural_sky/uranus/img4.png",
      "assets/product_final/natural_sky/uranus/img5.png",
      "assets/product_final/natural_sky/uranus/img6.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "HONEY BEE",
    "color": Color(0xff5D3512),
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "textColor": Color(0xff1F1002),
    "imgUrl": "assets/category_intro/natural_sky/honey_bee/img1.png",
    "alignment": "right",
    "productDescription":
        "TINGLE THE WORLD WITH LOVE AS SWEET AS NECTOR WITH THE VISION OF A HONEYBEE",
    "productImages": [
      "assets/product_final/natural_sky/honey_bee/img1.png",
      "assets/product_final/natural_sky/honey_bee/img2.png",
      "assets/product_final/natural_sky/honey_bee/img3.png",
      "assets/product_final/natural_sky/honey_bee/img4.png",
    ],
  },
  {
    "categoryName": "Natural Sky",
    "productName": "CHEETAH",
    "price": globalProductPrice != null ? int.parse(globalProductPrice) : 1399,
    "color": Color(0xffAA894B),
    "textColor": Color(0xff463C24),
    "imgUrl": "assets/category_intro/natural_sky/cheetah/img1.png",
    "alignment": "left",
    "productDescription":
        "WEAR THIS DAZZLING YELLOW IN YOUR EYES AND LEAVE A TRAIL OF FEROCIOUSNESS WHEREVER YOU GO",
    "productImages": [
      "assets/product_final/natural_sky/cheetah/img1.png",
      "assets/product_final/natural_sky/cheetah/img2.png",
      "assets/product_final/natural_sky/cheetah/img3.png",
      "assets/product_final/natural_sky/cheetah/img4.png",
    ],
  },
  {
    "categoryName": "Solutions",
    "productName": "SOLUTION",
    "price": 99,
    "volume": "60 ml",
    "imgUrl": "assets/product_intro/solution.png",
  },
  {
    "categoryName": "Solutions",
    "productName": "SOLUTION",
    "price": 150,
    "volume": "120 ml",
    "imgUrl": "assets/product_intro/solution.png",
  },
];
