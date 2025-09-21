//
//  Content.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//
import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
   

    let products: [Product] = [
        Product(
            id: "1",
            name: "Cotton T-shirt",
            category: "Men",
            price: 69.0,
            oldPrice: 169.0,
            imageUrl: "1",
            desc: """
    Elevate your casual wardrobe with our premium Cotton T-shirt, designed for ultimate comfort and effortless style. Crafted from 100% high-quality cotton, this t-shirt offers a soft, breathable feel that keeps you cool throughout the day. Whether you're running errands, meeting friends, or relaxing at home, it’s your go-to staple for everyday wear. 

    The classic crew neckline and short sleeves provide a timeless silhouette that pairs perfectly with jeans, shorts, or joggers. The fabric is pre-shrunk to maintain its shape wash after wash, ensuring a long-lasting fit and feel. This versatile t-shirt comes in a range of colors that can be easily mixed and matched with your existing wardrobe, offering countless styling options for both casual and semi-formal occasions.

    Designed with attention to detail, the seams are reinforced for durability, and the smooth finish prevents irritation against the skin. It's lightweight enough for layering under jackets or hoodies during cooler months, yet substantial enough to wear alone in warmer weather. The fabric's natural stretch accommodates a full range of motion, making it ideal for active lifestyles, whether you're heading to the gym or enjoying outdoor activities.

    Beyond comfort, this Cotton T-shirt emphasizes style and practicality. Its minimalist design is complemented by a subtle, elegant finish that transitions seamlessly from day to night. Dress it up with accessories or keep it simple for a clean, classic look. The easy-care fabric is machine washable, colorfast, and resistant to fading, making it a reliable addition to your daily wardrobe.

    Experience the perfect balance of style, comfort, and durability with this essential Cotton T-shirt, crafted to become a staple piece you’ll reach for again and again.
    """
        ),
        Product(
            id: "2",
            name: "Summer Dress",
            category: "Women",
            price: 89.0,
            oldPrice: 179.0,
            imageUrl: "2",
            desc: """
    Step into effortless elegance with our Summer Dress, meticulously designed for warmth, comfort, and style. Made from lightweight, breathable fabric, this dress ensures you stay cool while looking chic during sunny days and evening strolls. Its flowing silhouette drapes gracefully over the body, flattering every shape and offering an elegant, feminine appeal.

    Featuring adjustable straps and a modest neckline, the dress is both stylish and practical for a variety of occasions—from casual brunches to garden parties. The hemline is designed to move with ease, creating a soft, fluid motion that adds sophistication to your walk. The vibrant, season-inspired patterns bring a fresh, lively feel to your wardrobe, perfect for expressing your personal style during warmer months.

    The fabric is soft to the touch, wrinkle-resistant, and easy to maintain, ensuring your dress remains in pristine condition wear after wear. Its versatile design allows for effortless accessorizing; pair it with sandals, wedges, or flats, and add a statement necklace or earrings for a polished look. Lightweight enough to carry in your travel bag, it’s the ideal companion for vacations, beach trips, and outdoor adventures.

    Every detail, from the stitching to the finishing, has been thoughtfully executed to enhance durability and comfort. The breathable material wicks away moisture and allows air circulation, making it ideal for hot, sunny days. Whether dressing up for a casual day out or layering with a light cardigan for cooler evenings, this Summer Dress is a wardrobe essential for a confident, stylish summer.
    """
        ),
        Product(
            id: "3",
            name: "Girls Skirt",
            category: "Girls",
            price: 49.0,
            oldPrice: 99.0,
            imageUrl: "3",
            desc: """
    Make every day a playful fashion statement with our Girls Skirt, designed for comfort, fun, and style. Crafted from soft, high-quality cotton blend fabric, this skirt is gentle on sensitive skin while allowing free movement for all-day adventures. The elastic waistband provides a secure, snug fit that grows with your child, making it easy to put on and take off.

    The skirt features charming details, from vibrant colors to cute patterns, that spark creativity and confidence in little girls. Its lightweight design ensures breathability, making it perfect for school days, playground fun, birthday parties, or casual outings. The fabric is durable and resilient, holding up to frequent washes and energetic play, ensuring it looks fresh and neat every day.

    Designed for versatility, it pairs beautifully with a variety of tops, including tees, blouses, or hoodies, providing endless styling options. The flowing hemline adds a touch of elegance and charm, encouraging playful twirls and dynamic movement. Its machine-washable nature ensures convenience for busy parents while maintaining quality and softness.

    Whether layered with leggings during cooler months or worn alone in the summer, this Girls Skirt offers both style and practicality. It’s the ideal choice for parents seeking a combination of comfort, durability, and trend-conscious design that your little one will love to wear every day.
    """
        ),
        Product(
            id: "4",
            name: "Men Hoodie",
            category: "Men",
            price: 99.0,
            oldPrice: 199.0,
            imageUrl: "4",
            desc: """
    Stay warm and stylish with our Men Hoodie, the ultimate blend of comfort and modern fashion. Crafted from soft, brushed cotton fabric with a touch of polyester for durability, this hoodie provides cozy warmth without sacrificing breathability. Its classic pullover design features a roomy hood and adjustable drawstrings, perfect for layering over t-shirts or under jackets.

    The kangaroo pocket offers practical storage and a place to warm your hands, while reinforced stitching ensures long-lasting wear. Its relaxed fit accommodates layering while maintaining a sleek, contemporary silhouette. Ideal for casual outings, gym sessions, or lounging at home, this hoodie is versatile enough to become a wardrobe staple for any man.

    The material resists fading and shrinkage, allowing the hoodie to maintain its shape and color after repeated washes. With ribbed cuffs and hem, it stays snug and comfortable, keeping warmth locked in. The soft inner lining enhances comfort, making it perfect for all-day wear during cooler seasons.

    Pair it effortlessly with jeans, joggers, or shorts, and style with sneakers or boots for a casual yet refined look. This Men Hoodie combines quality craftsmanship, comfort, and timeless style to create a versatile garment that fits seamlessly into your everyday lifestyle.
    """
        ),
        Product(
            id: "5",
            name: "Women Top",
            category: "Women",
            price: 79.0,
            oldPrice: 159.0,
            imageUrl: "5",
            desc: """
    Our Women Top is crafted for elegance, comfort, and day-to-night versatility. Made from lightweight, breathable fabric, it ensures all-day comfort while offering a polished, stylish appearance. The flattering neckline and tailored cut enhance natural curves, making it perfect for work, casual outings, or social gatherings.

    Featuring subtle detailing, such as delicate stitching and soft textures, this top adds sophistication to your wardrobe without compromising comfort. Its easy-care design is machine washable, retaining shape and color after multiple washes. Pair it with skirts, trousers, or jeans to effortlessly create stylish ensembles suitable for various occasions.

    Ideal for layering, it can be worn under blazers, cardigans, or jackets, offering flexibility across seasons. The fabric is soft against the skin, breathable, and resilient, ensuring durability and a premium feel. With a range of colors available, it seamlessly integrates into any wardrobe, becoming a reliable go-to piece for modern women seeking both style and practicality.
    """
        ),
        Product(
            id: "6",
            name: "Kids Shoes",
            category: "Girls",
            price: 39.0,
            oldPrice: 89.0,
            imageUrl: "6",
            desc: """
    These Kids Shoes combine comfort, support, and style for active little feet. Constructed with lightweight, breathable materials, they ensure all-day comfort and ventilation, keeping feet cool during energetic play. The non-slip sole provides stability and safety, making them ideal for playgrounds, school, or outdoor adventures.

    Designed with durability in mind, the shoes withstand daily wear and tear while maintaining their shape and finish. The cushioned insole offers soft support, and the flexible sole accommodates natural foot movement, promoting healthy growth. Velcro straps or elastic closures allow easy on-and-off for young children.

    Available in vibrant, playful colors, these shoes encourage kids to express their personality while coordinating easily with casual outfits. The quality materials are easy to clean and maintain, ensuring the shoes remain fresh and comfortable over time. Perfect for parents seeking a balance of practicality, style, and long-lasting performance for their children.
    """
        ),
        Product(
            id: "7",
            name: "Men Jacket",
            category: "Men",
            price: 149.0,
            oldPrice: 249.0,
            imageUrl: "7",
            desc: """
    Our Men Jacket delivers style, warmth, and functionality in one premium garment. Crafted from durable, weather-resistant fabric, it provides protection against wind and light rain, making it ideal for outdoor activities and daily wear. The jacket features a classic collar, secure zipper closure, and multiple pockets for practicality and convenience.

    The interior lining offers comfort and insulation, keeping you cozy during cooler weather. Adjustable cuffs and hem allow a tailored fit while ensuring freedom of movement. Its sleek design and neutral tones make it easy to pair with casual or semi-formal attire, making it a versatile wardrobe essential.

    Attention to detail, quality stitching, and premium materials ensure the jacket maintains its structure, shape, and color over time. Whether layered over sweaters or t-shirts, it provides a modern, masculine silhouette without compromising comfort or style.
    """
        ),
        Product(
            id: "8",
            name: "Women Handbag",
            category: "Women",
            price: 129.0,
            oldPrice: 229.0,
            imageUrl: "8",
            desc: """
    This Women Handbag combines elegance, functionality, and durability. Crafted from premium faux leather, it provides a smooth, luxurious finish while remaining lightweight for everyday use. The spacious interior offers organized compartments for essentials like wallets, phones, and cosmetics, keeping belongings secure and accessible.

    Featuring a chic design with versatile straps, it can be carried by hand or over the shoulder, adapting to different occasions and outfits. The secure zipper and snap closures ensure items stay safe while maintaining stylish appeal. Its contemporary aesthetic complements casual, business, or evening attire effortlessly.

    Designed for long-lasting use, the material resists scratches, stains, and wear, maintaining a polished look over time. Ideal for modern women seeking a combination of practicality, sophistication, and on-trend style, this handbag is a reliable companion for daily life or special occasions.
    """
        ),
        Product(
            id: "9",
            name: "Girls T-shirt",
            category: "Girls",
            price: 29.0,
            oldPrice: 69.0,
            imageUrl: "9",
            desc: """
    Our Girls T-shirt is soft, comfortable, and perfect for everyday adventures. Made from breathable cotton fabric, it keeps little ones cool and flexible during school, playtime, or casual outings. The stretchy material allows freedom of movement, ensuring active children stay comfortable all day.

    The T-shirt features fun prints, vibrant colors, and a classic fit, appealing to young girls while being practical for parents. Reinforced stitching enhances durability, making it resistant to wear from washing and daily activities. Its easy-care design ensures it stays fresh, soft, and vibrant over time.

    Pair it with skirts, shorts, or leggings to create cute, stylish outfits. Lightweight yet durable, it’s a must-have staple for girls’ wardrobes that balances practicality, comfort, and playful fashion.
    """
        ),
        Product(
            id: "10",
            name: "Men Sneakers",
            category: "Men",
            price: 89.0,
            oldPrice: 179.0,
            imageUrl: "10",
            desc: """
    Our Men Sneakers combine comfort, support, and contemporary style for everyday wear. Constructed with breathable materials, cushioned insoles, and flexible soles, these sneakers provide all-day comfort and protection for your feet. The durable rubber outsole ensures grip and stability on multiple surfaces, ideal for urban commuting or casual sports.

    Featuring a modern design and sleek silhouette, these sneakers pair perfectly with jeans, shorts, or casual pants, making them versatile for various occasions. The lace-up closure offers a secure fit, while lightweight construction ensures agility and effortless movement.

    Designed to withstand frequent wear, these sneakers maintain shape, color, and performance over time. The combination of comfort, functionality, and on-trend aesthetics makes them a must-have for men seeking reliable, stylish footwear for daily use.
    """
        )
    ]
}
