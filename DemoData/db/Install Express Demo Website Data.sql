-- ------------------------------------------------------------------------------------------
-- Copyright AspDotNetStorefront.com.  All Rights Reserved.
-- http://www.aspdotnetstorefront.com
-- For details on this license please visit  the product homepage at the URL above.
-- THE ABOVE NOTICE MUST REMAIN INTACT.
-- ------------------------------------------------------------------------------------------
--To clear all 
delete from Product
go
delete from ProductCategory
go
delete from ProductSection
go
delete from ProductVariant
go
delete from ProductManufacturer
go
delete from Category
go
delete from Section
go
delete from Manufacturer
go
delete from ProductView
go
delete from KitGroup
go
delete from KitItem
go
delete from Genre
go
delete from Vector
go
delete from ProductGenre
go
delete from ProductVector
go
delete from Distributor
go
delete from ProductDistributor
go
delete from Affiliate
go
delete from ProductAffiliate
go
delete from LocaleSetting
go
delete from Currency
go
delete from ShippingMethod
go
delete from ShippingWeightByZone
go
delete from ShippingZone
go
delete from Customer where customerid != 58639
go
delete from Address where AddressID  != 1
go
DELETE FROM ORDEROPTION
go
DELETE FROM Orders WHERE OrderNumber IN (100137,100139,100140,100141,100156)
go
DELETE FROM Orders_ShoppingCart WHERE OrderNumber IN (100137,100139,100140,100141,100156)
go
DELETE FROM OrderNumbers WHERE OrderNumber IN (100137,100139,100140,100141,100156)
GO


--_Category
set IDENTITY_INSERT [dbo].Category ON;
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(1,'Video Games','video-games',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(2,'Electronic Toys','electronic-toys',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(3,'Riding Toys','riding-toys',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(4,'Major Appliances','major-appliances',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(6,'Kids Jewelry','kids-jewelry',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(10,'Desktops','desktops',1,0,0,0);
INSERT [dbo].Category(CategoryID,Name,SEName,Published,AllowSectionFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(32,'MP3','music',1,0,0,0);
set IDENTITY_INSERT [dbo].Category OFF;
GO

--_Section
set IDENTITY_INSERT [dbo].Section ON;
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(1,'Electronics','electronics',1,0,0,0);
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(2,'Toys','toys',1,0,0,0);
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(3,'Appliances','appliances',1,0,0,0);
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(4,'Jewelry & Accessories','jewelry-accessories',1,0,0,0);
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(6,'Computers','computers',1,0,0,0);
INSERT [dbo].Section(SectionID,Name,SEName,Published,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering) values(13,'Books/cds/movies/mp3','books-cds-movies-mp3',1,0,0,0);
set IDENTITY_INSERT [dbo].Section OFF;
GO

--_Manufacturer
set IDENTITY_INSERT [dbo].Manufacturer ON;
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(1,'Sony','Sony');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(2,'Nintendo','Nintendo');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(3,'Team Up','Team-Up');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(4,'Megatech','Megatech');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(5,'Kettler','Kettler');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(6,'Caterpillar','Caterpillar');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(7,'Step2','Step2');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(8,'Microsoft','Microsoft');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(9,'Whirlpool','Whirlpool');
INSERT [dbo].Manufacturer(ManufacturerID,Name,SEName) values(12,'HP','HP');
set IDENTITY_INSERT [dbo].Manufacturer OFF;
GO

--_Genre
set IDENTITY_INSERT [dbo].Genre ON;
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (1,'Sony Playstation', 1,1);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (2,'Nintendo DS', 1,2);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (3,'Remote Control Toys', 1,3);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (4,'Wagons & Push Riding Toys', 1,4);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (5,'Microsoft Xbox', 1,5);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (6,'Refrigerators', 1,6);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (7,'Microwaves', 1,7);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (8,'Kids Necklaces', 1,8);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (14,'Desktop Home', 1,14);
INSERT INTO [dbo].Genre(GenreID,Name,Published,DisplayOrder) values (29,'Rap Music', 1,29);
set IDENTITY_INSERT [dbo].Genre OFF;
GO

--_Distributor
set IDENTITY_INSERT [dbo].Distributor ON;
INSERT INTO [dbo].Distributor (DistributorID,Name,Published) VALUES (1,'Acme Distributing',1);
INSERT INTO [dbo].Distributor (DistributorID,Name,Published) VALUES (2,'Foobar Inc.',1);
set IDENTITY_INSERT [dbo].Distributor OFF;
GO

--_Affiliate
set IDENTITY_INSERT [dbo].Affiliate ON;
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(1,'Sony','Sony Computer Entertainment Inc.',1);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(2,'Nintendo','Nintendo Company Ltd',2);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(3,'Megatech','Megatech International',3);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(4,'Kettler','Kettler',4);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(5,'CAT','Caterpillar',5);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(6,'Step2','Step2 Company',6);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(7,'Microsoft','Microsoft Corporation',7);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(8,'Whirlpool','Whirlpool Corporation',8);
INSERT [dbo].Affiliate(AffiliateID,Name,Company,DisplayOrder) values(11,'HP','Hewlett-Packard Development Company',11);
set IDENTITY_INSERT [dbo].Affiliate OFF;
go

--_Product
set IDENTITY_INSERT [dbo].Product ON;
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(1, 'Playstation 3','As DVD playback made the PlayStation 2 more than just a game machine, hefty multi-media features make the Sony PlayStation 3 an even more versatile home entertainment machine. Features such as video chat, Internet access, digital photo viewing, and digital audio and video will likely make it the central component of your media set-up. Still, it is first and foremost a game console--a powerful one at that.',1,1,'01-0001',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(2, 'PlaysStation Portable(PSP)','The PSP is primarily a game console (PSP games come in UMD, or Universal Media Disc, format), but it can also play UMD-format movies. Using a memory stick, the PSP can play music and video files, and display picture files such as photos. This portable console can also connect to the internet via a web browser (not incuded in early firmware releases) and built-in wi-fi.',1,1,'01-0002',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(3, 'Nintendo DS Lite','The Nintendo DS Lite is a high-powered handheld video game system in a sleek folding design loaded with features for a unique gaming experience. The color screens are now even brighter and the lower touchscreen provides a totally new way of playing and controlling games. Use the built-in wireless mode to share games, chat or even play multiplayer games on-line via Nintendo Wi-Fi Connection. Play impressive 3-D rendered Nintendo DS games and play all your favorite Game Boy Advance games in single player mode. Nintendo DS Lite comes with a variety of distinctive changes that set it apart from the original: it’s less than two-thirds the size of the original Nintendo DS and more than 20% lighter; its 2 bright screens can be adjusted to 4 levels to adapt to different lighting conditions and to extend battery power; the microphone sits in the center of the unit, and the LED lights are clearly visible whether the unit is open or closed; the stylus is 1 cm. longer and 1 mm. thicker than the stylus of the original, and slides into a side storage slot; the Start and Select buttons were repositioned for easier access and a removable cover keeps the Game Boy Advance cartridge slot clear from dust and debris when it’s not in use.',1,1,'01-0003',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(4, 'Team Up Nascar RC Cars','This officially licensed 1:18 scale NASCAR remote control car is designed with detailed authentic graphics and has over a 50-yard signal range. It is the perfect gift for any NASCAR fan!',1,1,'01-0004',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(5, 'Megatech MegaBotz RC Artificial Intelligence Battle Vehicles','The Megatech MegaBotz will chase one another and battle until one vehicle loses all 10 of its "life" lights and the game is over. Choose any of the play modes: you against a friend, you against the other MegaBotz set on artificial intelligence mode or both MegaBotz set on artificial intelligence mode to battle each other while you watch.',1,1,'01-0005',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(6, 'Megatech Micro Fly RC Featherweight Helicopter','The total control Micro Fly weighs a mere 2oz. Although its light, you have complete up, down, left, and right RC control with selectable forward, hover, or backward flight mode. The Micro Fly comes totally built, brightly painted, and ready to fly. With its counter-rotating main rotor blades, and weight gyroscopic fly-bar, its so stable that youll be hovering around the house and landing on the coffee table in no time.',1,1,'01-0006',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(7, 'Megatech AirStrike Electric Powered Free Flight Airplane','The AirStrike Free Flight Airplane is specifically designed for children showing an interest in aviation. With a clean design and the included easy to understand instruction booklet, the basics of aerodynamics can be quickly understood and applied. The unique break-away wing design allows the airplane to be flown again and again even after a crash landing.',1,1,'01-0007',1,1)	
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(8, 'Avion Remote Control Electric 5-Inch Wingspan Biplane','Megatechs Avion will convert your living room into an indoor aerodrome. Boasting a tight 3-foot turning radius, Avion is a high performance, precision controlled, highly maneuverable, ready-to-fly, easy to use, indoor aerobat.',1,1,'01-0008',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(9, 'Kettler Classic Flyer Air Tire Wagon','The Kettler Classic Flyer Air Tire Wagon features a wagon body of natural wood. Use it with or without the 4 removable wooden slats. Durable air tires for a smooth and quiet ride and ergonomically designed handle for easy pulling make every walk a pleasure.',1,1,'01-0009',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(10, 'Kettler Classic Flyer First Trike','The Kettler Classic Flyer First Trike is a natural hardwood foot to floor trike. Limited turn steering and a wide front wheelbase ensure that your child will not tip over while learning to ride this classic mobile machine.',1,1,'01-0010',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(11, 'Caterpillar CAT Digger Ride-On Toy','Wow! The Caterpillar CAT Digger Ride-On Toy makes it easy to imagine youre working right on the construction site. Real working dual action levers and a large resin digging shovel make pretending fun. The digger rotates 360° and sits on 4 rolling wheels to move forward and backwards.',1,1,'01-0011',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(12, 'Step2 Whisper Ride Buggy','Ease your childs transition out of their stroller with the new Whisper Ride Buggy. Extra-Large Silent Ride Tires, a cupholder, and the pretend steering wheel with electronic horn keep your child happy, and the under-hood storage compartment, seat belt, and removable handle make trips easier on you! (2 AAA batteries not included.)',1,1,'01-0012',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(13, 'Step2 Up and Down Roller Coaster','This award-winning roller coaster is a Step2 favorite. With non-slip steps and snap-together construction, amusement-park fun lives in your play room or back yard.',1,1,'01-0013',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(14, 'Microsoft Xbox 360','The Xbox 360 Premium System is the way to begin experiencing the ultimate in next-generation gaming. Now improved with an HDMI port, your games and video entertainment will look better than ever when connected to an HDTV. Amazing Digital entertainment and video gaming experiences, unprecedented in home console entertainment, are waiting for you -- all you have to do is turn on the controller to this incredible device and an unsurpassed level of adventure and excitement can be yours. Xbox Live Marketplace - Download the latest game demos, arcade games, television, movies, and more straight to your Xbox 360 console via any Broadband Internet service Games - Games look, feel, and Sound realistic with 480p/720p/1080i HD Output via HDMI or Component cable, 16 - 9 widescreen aspect ratio, anti-aliasing, and multi-channel Surround sound support Digital Entertainment - Play DVD movies right out of the box, play HD DVDs with the Optional HD-DVD Player (sold separately), rip music to the 360 Hard Drive, connect your Digital Camera and share your digital pictures with friends, or connect your Xbox 360 to a Windows XP or Windows Vista Media Center PC and Stream TV, Music, Movies, and Pictures to your Xbox 360 console over your network! NOTE - Some features may require optional Xbox Live GOLD service; One month of complementary Xbox Live GOLD service is included',1,1,'01-0014',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(15, 'Megatech Party Blimp RC 4-Channel Electric Ready-To-Fly Blimp','Where no party has gone before! Add excitement to any indoor event. If youre looking for that special item which will set your party apart from any other - youve just found it. Control a 3 long helium blimp thats orbiting the festivities with a personalized message. Simply fill with helium available at florists and party stores.',1,1,'01-0015',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(16, 'Megatech Radio Rodent RC Electric Mouse','Radio Rodent is on the loose! Terrorize your parents with eyes that light-up red and a tail that will flip your mouse upright. Experience wild and crazy radio control fun with this remote control mouse.',1,1,'01-0016',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(17, 'Megatech Firefly RC 2-Channel Electric Ready-To-Fly Airplane','Designed with the first time flyer in mind! The FireFly is the complete package. It is a 100% ready-to-fly airplane and it comes in its own carrying case. Fly indoors and out with stability and ease.',1,1,'01-0017',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(18, 'Whirlpool French Door Satina Refrigerator','Satina is a painted monochromatic finish that has a stainless look. # Capacity: 24.9 cu. ft. (18.3 cu. ft. refrigerator / 6.6 cu. ft. freezer). ENERGY STAR® Qualified. Contour smooth door. External ice & water dispenser. Water filter & indicator. 4 spill-proof adjustable glass shelves (1 mini & 3 slide-out). Hanging wire shelf. 2 humidity-controlled crispers. 5 Clear Door Bins (2 Gallon-Size) with Grip Pads. 2 opaque condiment holders (in door). Factory installed automatic ice maker. 2 wire freezer baskets (rack & pinion system). Blue lower freezer basket tray',1,1,'01-0018',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(19, 'Whirlpool Side by Side Stainless Steel Refrigerator','Capacity: 25.3 cu. ft. (15.4 cu. ft Refrigerator / 9.9 cu.ft. Freezer). 2008 ENERGY STAR® Qualified. Traditional styling. In-door-ice® ice dispensing system. Standard temperature management. Pur® 6-month water filtration. Water filter indicator light. Backlit slide temperature controls. Sylvania daylight® interior lighting. Adaptive defrost system (ads). Adjustable gallon door bin. Gallon door bins: 3. Spillguard™ glass shelves. Clear humidity-controlled crisper. Clear temperature-controlled meat pan. Clear snack pan. Full-width humidity-controlled crisper. 4 door shelves. 4 shelves, 1 bin freezer storage. 3 fresh food shelves. 2 spillproof, 1 fixed pan shelf shelving ',1,1,'01-0019',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(20, 'Whirlpool Bottom Mount Stainless Steel Refrigerator','Capacity: 21.9 cu. ft.(15.6 cu. ft. refrigerator / 6.3 cu. ft. freezer). ENERGY STAR® Qualified. Smooth door. Interior water dispenser. Factory installed automatic ice maker. Digital temperature control. 3 slide-out spill-proof shelves & 1 standard spill-proof shelf. 2 humidity-controlled crispers. 1 dairy compartment. 1 clear full-width framed pantry. 1 wire can rack. 4 clear door bins with 2 blue mats. 1 fixed opaque full-width gallon door bin. 2 slide-out freezer baskets. Reversible door',1,1,'01-0020',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(21, 'Whirlpool MaxWave','Maxwave™ Cooking System: The unique system releases microwave energy from multiple points inside the oven cavity. Uniform cooking ensures your food is cooked throughout, without cold centers or overdone edges. Precision and speed means you can enjoy a meal in just a few minutes.',1,1,'01-0021',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(22, 'Childs Sterling Silver Little Angel Heart 2-Tone Locket','This precious pendant is perfect for that sweet little one. Featuring a 2-tone sterling silver locket with a cherub angel on front, the whole package rests on a 13" sterling silver chain.',1,1,'01-0022',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(23, 'Gold-Filled Engraved Childrens Heart Locket','A sweet little hand-engraved heart with satin and polished finishes hangs delicately on a 13" chain.',1,1,'01-0023',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,IsAKit) values(48, 'HP Pavilion Slimline s3600t PC','Full PC functionality in one-third the size - The HP Pavilion Slimline PC, featuring Intel(R) desktop processors.',2,1,'01-00048',1,1)
INSERT [dbo].Product(ProductID,Name,Description,ProductTypeID,SalesPromptID,SKU,Published,ShowInProductBrowser) values(201, 'MP3 Songs','Buy your favorite music right here right now!',1,1,'01-00201',1,1)
set IDENTITY_INSERT [dbo].Product OFF;
GO

--_Product Affiliate
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (1,1,1);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (2,1,2);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (3,2,3);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (5,3,5);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (6,3,6);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (7,3,7);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (8,3,8);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (9,4,9);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (10,4,10);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (11,5,11);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (12,6,12);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (13,6,13);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (14,7,14);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (15,3,15);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (16,3,16);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (17,3,17);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (18,8,18);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (19,8,19);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (20,8,20);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (21,8,21);
INSERT INTO [dbo].ProductAffiliate(ProductID,AffiliateID,DisplayOrder) VALUES (48,11,48);
go

--_LocaleSetting 
set IDENTITY_INSERT [dbo].LocaleSetting ON;
INSERT [dbo].LocaleSetting(LocaleSettingID,Name,DisplayOrder,Description) values(1,'en-US' ,1,'United States');
--INSERT [dbo].LocaleSetting(LocaleSettingID,Name,DisplayOrder,Description) values(2,'es-ES' ,2,'Spain');
set IDENTITY_INSERT [dbo].LocaleSetting OFF;
GO

--_Currency
set IDENTITY_INSERT [dbo].Currency ON;
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(1,'US Dollar','USD',1.00,1,1,'en-US');
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(2,'Canadian Dollar','CAD',1,0,2,'en-CA');
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(3,'Spanish Peseta EUR','ESP',1,0,2,'es-ES');
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(4,'British Pound','GBP',1,0,2,'en-GB');
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(5,'Australian Dollar','AUD',NULL,0,2,'en-AU');
INSERT [dbo].Currency(CurrencyID,Name,CurrencyCode,ExchangeRate,Published,DisplayOrder,DisplayLocaleFormat) values(6,'Japanese Yen','JPY',1,0,2,'ja-JP');
set IDENTITY_INSERT [dbo].Currency OFF;
GO

set IDENTITY_INSERT [dbo].KitGroup ON;
INSERT [dbo].KitGroup(KitGroupID,Name,Description,ProductID,DisplayOrder,KitGroupTypeID,IsRequired) values(1,'Processors','The primary chip of the system that oversees all the other components of the system.',48,1,1,1);
INSERT [dbo].KitGroup(KitGroupID,Name,Description,ProductID,DisplayOrder,KitGroupTypeID,IsRequired) values(2,'Memory','Chips in the computer used for temporary storage of data.',48,2,1,1);
INSERT [dbo].KitGroup(KitGroupID,Name,Description,ProductID,DisplayOrder,KitGroupTypeID,IsRequired) values(3,'Hard drive','The main device a computer uses to permanently store and retrieve information.',48,3,1,1);
INSERT [dbo].KitGroup(KitGroupID,Name,Description,ProductID,DisplayOrder,KitGroupTypeID,IsRequired) values(4,'Graphics Card','A peripheral device that attaches to the PCI or AGP slot in your computer to enable the computer to process and deliver video. Once installed in the computer, a cable is used to attach the graphics card to a computer monitor.',48,4,1,1);
set IDENTITY_INSERT [dbo].KitGroup OFF;
GO

set IDENTITY_INSERT [dbo].KitItem ON;
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(1,1 ,'Intel(R) Pentium(R) Dual-Core processor E5200 (2.5.GHz)','',0.00,1,1);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(2,1 ,'Intel(R) Core(TM) 2 Duo processor E4700 (2.6GHz)','',29.00,0,2);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(3,1 ,'Intel(R) Core(TM) 2 Duo processor E7200 (2.5GHz, 3MB)','',75.00,0,3);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(4,1 ,'Intel(R) Core(TM) 2 Quad processor Q9300','',232.00,0,4);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(5,2 ,'2GB DDR2-800MHz dual channel SDRAM (2x1024)','',0.00,1,1);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(6,2 ,'3GB DDR2-800MHz SDRAM (1x2048,1x1024)','',48.00,0,2);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(7,2 ,'4GB DDR2-800MHz dual channel SDRAM (2x2048)','',93.00,0,3);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(8,3 ,'320GB 7200 rpm SATA 3Gb/s hard drive','',0.00,1,1);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(9,3 ,'640GB 7200 rpm SATA 3Gb/s hard drive','',47.00,0,2);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(10,3 ,'1TB 7200 rpm SATA 3Gb/s hard drive','',920.00,0,3);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(11,4 ,'Integrated Graphics (NVIDIA GeForce 7100), VGA','',0.00,1,1);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(12,4 ,'128MB NVIDIA GeForce 9300, DVI-I, VGA adapter','',30.00,0,2);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(13,4 ,'256MB NVIDIA GeForce 9300, DVI-I, VGA adapter, HDMI','',60.00,0,3);
INSERT [dbo].KitItem(KitItemID,KitGroupID,Name,Description,PriceDelta,IsDefault,DisplayOrder) values(14,4 ,'512MB NVIDIA GeForce 9500GS, DVI-I, HDMI, VGA adapter','',88.00,0,4);
set IDENTITY_INSERT [dbo].KitItem OFF;
GO

--_Product Genre
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (1,1,1);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (1,2,2);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (2,3,3);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,4,4);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,5,5);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,6,6);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,7,7);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,8,8);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (4,9,9);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (4,10,10);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (4,11,11);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (4,12,12);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (4,13,13);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (5,14,14);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,15,15);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,16,16);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (3,17,17);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (6,18,18);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (6,19,19);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (6,20,20);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (7,21,21);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (8,22,22);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (8,23,23);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (14,48,48);
INSERT INTO [dbo].ProductGenre(GenreID,ProductID,DisplayOrder) values (29,201,201);

--1 Video Game
--2 Remote Control Toys
--3 Riding Toys
--4 Refrigerator
--6 Kids Jewelry
--10 Desktops
--32 Music

--_ProductCategory
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(1,1,1);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(2,1,2);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(3,1,3);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(4,2,4);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(5,2,5);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(6,2,6);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(7,2,7);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(8,2,8);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(9,3,9);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(10,3,10);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(11,3,11);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(12,3,12);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(13,3,13);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(14,1,14);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(15,2,15);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(16,2,16);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(17,2,17);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(18,4,18);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(19,4,19);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(20,4,20);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(21,4,21);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(22,6,22);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(23,6,23);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(48,10,48);
INSERT [dbo].ProductCategory(ProductID,CategoryID,DisplayOrder) values(201,32,201);

--1 Electronics
--2 Toys
--3 Major Appliances
--4 Jewelry & Accessories
--6 Computers
--13 Books/cds/movies

--_ProductSection
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(1,1,1);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(2,1,2);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(3,1,3);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(4,2,4);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(5,2,5);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(6,2,6);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(7,2,7);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(8,2,8);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(9,2,9);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(10,2,10);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(11,2,11);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(12,2,12);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(13,2,13);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(14,1,14);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(15,2,15);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(16,2,16);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(17,2,17);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(18,3,18);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(19,3,19);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(20,3,20);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(21,3,21);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(22,4,22);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(23,4,23);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(48,6,48);
INSERT [dbo].ProductSection(ProductID,SectionID,DisplayOrder) values(201,13,201);

--1 Sony
--2 Nintendo
--3 Team Up
--4 Megatech
--5 Kettler
--6 Caterpillar
--7 Step2
--8 Microsoft
--9 Whirlpool
--12 HP

--_Product Manufacturer
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(1,1,1)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(2,1,2)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(3,2,3)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(4,3,4)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(5,4,5)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(6,4,6)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(7,4,7)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(8,4,8)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(9,5,9)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(10,5,10)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(11,6,11)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(12,7,12)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(13,7,13)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(14,8,14)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(15,4,15)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(16,4,16)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(17,4,17)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(18,9,18)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(19,9,19)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(20,9,20)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(21,9,21)
INSERT [dbo].ProductManufacturer(ProductID,ManufacturerID,DisplayOrder) values(48,12,48)

--_Product Distributor 
INSERT [dbo].ProductDistributor(DistributorID,ProductID,DisplayOrder) select 1,ProductID,ProductID from [dbo].Product group by ProductID having ProductID <= 13
INSERT [dbo].ProductDistributor(DistributorID,ProductID,DisplayOrder) select 2,ProductID,ProductID from [dbo].Product group by ProductID having ProductID > 13

--_ProductVariant
set IDENTITY_INSERT [dbo].ProductVariant ON;
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(1,1,1,'PlayStation 3 Console 80GB','The ultimate high-definition entertainment experience has arrived. With the 80GB PlayStation 3 system, you get PlayStation Network membership, built-in Wi-Fi and 80GB of hard disk drive storage for games, music, videos and photos. Also, every PS3 comes with a built-in Blu-ray player to give you pristine picture quality and the best high-definition viewing experience available. Whether its gaming, Blu-ray movies, music or online services, experience it all with the PlayStation 3. Power pack includes a cooling system, a charging station, an HDMI cable and a remote control.','-ps380gb',399.99,13.14,'17x13.5x7',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(2,1,0,'PlayStation 3 Console 40GB','The PS3 features IBMs "Cell" processor and a co-developed Nvidia graphics processor that makes the system able to perform two trillion calculations per second. That makes the PlayStation 3 40 times faster than the PS2. Along with the traditional AV and composite connections, it also boasts an HDMI (High-Definition Multimedia Interface) port, which delivers uncompressed, unconverted digital picture and sound to compatible high-definition TV and projectors. The system is capable of 128-bit pixel precision and 1080p resolution for a full HD experience. This console also provides for a sound experience by supporting Dolby Digital 5.1, DTS 5.1, as well as Linear PCM 7.1. A pre-installed 40 GB hard disc drive allows you to save games as well as download content from the internet. Unlike the other models of the PlayStation 3, the 40GB does not offer backwards compatibility.','-ps340gb',315.00,11,'10.8x12.75x3.86',5);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(3,2,1,'','','',169.00,1.51,'9.8x8.5x2',40);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(4,3,1,'','','',129.99,1.05,'7.8x4.9x1.9',25);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(5,4,1,'Team Up #8 Dale Earnhardt Jr 1:18 Scale Remote Control Car','For Dale Earnhardth Jr Fan!','-dearn',34.99,'3.20','',50);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(6,4,0,'Team Up #01 Mark Martin 1:18 Scale Remote Control Car','For Mark Martin Fan!','-mmart',34.99,'3.20','',50);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(7,4,0,'Team Up #24 Jeff Gordon 1:18 Scale Remote Control Car','For Jeff Gordon Fan!','-jgord',34.99,'3.20','',50);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(8,4,0,'Team Up #20 Tony Stewart 1:18 Scale Remote Control Car  ','For Tony Stewart Fan!','-tstew',34.99,'3.20','',50);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(9,5,1,'','','',69.99,'14','',25);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(10,6,1,'','','',69.99,'14','',25);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(11,7,1,'','','',24.99,'6.54','',45);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(12,8,1,'','','',89.99,'8.92','',15);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(13,9,1,'','','',179.99,'8.92','',20);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(14,10,1,'','','',79.99,'1.52','',25);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(15,11,1,'','','',119.99,'.92','',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(16,12,1,'','','',62.98,'.94','',15);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(17,13,1,'','','',99.99,'.95','',40);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(18,14,1,'','','',299.99,'13.04','12.5x11.5x7.3',25);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(19,15,1,'','','',79.99,'14.26','',20);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(20,16,1,'','','',24.99,'14.21','',15);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(21,17,1,'','','',59.99,'6.5','',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(22,18,1,'','','',1699.99,'.15','35x68x70',5);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(23,19,1,'','','',1499.99,'.15','35x68x49',15);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(24,20,1,'','','',1499.99,'.15','32x68x33',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(25,21,1,'Whirlpool Stainless Steel  Maxwave 10 Level Power Controls Sensor Reheat','1.7 CuFt. 1,200 Watts. Stainless Steel.','-ss1.7c1200w',319.99,39,'22x17x13',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(26,21,0,'Whirlpool White MaxWave 10 Level Power Controls Sensor Reheat','1.7 CuFt. 1,200 Watts. White.','-wht1.7c1200w',199.99,39,'22x17x13',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(27,21,0,'Whirlpool Black 10 Level Power Controls','1.1 CuFt. 1,100 Watts. Black.','-blk1.1c1100w',129.99,38,'20x15x11',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(28,22,1,'','','',69.99,'.15','.57.x.59',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Weight,Dimensions,Inventory) values(29,23,1,'','','',49.99,'.15','.37.x.4',10);
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,Weight) values(57,48,1,'','','',504.99,15,'12.52');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(210,201,1,'In The Ayer','Music for Flo-Rida ft. Will-I-Am and Fergie','-ndayer',5.99,10,1,'OrderDownloads/InTheAyer.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(211,201,0,'Superhuman','Music from Chris Brown ft. Keri Hilson','-suphuman',5.99,10,1,'OrderDownloads/Superhuman.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(212,201,0,'St Anger','Music from Metallica','-anger',5.99,10,1,'OrderDownloads/StAnger.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(213,201,0,'Hands Down','Music from Dashboard Confessional','-hndsdwn',5.99,10,1,'OrderDownloads/HandsDown.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(214,201,0,'Vindicated','Music from Dashboard Confessional','-suphuman',5.99,10,1,'OrderDownloads/Vindicated.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(215,201,0,'Officially Missing You','Music from Tamia','-offmissu',5.99,10,1,'OrderDownloads/Officially.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(216,201,0,'Youth Of the Nation','Music from P.O.D.','-ythofnon',5.99,10,1,'OrderDownloads/Youth.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(217,201,0,'High','Music from LightHouse Family','-highlh',5.99,10,1,'OrderDownloads/High.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(218,201,0,'Between Angels & Devils','Music from Papa Roach','-bangdev',5.99,10,1,'OrderDownloads/BetweenAngelsDevils.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(219,201,0,'Ill be Missing You','Music from Puff Daddy','-pdad',5.99,10,1,'OrderDownloads/MissingU.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(220,201,0,'All Apologies','Music from Nirvana','-allapo',5.99,10,1,'OrderDownloads/AllApologies.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(221,201,0,'Young Modern Station','Music from Silverchair','-yngms',5.99,10,1,'OrderDownloads/ModernStation.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(222,201,0,'Straight Lines','Music from Silverchair','-strlnes',5.99,10,1,'OrderDownloads/StraightLines.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(223,201,0,'Insomia','Music from Silverchair','-ins',5.99,10,1,'OrderDownloads/Insomia.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(224,201,0,'All Across the World','Music from Silverchair','-accwrld',5.99,10,1,'OrderDownloads/AllAcrossDWorld.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(225,201,0,'Low','Music from Silverchair','-lowsc',5.99,10,1,'OrderDownloads/Low.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(226,201,0,'Bleeding Love','Music from Leona Lewis','-bl',5.99,10,1,'OrderDownloads/BleedingLove.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(227,201,0,'Face to Face','Music from Sevendust','-ftof',5.99,10,1,'OrderDownloads/FacetoFace.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(228,201,0,'Licking Cream','Music from Sevendust','-lcrea',5.99,10,1,'OrderDownloads/LickingCream.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(229,201,0,'Ugly','Music from Sevendust','-uglsd',5.99,10,1,'OrderDownloads/Ugly.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(230,201,0,'Everything','Music from Lifehouse','-evthlh',5.99,10,1,'OrderDownloads/Everything.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(231,201,0,'Hanging by a Moment','Music from Lifehouse','-hbamntlf',5.99,10,1,'OrderDownloads/HangingMoment.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(232,201,0,'Unknown','Music from Lifehouse','-unklh',5.99,10,1,'OrderDownloads/Unknown.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(233,201,0,'Break Me Shake Me','Music from Savage Garden','-bsmesg',5.99,10,1,'OrderDownloads/BreakShake.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(234,201,0,'Crash And Burn','Music from Savage Garden','-cbsg',5.99,10,1,'OrderDownloads/CrashBurn.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(235,201,0,'I Knew I loved you','Music from Savage Garden','-iklusg',5.99,10,1,'OrderDownloads/IKnewILovedYou.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(236,201,0,'I Want You','Music from Savage Garden','-mscsg',5.99,10,1,'OrderDownloads/IWantU.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(237,201,0,'The Animal Song','Music from Savage Garden','-asngsg',5.99,10,1,'OrderDownloads/DAnimalSong.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(238,201,0,'Truly Madly Deeply','Music from Savage Garden','-tmaddep',5.99,10,1,'OrderDownloads/TrulyMadlyDeeply.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(239,201,0,'Passenger Seat','Music from Stephen Speaks','-pseat',5.99,10,1,'OrderDownloads/PassengerSeat.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(240,201,0,'Out Of My League','Music from Stephen Speaks','-outleag',5.99,10,1,'OrderDownloads/OutOfMyLeague.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(241,201,0,'Crawling In The Dark','Music from Hoobastank','-crandrk',5.99,10,1,'OrderDownloads/CrawlingNDDark.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(242,201,0,'Out Of Control','Music from Hoobastank','-otofcnt',5.99,10,1,'OrderDownloads/OutOfControl.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(243,201,0,'Pieces','Music from Hoobastank','-pis',5.99,10,1,'OrderDownloads/Pieces.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(244,201,0,'Running Away','Music from Hoobastank','-runwy',5.99,10,1,'OrderDownloads/RunningAway.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(245,201,0,'The Reason Is You','Music from Hoobastank','-resisu',5.99,10,1,'OrderDownloads/ReasonIsYou.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(246,201,0,'With You','Music from Linkin Park','-witu',5.99,10,1,'OrderDownloads/WithYou.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(247,201,0,'Somewhere I Belong','Music from Linkin Park','-somibel',5.99,10,1,'OrderDownloads/SomewherIBelong.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(248,201,0,'In The End','Music from Linkin Park','-ndend',5.99,10,1,'OrderDownloads/InTheEnd.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(249,201,0,'Faint','Music from Linkin Park','-fnt',5.99,10,1,'OrderDownloads/Faint.mp3');
INSERT [dbo].ProductVariant(VariantID,ProductID,IsDefault,Name,Description,SKUSuffix,Price,Inventory,IsDownload,DownloadLocation) values(250,201,0,'One Step Closer','Music from Linkin Park','-onestpcls',5.99,10,1,'OrderDownloads/OneStepCloserf.mp3');
set IDENTITY_INSERT [dbo].ProductVariant OFF;
--Colors
--ColorSKUModifiers
--Sizes
--SizeSKUModifiers

-- set default packages:
update [dbo].category set XmlPackage='entity.grid.xml.config' where XmlPackage IS NULL or XmlPackage='';
go
update [dbo].section set XmlPackage='entity.grid.xml.config' where XmlPackage IS NULL or XmlPackage='';
go
update [dbo].manufacturer set XmlPackage='entity.grid.xml.config' where XmlPackage IS NULL or XmlPackage='';
go
update [dbo].distributor set XmlPackage='entity.grid.xml.config' where XmlPackage IS NULL or XmlPackage='';
go
update [dbo].product set XmlPackage='product.variantsinrightbar.xml.config' where IsAKit=0 and IsAPack=0 and XmlPackage IS NULL or XmlPackage='';
go
update Product set XmlPackage='product.variantsingrid.xml.config' where ProductID=4
go
update Product set XmlPackage='product.variantsingrid.xml.config' where ProductID=21
go
update Product set XmlPackage='product.kitproduct.xml.config' where IsAKit=1 and IsAPack=0 and XmlPackage IS NULL or XmlPackage='';
go

--Related Products
UPDATE [dbo].Product SET RelatedProducts = '1,2,3,14' WHERE ProductID in (select ProductID from [dbo].ProductCategory where CategoryID = 1)
UPDATE [dbo].Product SET RelatedProducts = '4,5,6,7,8,9,10,11,12,13' WHERE ProductID in (select ProductID from [dbo].ProductCategory where CategoryID = 2 or CategoryID = 3)
UPDATE [dbo].Product SET RelatedProducts = '18,19,20,21' WHERE ProductID in (select ProductID from [dbo].ProductGenre where GenreID = 6 or GenreID = 7)

--_Upsell Products
UPDATE [dbo].Product Set UpsellProducts = '1,2,3' Where ProductID in (select ProductID from [dbo].ProductGenre where GenreID = 21)

--_Shipping Zone
SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(1, 'Zones 1 & 2', '894-897,940-941,942,943-955,956-959,960-966,987', 1, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(2, 'Zone 3', '932-933,936-939,975-976', 2, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(3, 'Zone 4', '832-837,840-847,854,860-864,889-893,898-931,934-935,970-974,977-986,988-989,993-994', 3, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(4, 'Zone 5', '590-599,693,798-831,838,850-853,865-880,883,885,990-992', 4, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(5, 'Zone 6', '510-513,515-516,562,565,567-576,580-588,664-666,668-692,730-732,734-739,746,748,763,768-769,790-797,881-882,884,999', 5, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(6, 'Zone 7', '375,380-382,386-387,389,420,463-464,498-509,514,520-561,563-564,566,600-663,667,705-706,710-729,733,740-745,747,749-762,764-767,770-789,998', 6, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO


SET IDENTITY_INSERT [dbo].ShippingZone ON;
INSERT [dbo].ShippingZone(ShippingZoneID, Name, ZipCodes, DisplayOrder, CreatedOn)
VALUES(7, 'Zone 8', '004-374,376-379,383-385,388,390-418,421-462,465-497,700-704,707-709,967-969,995-997', 7, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO

--_Shipping Method
SET IDENTITY_INSERT [dbo].ShippingMethod ON;
INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (1, NEWID(), 'Express Mail - Retail', 0, 1, GETDATE());

INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (2, NEWID(), 'Priority Mail - Retail', 0, 2, GETDATE());

INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (3, NEWID(), 'Parcel Select', 0, 3, GETDATE());

INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (4, NEWID(), 'Parcel Select BMC and OBMC Presort', 0, 4, GETDATE());

SET IDENTITY_INSERT [dbo].ShippingMethod ON;
INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (5, NEWID(), 'Express Mail International', 0, 1, GETDATE())

INSERT [dbo].ShippingMethod(ShippingMethodID, ShippingMethodGUID, Name, IsRTShipping, DisplayOrder, CreatedOn)
VALUES (6, NEWID(), 'Priority Mail International', 0, 2, GETDATE())
SET IDENTITY_INSERT [dbo].ShippingZone OFF;
GO
SET IDENTITY_INSERT [dbo].ShippingMethod OFF;
GO

/* ACTIVE RATE TABLE FOR: CALCULATE SHIPPING BY ORDER WEIGHT BY ZONE: */

/*Weight
Not Over
(pounds) 0.5*/


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 0.01, 0.50, 1, 12.60, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 0.51, 1.00, 1, 14.55, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 1.01, 2.00, 1, 15.70, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 3.01, 4.00, 1, 17.95, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 4.01, 5.50, 1, 18.60, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 5.01, 6.00, 1, 21.85, GETDATE())

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 6.01, 7.00, 1, 25.10, GETDATE())  

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 7.01, 8.00, 1, 26.35, GETDATE())  

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 8.01, 9.00, 1, 27.80, GETDATE())  

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(1, 9.01, 10.00, 1, 28.60, GETDATE())

--JOSEPH ERICKSON VILLAR
DECLARE @ROWGUID uniqueidentifier

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 2, 14.65, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 3, 17.45, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 4, 18.30, GETDATE())	
	END
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 5, 18.60, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 6, 19.25, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 0.50)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 0.50, 7, 19.50, GETDATE())	
	END  


/*Weight
Not Over
(pounds) 1*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 2, 19.00, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 3, 22.40, GETDATE())	
	END 

 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 4, 22.65, GETDATE())	
	END 

 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 5, 22.90, GETDATE())	
	END  

 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 6, 23.15, GETDATE())	
	END  
 
 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.51 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.51, 1.00, 7, 23.40, GETDATE())	
	END  
 

/*Weight
Not Over
(pounds) 2*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID,ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 2, 20.15, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 3, 24.65, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 4, 24.90, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 5, 25.15, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 6, 25.40, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 1.01, 2.00, 7, 25.65, GETDATE())	
	END
	


/*Weight
Not Over
(pounds) 3*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 2, 21.35, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 3, 28.40, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 4, 28.65, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 5, 28.90, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 6, 29.15, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 2.01, 3.00, 7, 29.40, GETDATE())
	END


/*Weight
Not Over
(pounds) 4*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 2, 22.75, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 3, 32.10, GETDATE())
	END


IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 4, 32.35, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 5, 32.60, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 6, 32.85, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 3.01, 4.00, 7, 33.10, GETDATE())
	END


/*Weight
Not Over
(pounds) 5*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 2, 24.35, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 3, 35.85, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 4, 36.10, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 5, 36.35, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 6, 36.60, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 4.01, 5.00, 7, 36.85, GETDATE())
	END

  
/*Weight
Not Over
(pounds) 6*/
 
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
      
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 2, 29.25, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 3, 39.55, GETDATE())
	END
	

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 4, 39.80, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 5, 40.05, GETDATE())
	END


IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 6, 40.30, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 6, 40.30, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 5.01, 6.00, 7, 40.55, GETDATE())
	END
	

/*Weight
Not Over
(pounds) 7*/
   
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
     
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 2, 34.15, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 3, 43.25, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 4, 43.50, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 5, 43.75, GETDATE())
	END


IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 6, 44.00, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 6.01, 7.00, 7, 44.25, GETDATE())
	END


/*Weight
Not Over
(pounds) 8*/
 
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 2, 35.15, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID,ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 3, 47.00, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 4, 47.25, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 5, 47.50, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 5, 47.50, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 6, 47.75, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 7.01, 8.00, 7, 48.00, GETDATE())
	END
       

/*Weight
Not Over
(pounds) 9*/
         
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 2, 36.65, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 3, 50.35, GETDATE())
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 4, 50.95, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 5, 51.20, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 6, 51.45, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 8.01, 9.00, 7, 51.70, GETDATE())
	END



/*Weight
Not Over
(pounds) 10*/
 
         
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN		
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 2, 38.10, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 3, 52.70, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 4, 53.55, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 5, 53.80, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 6, 54.05, GETDATE())
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 9.01, 10.00, 7, 54.30, GETDATE())
	END
	



--_Shipping Weight By Zone 3 & 4
--Parcel Select
--1 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 0.01, 1, 1, 2.52, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 0.01 AND HighValue = 1)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 0.01 AND HighValue = 1)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 0.01, 1, 2, 2.94, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 3, 0.01, 1, 3, 3.29, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 0.01, 1, 4, 4.22, GETDATE());	
END


--2 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 1.01, 2, 1, 2.83, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 1.01 AND HighValue = 2)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 1.01 AND HighValue = 2)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 1.01, 2, 2, 3.60, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 1.01, 2, 3, 4.29, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 1.01, 2, 4, 5.02, GETDATE());		
END

--3 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 2.01, 3, 1, 3.14, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 2.01 AND HighValue = 3)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 2.01 AND HighValue = 3)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 2.01, 3, 2, 4.27, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 2.01, 3, 3, 5.24, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 2.01, 3, 4, 5.85, GETDATE());		
END

--4 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 3.01, 4, 1, 3.43, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 3.01 AND HighValue = 4)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 3.01 AND HighValue = 4)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 3.01, 4, 2, 4.87, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 3.01, 4, 3, 6.01, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 3.01, 4, 4, 6.55, GETDATE());		
END

--5 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 4.01, 5, 1, 3.69, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 4.01 AND HighValue = 5)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 4.01 AND HighValue = 5)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 4.01, 5, 2, 5.45, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 4.01, 5, 3, 6.58, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 4.01, 5, 4, 7.24, GETDATE());		
END

--6 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 5.01, 6, 1, 3.95, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 5.01 AND HighValue = 6)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 5.01 AND HighValue = 6)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 5.01, 6, 2, 5.97, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 5.01, 6, 3, 7.04, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 5.01, 6, 4, 7.84, GETDATE());		
END

--7 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 6.01, 7, 1, 4.19, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 6.01 AND HighValue = 7)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 6.01 AND HighValue = 7)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 6.01, 7, 2, 6.48, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 6.01, 7, 3, 7.49, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 6.01, 7, 4, 8.45, GETDATE());		
END

--8 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 7.01, 8, 1, 4.44, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 7.01 AND HighValue = 8)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 7.01 AND HighValue = 8)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 7.01, 8, 2, 6.97, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 7.01, 8, 3, 7.89, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 7.01, 8, 4, 8.99, GETDATE());		
END

--9 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 8.01, 9, 1, 4.64, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 8.01 AND HighValue = 9)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 8.01 AND HighValue = 9)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 8.01, 9, 2, 7.38, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 8.01, 9, 3, 8.26, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 8.01, 9, 4, 9.43, GETDATE());		
END

--10 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(3, 9.01, 10, 1, 4.85, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 9.01 AND HighValue = 10)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 3 AND LowValue = 9.01 AND HighValue = 10)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 9.01, 10, 2, 7.81, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 9.01, 10, 3, 9.15, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 3, 9.01, 10, 4, 9.88, GETDATE());		
END

--1 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 0.01, 1, 1, 4.55, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 0.01 AND HighValue = 1)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 0.01 AND HighValue = 1)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 0.01, 1, 2, 4.55, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 0.01, 1, 3, 4.55, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 0.01, 1, 4, 4.55, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 0.01, 1, 5, 4.55, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 0.01, 1, 6, 4.55, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 0.01, 1, 7, 4.55, GETDATE());		
END

--2 pounds
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 1.01, 2, 1, 4.55, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 1.01 AND HighValue = 2)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 1.01 AND HighValue = 2)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 1.01, 2, 2, 4.85, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 1.01, 2, 3, 5.35, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 1.01, 2, 4, 5.94, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 1.01, 2, 5, 6.13, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 1.01, 2, 6, 6.35, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 1.01, 2, 7, 6.67, GETDATE());		
END

--3 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 2.01, 3, 1, 5.05, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 2.01 AND HighValue = 3)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 2.01 AND HighValue = 3)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 2.01, 3, 2, 5.70, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 2.01, 3, 3, 6.60, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 2.01, 3, 4, 6.94, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 2.01, 3, 5, 7.22, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 2.01, 3, 6, 7.52, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 2.01, 3, 7, 8.12, GETDATE());		
END

--4 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 3.01, 4, 1, 5.75, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 3.01 AND HighValue = 4)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 3.01 AND HighValue = 4)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 3.01, 4, 2, 6.75, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 3.01, 4, 3, 7.55, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 3.01, 4, 4, 7.88, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 3.01, 4, 5, 8.23, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 3.01, 4, 6, 8.62, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 3.01, 4, 7, 9.38, GETDATE());		
END

--5 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 4.01, 5, 1, 6.40, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 4.01 AND HighValue = 5)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 4.01 AND HighValue = 5)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 4.01, 5, 2, 7.70, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 4.01, 5, 3, 8.37, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 4.01, 5, 4, 8.76, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 4.01, 5, 5, 9.19, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 4.01, 5, 6, 9.67, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 4.01, 5, 7, 10.58, GETDATE());		
END

--6 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 5.01, 6, 1, 7.00, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 5.01 AND HighValue = 6)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 5.01 AND HighValue = 6)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 5.01, 6, 2, 8.60, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 5.01, 6, 3, 9.15, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 5.01, 6, 4, 9.61, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 5.01, 6, 5, 10.11, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 5.01, 6, 6, 10.66, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 5.01, 6, 7, 11.72, GETDATE());		
END

--7 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 6.01, 7, 1, 7.55, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 6.01 AND HighValue = 7)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 6.01 AND HighValue = 7)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 6.01, 7, 2, 9.34, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 6.01, 7, 3, 9.89, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 6.01, 7, 4, 10.42, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 6.01, 7, 5, 10.98, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 6.01, 7, 6, 11.60, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 6.01, 7, 7, 12.81, GETDATE());		
END

--8 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 7.01, 8, 1, 8.00, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 7.01 AND HighValue = 8)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 7.01 AND HighValue = 8)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 7.01, 8, 2, 9.70, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 7.01, 8, 3, 10.61, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 7.01, 8, 4, 11.19, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 7.01, 8, 5, 11.82, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 7.01, 8, 6, 12.51, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 7.01, 8, 7, 13.85, GETDATE());		
END

--9 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 8.01, 9, 1, 8.40, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 8.01 AND HighValue = 9)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 8.01 AND HighValue = 9)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 8.01, 9, 2, 10.06, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 8.01, 9, 3, 11.30, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 8.01, 9, 4, 11.94, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 8.01, 9, 5, 12.63, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 8.01, 9, 6, 13.39, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 8.01, 9, 7, 14.86, GETDATE());		
END

--10 pound
INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(4, 9.01, 10, 1, 8.80, GETDATE())

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 9.01 AND HighValue = 10)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 4 AND LowValue = 9.01 AND HighValue = 10)
BEGIN
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 9.01, 10, 2, 11.20, GETDATE());		
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)	
	VALUES(@ROWGUID, 4, 9.01, 10, 3, 11.96, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 9.01, 10, 4, 12.66, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 9.01, 10, 5, 13.40, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 9.01, 10, 6, 14.23, GETDATE());	
	INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
	VALUES(@ROWGUID, 4, 9.01, 10, 7, 12.83, GETDATE());		
END

/*Weight
Not Over
(pounds) 1*/

INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 0.01, 1.00, 1, 4.80, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 1.01, 2.00, 1, 4.80, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 2.01, 3.00, 1, 5.20, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 3.01, 4.00, 1, 5.80, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 4.01, 5.00, 1, 6.45, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 5.01, 6.00, 1, 7.05, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 6.01, 7.00, 1, 7.60, GETDATE())


INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 7.01, 8.00, 1, 8.05, GETDATE())



INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 8.01, 9.00, 1, 8.45, GETDATE())



INSERT [dbo].ShippingWeightByZone(ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
VALUES(2, 9.01, 10.00, 1, 8.85, GETDATE())  

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 0.01 AND HighValue = 1.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 0.01, 1.00, 2, 4.80, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 1, 0.01, 1.00, 3, 4.80, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 1 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 0.01, 1.00, 4, 4.80, GETDATE())	
	END
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 0.01, 1.00, 5, 4.80, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 0.01, 1.00, 6, 4.80, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 0.01 AND HighValue = 1.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 0.01, 1.00, 7, 4.80, GETDATE())	
	END  

/*Weight
Not Over
(pounds) 2*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 2,  5.05, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 3,  5.60, GETDATE())	
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 4,  6.80, GETDATE())	
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 5,  7.20, GETDATE())	
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 6,  7.70, GETDATE())	
	END	
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 1.01 AND HighValue = 2.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 1.01, 2.00, 7,  8.25, GETDATE())	
	END	
   
/*Weight
Not Over
(pounds) 3*/
 
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 2,  5.95, GETDATE())	
	END

 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 3,  6.75, GETDATE())	
	END
	
 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 4,  8.75, GETDATE())	
	END
	
 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 5,  9.55, GETDATE())	
	END
	
 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 6,  10.35, GETDATE())	
	END
	
 IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 2.01 AND HighValue = 3.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 2.01, 3.00, 7,  11.50, GETDATE())	
	END

/*Weight
Not Over
(pounds) 4*/		
       
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)   

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 2,  6.80, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 3,  7.85, GETDATE())	
	END
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 4,  10.55, GETDATE())	
	END

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 5,  11.60, GETDATE())	
	END
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 6,  12.65, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 3.01 AND HighValue = 4.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 3.01, 4.00, 7,  14.25, GETDATE())	
	END 

/*Weight
Not Over
(pounds) 5*/     

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 2,  6.80, GETDATE())	
	END      

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 3,  8.90, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 4,  12.20, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 5,  13.45, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 6,  14.75, GETDATE())	
	END 
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 4.01 AND HighValue = 5.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 4.01, 5.00, 7,  16.80, GETDATE())	
	END  

/*Weight
Not Over
(pounds) 6*/    

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 2, 8.65, GETDATE())	
	END   
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 3, 10.00, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 4, 13.95, GETDATE())	
	END 
  
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 5, 14.40, GETDATE())	
	END   

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 6, 16.25, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 5.01 AND HighValue = 6.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 5.01, 6.00, 7, 17.65, GETDATE())	
	END  
	
	
/*Weight
Not Over
(pounds) 7*/ 

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
   
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 2, 9.40, GETDATE())	
	END   

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 3, 11.00, GETDATE())	
	END    

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 4, 15.35, GETDATE())	
	END    

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 5, 15.80, GETDATE())	
	END   

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 6, 18.05, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 6.01 AND HighValue = 7.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 6.01, 7.00, 7, 20.15, GETDATE())	
	END  
 
/*Weight
Not Over
(pounds) 8*/ 

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
           
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 2, 9.75, GETDATE())	
	END   
      
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 3, 11.95, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 4, 16.40, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 5, 17.15, GETDATE())	
	END  
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 6, 19.80, GETDATE())	
	END  
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 7.01 AND HighValue = 8.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 7.01, 8.00, 7, 22.60, GETDATE())	
	END 
	
/*Weight
Not Over
(pounds) 9*/

SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
   
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 2, 10.45, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 3, 12.75, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 4, 17.50, GETDATE())	
	END   
 
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 5, 18.55, GETDATE())	
	END 
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 6, 21.55, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 8.01 AND HighValue = 9.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 8.01, 9.00, 7, 25.15, GETDATE())	
	END 	
		
/*Weight
Not Over
(pounds) 10*/ 	
  
SET @ROWGUID = (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
    
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 2, 11.25, GETDATE())	
	END  

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 3, 13.45, GETDATE())	
	END  
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 4, 18.65, GETDATE())	
	END  
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 5, 20.10, GETDATE())	
	END 
	
IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN	
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 6, 23.45, GETDATE())	
	END 

IF EXISTS (SELECT DISTINCT RowGUID FROM ShippingWeightByZone WHERE ShippingMethodID = 2 AND LowValue = 9.01 AND HighValue = 10.00)
	BEGIN
		INSERT [dbo].ShippingWeightByZone(RowGUID, ShippingMethodID, LowValue, HighValue, ShippingZoneID, ShippingCharge, CreatedOn)
		VALUES(@ROWGUID, 2, 9.01, 10.00, 7, 27.55, GETDATE())	
	END 
		
     

/*100 Customers*/
/*BEGIN - LETTER A*/
delete from Customer where CustomerID != 58639
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58640 AND Email = 'steve_alisauskas@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58640, 'Steve', 'Alisauskas', 'steve_alisauskas@gmail.com', 'steve$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58641 AND Email = 'arnold_alishio@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58641, 'Arnold', 'Alishio', 'arnold_alishio@yahoo.com', 'arnold$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58642 AND Email = 'ilene_alishouse@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58642, 'Ilene', 'Alishouse', 'ilene_alishouse@gmail.com', 'ilene$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58643 AND Email = 'marylou_alison@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58643, 'Mary Lou', 'Alison', 'marylou_alison@yahoo.com', 'marylou$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58644 AND Email = 'robert_alispach@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58644, 'Robert', 'Alispach', 'robert_alispach@gmail.com', 'robert$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
/*END - LETTER A*/


/*BEGIN - LETTER B*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58645 AND Email = 'guillermo_brena@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58645, 'Guillermo', 'Brena', 'guillermo_brena@yahoo.com', 'guillermo$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58646 AND Email = 'kevin_brenan@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58646, 'Kevin', 'Brenan', 'kevin_brenan@gmail.com', 'kevin$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58647 AND Email = 'glen_brenchley@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58647, 'Glen', 'Brenchley', 'glen_brenchley@yahoo.com', 'glen$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58648 AND Email = 'stefanie_brendl@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58648, 'Stefanie', 'Brendl', 'stefanie_brendl@gmail.com', 'stefanie$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58649 AND Email = 'evelyn_brenaman@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58649, 'Evelyn', 'Brenaman', 'evelyn_brenaman@yahoo.com', 'evelyn$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
/*END - LETTER B*/


/*BEGIN - LETTER C*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58650 AND Email = 'doug_clore@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.')
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58650, 'Doug', 'Clore', 'doug_clore@gmail.com', 'doug$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58651 AND Email = 'frank_crisafulli@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58651, 'Frank', 'Crisafulli', 'frank_crisafulli@yahoo.com', 'frank$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58652 AND Email = 'lidia_crisan@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58652, 'Lidia', 'Crisan', 'lidia_crisan@gmail.com', 'lidia$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58653 AND Email = 'jerry_casabella@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58653, 'Jerry', 'Casabella', 'jerry_casabella@yahoo.com', 'jerry$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58654 AND Email = 'anthony_casablanca@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58654, 'Anthony', 'Casablanca', 'anthony_casablanca@gmail.com', 'anthony$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
/*END - LETTER C*/


/*BEGIN - LETTER D*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58655 AND Email = 'tony_dori@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58655, 'Toni', 'Doro', 'tony_dori@yahoo.com', 'tony$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	  	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58656 AND Email = 'lee_dorobiala@gmail.com')
	BEGIN  	
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58656, 'Lee', 'Dorobiala', 'lee_dorobiala@gmail.com', 'lee$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO  		  
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58657 AND Email = 'anton_dorokhin@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58657, 'Anton', 'Dorokhin', 'anton_dorokhin@yahoo.com', 'anton$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58658 AND Email = 'scott_dalitzky@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58658, 'Scott', 'Dalitzky', 'scott_dalitzky@gmail.com', 'scott$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58659 AND Email = 'andre_deseck@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58659, 'Andre', 'Deseck', 'andre_deseck@yahoo.com', 'andre$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 		
/*END - LETTER D*/


/*BEGIN - LETTER E*/     	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58660 AND Email = 'kathlene_elledge@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58660, 'Kathlene', 'Elledge', 'kathlene_elledge@gmail.com', 'kathlene$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58661  AND Email = 'james_ellefsen@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58661, 'James', 'Ellefsen', 'james_ellefsen@yahoo.com', 'james$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58662 AND Email = 'cliff_ellefson@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58662, 'Cliff', 'Ellefson', 'cliff_ellefson@gmail.com', 'cliff$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58663 AND Email = 'ken_ellegard@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58663, 'Ken', 'Ellegard', 'ken_ellegard@yahoo.com', 'ken$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58664 AND Email = 'william_ellen@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58664, 'William', 'Ellen', 'william_ellen@gmail.com', 'william$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 		
/*END - LETTER E*/

/*BEGIN - LETTER F*/  
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58665 AND Email = 'sahra_farah@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58665, 'Sahra', 'Farah', 'sahra_farah@yahoo.com', 'sahra$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58666 AND Email = 'kambiz_farahmand@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58666, 'Kambiz', 'Farahmand', 'kambiz_farahmand@gmail.com', 'kambiz$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58667 AND Email = 'leyla_faras@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58667, 'Leyla', 'Faras', 'leyla_faras@yahoo.com', 'leyla$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58668 AND Email = 'aranulfo_feria@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58668, 'Aranulfo', 'Feria', 'aranulfo_feria@gmail.com', 'aranulfo$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58669 AND Email = 'stephen_fenick@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58669, 'Stephen', 'Fenick', 'stephen_fenick@yahoo.com', 'stephen$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER F*/

/*BEGIN - LETTER G*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58670 AND Email = 'lawrence_gaba@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58670, 'Lawrence', 'Gaba', 'lawrence_gaba@gmail.com', 'lawrence$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58671 AND Email = 'stephan_gabalac@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58671, 'Stephan', 'Gabalac', 'stephan_gabalac@yahoo.com', 'stephan$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58672 AND Email = 'eugene_gabalski@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58672, 'Eugene', 'Gabalski', 'eugene_gabalski@gmail.com', 'eugene$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58673 AND Email = 'glenn_gabamonte@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58673, 'Glenn', 'Gabamonte', 'glenn_gabamonte@yahoo.com', 'glenn$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58674 AND Email = 'louis_gabanyic@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58674, 'Louis', 'Gabanyic', 'louis_gabanyic@gmail.com', 'louis$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 	
/*END - LETTER G*/

/*BEGIN - LETTER H*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58675 AND Email = 'stefan_hasiak@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58675, 'Stefan', 'Hasiak', 'stefan_hasiak@yahoo.com', 'stefan$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58676 AND Email = 'emir_hasic@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58676, 'Emir', 'Hasic', 'emir_hasic@gmail.com', 'emir$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58677 AND Email = 'kimberly_halom@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58677, 'Kimberly', 'Halom', 'kimberly_halom@yahoo.com', 'kimberly$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58678 AND Email = 'tom_halowell@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58678, 'Tom', 'Halowell', 'tom_halowell@gmail.com', 'tom$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58679 AND Email = 'david_hissey@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58679, 'David', 'Hissey', 'david_hissey@yahoo.com', 'david$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER H*/


/*BEGIN - LETTER I*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58680 AND Email = 'kathy_illingworth@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58680, 'Kathy', 'Illingworth', 'kathy_illingworth@gmail.com', 'kathy$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58681 AND Email = 'guss_irani@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58681, 'Guss', 'Irani', 'guss_irani@yahoo.com', 'guss$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58682 AND Email = 'abdi_iman@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58682, 'Abdi', 'Iman', 'abdi_iman@gmail.com', 'abdi$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58683 AND Email = 'shahla_imani@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58683, 'Shahla', 'Imani', 'shahla_imani@yahoo.com', 'shahla$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58684 AND Email = 'dana_imanski@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58684, 'Dana', 'Imanski', 'dana_imanski@gmail.com', 'dana$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER I*/


/*BEGIN - LETTER J*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58685 AND Email = 'susie_jacocks@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58685, 'Susie', 'Jacocks', 'susie_jacocks@yahoo.com', 'susie$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58686 AND Email = 'leslie_jacoway@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58686, 'Leslie', 'Jacoway', 'leslie_jacoway@gmail.com', 'leslie$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58687 AND Email = 'barbara_jacquot@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58687, 'Barbara', 'Jacquot', 'barbara_jacquot@yahoo.com', 'barbara$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58688 AND Email = 'charles_jaecksch@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58688, 'Charles', 'Jaecksch', 'charles_jaecksch@gmail.com', 'charles$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58689 AND Email = 'jas_jaffray@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58689, 'Jas', 'Jaffray', 'jas_jaffray@yahoo.com', 'jas$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO  
/*END - LETTER J*/


/*BEGIN - LETTER K*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58690 AND Email = 'christian_kaas@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58690, 'Christian', 'Kaas', 'christian_kaas@gmail.com', 'christian$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58691 AND Email = 'eugene_kabat@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58691, 'Eugene', 'Kabat', 'eugene_kabat@yahoo.com', 'eugene$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58692 AND Email = 'bradford_kartman@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58692, 'Bradford', 'Kartman', 'bradford_kartman@gmail.com', 'bradford$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58693 AND Email = 'jerome_klint@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58693, 'Jerome', 'Klint', 'jerome_klint@yahoo.com', 'jerome$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58694 AND Email = 'bernadette_kray@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58694, 'Bernadette', 'Kray', 'bernadette_kray@gmail.com', 'bernadette$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER K*/


/*BEGIN - LETTER L*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58695 AND Email = 'michael_loso@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58695, 'Michael', 'Loso', 'michael_loso@yahoo.com', 'michael$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58696 AND Email = 'carrie_losten@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58696, 'Carrie', 'Losten', 'carrie_losten@gmail.com', 'carrie$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58697 AND Email = 'alana_lostaunau@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58697, 'Alana', 'Lostaunau', 'alana_lostaunau@yahoo.com', 'alana$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58698 AND Email = 'joyce_lostetter@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58698, 'Joyce', 'Lostetter', 'joyce_lostetter@gmail.com', 'joyce$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER L*/


/*BEGIN - LETTER M*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58699 AND Email = 'elma_macadamia@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58699, 'Elma', 'Macadamia', 'elma_macadamia@yahoo.com', 'elma$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58700 AND Email = 'tyrone_myree@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58700, 'Tyrone', 'Myree', 'tyrone_myree@gmail.com', 'tyrone$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58701 AND Email = 'james_macdougald@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58701, 'James', 'Macdougald', 'james_macdougald@yahoo.com', 'james$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58702 AND Email = 'mary_mccrobie@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58702, 'Mary', 'McCrobie', 'mary_mccrobie@gmail.com', 'mary$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER M*/


/*BEGIN - LETTER N*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58703 AND Email = 'sadaf_nabavian@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58703, 'Sadaf', 'Nabavian', 'sadaf_nabavian@yahoo.com', 'sadaf$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58704 AND Email = 'alan_neufer@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58704, 'Alan', 'Neufer', 'alan_neufer@gmail.com', 'alan$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58705 AND Email = 'razvan_nicolescu@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58705, 'Razvan', 'Nicolescu', 'razvan_nicolescu@yahoo.com', 'razvan$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER N*/

 	
/*BEGIN - LETTER O*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58706 AND Email = 'julieann_odo@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58706, 'Julieann', 'Odo', 'julieann_odo@gmail.com', 'julieann$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58707 AND Email = 'jodi_oatney@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58707, 'Jodi', 'Oatney', 'jodi_oatney@yahoo.com', 'jodi$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58708 AND Email = 'beverly_oatfield@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58708, 'Beverly', 'Oatfield', 'beverly_oatfield@gmail.com', 'beverly$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER O*/


/*BEGIN - LETTER P*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58709 AND Email = 'michelle_palisano@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58709, 'Michelle', 'Palisano', 'michelle_palisano@yahoo.com', 'michelle$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58710 AND Email = 'painting_parkers@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58710, 'Painting', 'Parkers', 'painting_parkers@gmail.com', 'painting$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58711 AND Email = 'marguerite_pechin@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58711, 'Marguerite', 'Pechin', 'marguerite_pechin@yahoo.com', 'marguerite$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER P*/


/*BEGIN - LETTER Q*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58712 AND Email = 'merlyn_querido@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58712, 'Merlyn', 'Querido', 'merlyn_querido@gmail.com', 'merlyn$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58713 AND Email = 'shaijh_quader@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58713, 'Shaijh', 'Quader', 'shaijh_quader@yahoo.com', 'shaijh$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58714 AND Email = 'lucerio_quintano@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58714, 'Lucerio', 'Quintano', 'lucerio_quintano@gmail.com', 'lucerio$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER Q*/

	
/*BEGIN - LETTER R*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58715 AND Email = 'lori_raffone@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58715, 'Lori', 'Raffone', 'lori_raffone@yahoo.com', 'lori$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58716 AND Email = 'tom_radden@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58716, 'Tom', 'Radden', 'tom_radden@gmail.com', 'tom$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58717 AND Email = 'david_regenbogen@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58717, 'David', 'Regenbogen', 'david_regenbogen@yahoo.com', 'davidregenbogen$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER R*/

	
/*BEGIN - LETTER S*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58718 AND Email = 'kanalieh_saberi@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58718, 'Kanalieh', 'Saberi', 'kanalieh_saberi@gmail.com', 'kanalieh$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58719 AND Email = 'clifton_sigworth@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58719, 'Clifton', 'Sigworth ', 'clifton_sigworth@yahoo.com', 'clifton$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58720 AND Email = 'cassandra_sawney@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58720, 'Cassandra', 'Sawney', 'cassandra_sawney@yahoo.com', 'cassandra$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER S*/


/*BEGIN - LETTER T*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58721 AND Email = 'kevin_taberski@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58721, 'Kevin', 'Taberski', 'kevin_taberski@gmail.com', 'kevin$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58722 AND Email = 'darius_tandon@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58722, 'Darius', 'Tandon', 'darius_tandon@yahoo.com', 'darius$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58723 AND Email = 'gina_taymon@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58723, 'Gina', 'Taymon', 'gina_taymon@gmail.com', 'gina$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER T*/


/*BEGIN - LETTER U*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58724 AND Email = 'miguel_ubaldo@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58724, 'Miguel', 'Ubaldo', 'miguel_ubaldo@yahoo.com', 'miguel$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58725 AND Email = 'ram_udani@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58725, 'Ram', 'Udani', 'ram_udani@gmail.com', 'ram$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58726 AND Email = 'danielmckeithen_ulven@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58726, 'Daniel McKeithen', 'Ulven', 'danielmckeithen_ulven@yahoo.com', 'danielmckeithen$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER U*/

		
/*BEGIN - LETTER V*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58727 AND Email = 'antonio_vanson@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58727, 'Antonio', 'Vanson', 'antonio_vanson@gmail.com', 'antonio$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58728 AND Email = 'theresa_vaulet@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58728, 'Theresa', 'Vaulet', 'theresa_vaulet@yahoo.com', 'theresa$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58729 AND Email = 'richard_vetterick@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58729, 'Richard', 'Vetterick', 'richard_vetterick@gmail.com', 'richard$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER V*/


/*BEGIN - LETTER W*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58730 AND Email = 'amanda_waley@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58730, 'Amanda', 'Waley', 'amanda_waley@yahoo.com', 'amanda$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58731 AND Email = 'dale_waser@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58731, 'Dale', 'Waser', 'dale_waser@gmail.com', 'dale$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58732 AND Email = 'sharon_weibe@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58732, 'Sharon', 'Weibe', 'sharon_weibe@yahoo.com', 'sharon$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER W*/


/*BEGIN - LETTER X*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58733 AND Email = 'bounmy_xayasith@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58733, 'Bounmy', 'Xayasith', 'bounmy_xayasith@gmail.com', 'bounmy$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58734 AND Email = 'may_zyong@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58734, 'May', 'Xyong', 'may_xyong@yahoo.com', 'may$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER X*/


/*BEGIN - LETTER Y*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58735 AND Email = 'debbie_yarwood@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58735, 'Debbie', 'Yarwood', 'debbie_yarwood@gmail.com', 'debbie$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58736 AND Email = 'albert_yozzo@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58736, 'Albert', 'Yozzo', 'albert_yozzo@yahoo.com', 'albert$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58737 AND Email = 'doug_yray@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58737, 'Doug', 'Yray', 'doug_yray@gmail.com', 'dougyray$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
/*END - LETTER Y*/


/*BEGIN - LETTER Z*/
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58738 AND Email = 'antoinette_zirker@yahoo.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58738, 'Antoinette', 'Zirker', 'antoinette_zirker@yahoo.com', 'antoinette$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO 
IF EXISTS (SELECT * FROM Customer WITH (NOLOCK) WHERE CustomerID = 58739 AND Email = 'randy_zotti@gmail.com')
	BEGIN
		PRINT ('Customer already exists because email address is already taken.') 	
	END
ELSE
	BEGIN
		SET IDENTITY_INSERT [dbo].Customer ON;
		INSERT [dbo].Customer(CustomerID, FirstName, LastName, Email, Password, SaltKey, IsAdmin, LocaleSetting, IsRegistered, Over13Checked, CreatedOn) 
		VALUES				 (58739, 'Randy', 'Zotti', 'randy_zotti@gmail.com', 'randy$888', -1, 0, 'en-US', 1, 1, GETDATE());                    
		SET IDENTITY_INSERT [dbo].Customer OFF;
	END
GO
/*END - LETTER Z*/

/*120 ADDRESS*/
/* 80% U.S. Addresses  20% International Addresses */



--1
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,     Company, Address1,       Address2,        Suite, City,			 State, Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(2,         newid(),     58640,      '',       'Steve',   'Alisauskas', '',      '140 Stump Dr', 'Belle Vernon,', '',    'Pennsylvania', 'PA',  '15012',   'United States',	1,			   '724-930-9470', 'steve_alisauskas@gmail.com', 0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--2
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,       Address2,        Suite, City,			 State, Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(3,         newid(),     58641,      '',       'Arnold',  'Alishio', '',      '1833 34 St',	  'Allegan,',	   '',    'Michigan',    'MI',  '49010',   'United States',	1,			   '269-673-1590', 'arnold_alishio@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--3
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,   Company, Address1,        Address2,       Suite, City,		State, Zip,	    Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(4,         newid(),     58642,      '',       'Ilene',  'Alishouse', '',      '15901 S 57 St', 'Papillion,',	'',    'Nebraska',  'NE',  '68133', 'United States',	1,			   '402-339-1535', 'ilene_alishouse@gmail.com',  0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--4
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName,   LastName,  Company, Address1,				Address2,      Suite, City,			 State, Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(5,         newid(),     58643,      '',       'Mary Lou',  'Alison', '',       '2432 Paulawood Dr',	'Nashville,',  '',    'Tennessee',   'TN',  '37207',   'United States',	1,			   '615-228-1545', 'marylou_alison@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--5
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(6,         newid(),     58644,      '',       'Robert',  'Alispach', '',     '1405 SW Osprey Cove', 'Port Saint Lucie,',  '',    'Florida',  'FL',   '34986', 'United States',	1,			   '772-878-6758', 'robert_alispach@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--6
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName,	 LastName,  Company, Address1,				 Address2,   Suite, City,		State,		Zip,	 Country,	        ResidenceType, Phone,	       Email,						   Deleted, CreatedOn, Crypt) 
VALUES				(7,         newid(),	 58645,      '',       'Guillermo',  'Brena',   '',      '8517 E Hawthorne St',  'Tucson,',  '',    'Arizona',	'AZ',	'85710', 'United States',		1,			   '520-760-0765', 'guillermo_brena@yahoo.com',    0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--7
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,              Address2,       Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(8,         newid(),     58646,      '',	   'Kevin',   'Brenan',  '',      '1850 Club Center Dr', 'Sacramento,',  '',    'California',  'CA',  '95835', 'United States',	1,			   '916-285-6812', 'kevin_brenan@gmail.com',     0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--8
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,    Company, Address1,				 Address2,       Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(9,         newid(),     58647,      '',       'Glen',	  'Brenchley', '',      '4925 Roosevelt Ave',    'Sacramento,',  '',    'California',  'CA',   '95820', 'United States',	1,			   '916-452-3284', 'glen_brenchley@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--9
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(10,         newid(),    58648,      '',       'Stefanie',  'Brendl', '',     '620 Hampton Ct', 'Franklin,',  '',    'Tennessee',  'TN',   '37064', 'United States',	1,			   '615-794-3565', 'stefanie_brendl@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--10
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,       Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(11,         newid(),    58649,      '',       'Evelyn',  'Brenaman', '',     '5424-30 White Tail Cir', 'Conover,',  '',    'North Carolina',  'NC',   '28613', 'United States',	1,			   '828-256-8293', 'evelyn_brenaman@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--11
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(12,         newid(),    58650,      '',       'Doug',  'Clore', '',     '6317 Torrey Pines Dr', 'North Richland Hills,',  '',    'Texas',  'TX',   '76180', 'United States',	1,			   '817-428-2508', 'doug_clore@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--12
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(13,         newid(),    58651,      '',       'Frank',  'Crisafulli', '',     '55 SW Brook St', 'Newport,',  '',    'Oregon',  'OR',   '97365', 'United States',	1,			   '541-265-8537', 'frank_crisafulli@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--13
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(14,         newid(),    58652,      '',       'Lidia',  'Crisan', '',     '8 Newton Ave', 'Saratoga Springs,',  '',    'New York',  'NY',   '12866', 'United States',	1,			   '518-306-5117', 'lidia_crisan@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--14
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(15,         newid(),    58653,      '',       'Jerry',  'Casabella', '',     '504 Shamrock Dr', 'Jacksonville,',  '',    'North Carolina',  'NC',   ' 28540', 'United States',	1,			   '910-937-2587', 'jerry_casabella@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--15
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(16,         newid(),    58654,      '',       'Anthony',  'Casablanca ', '',     '1415 Maryland Ave', 'Covington,',  '',    'Kentucky',  'KY',   ' 41011', 'United States',	1,			   '859-491-0177', 'anthony_casablanca@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--16
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(17,         newid(),    58655,      '',       'Toni',  'Doro', '',     '1315 Winding Branch Cir Dunwoody', 'Atlanta,',  '',    'Georgia',  'GA',   '30338', 'United States',	1,			   '770-393-2395', 'tony_dori@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--17
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(18,         newid(),    58656,      '',       'Lee',  'Dorobiala', '',     '12016 NW 47 St', 'Coral Springs,',  '',    'Florida',  'FL',   '33076', 'United States',	1,			   '954-575-9993', 'lee_dorobiala@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--18
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(19,         newid(),    58657,      '',       'Anton',  'Dorokhin', '',     '8551 Corona St', 'Thornton,',  '',    'Colorado',  'CO',   '80229', 'United States',	1,			   '303-430-7967', 'anton_dorokhin@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--19
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(20,         newid(),    58658,      '',       'Scott',  'Dalitzky', '',     '1272 Woodhaven Ln', 'Lodi,',  '',    'California',  'CA',   '95242', 'United States',	1,			   '209-224-8591', 'scott_dalitzky@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--20
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(21,         newid(),    58659,      '',       'Andre',  'Deseck', '',     '8132 Cholo Tr', 'Jacksonville,',  '',    'Florida',  'FL',   '32244', 'United States',	1,			   '904-527-1325', 'andre_deseck@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--21
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(22,         newid(),    58660,      '',       'Kathlene',  'Elledge', '',     '1117 10 St NW', 'Washington,',  '',    'District of Columbia',  'DC',   '20001', 'United States',	1,			   '202-842-7491', 'kathlene_elledge@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--22
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(23,         newid(),    58661,      '',       'James',  'Ellefsen', '',     '6362 Corinth Rd', 'Longmont,',  '',    'Colorado',  'CO',   '80503', 'United States',	1,			   '303-684-0081', 'james_ellefsen@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--23
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(24,         newid(),    58662,      '',       'Cliff',  'Ellefson', '',     '406 2 St', 'East Brady,',  '',    'Pennsylvania',  'PA',   '16028', 'United States',	1,			   '724-526-5270', 'cliff_ellefson@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--24
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(25,         newid(),    58663,      '',       'Ken',  'Ellegard', '',     '1211 W Cedar St', 'Stilwell,',  '',    'Oklahoma',  'OK',   '74960', 'United States',	1,			   '918-696-5970', 'ken_ellegard@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--25
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(26,         newid(),    58664,      '',       'William',  'Ellen', '',     '645 W 59 Ter', 'Kansas City,',  '',    'Missouri',  'MO',   '64113', 'United States',	1,			   '816-363-5774', 'william_ellen@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--26
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(27,         newid(),    58665,      '',       'Sahra',  'Farah', '',     '2874 Market Place Dr', 'Little Canada,',  '',    'Minnesota',  'MN',   '55117', 'United States',	1,			   '651-494-3821', 'sahra_farah@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--27
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(28,         newid(),    58666,      '',       'Kambiz',  'Farahmand', '',     '1415 Tulane Ave', 'New Orleans,',  '',    'Louisiana',  'LA',   '70112', 'United States',	1,			   '504-988-5363', 'kambiz_farahmand@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--28
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(29,         newid(),    58667,      '',       'Leyla',  'Faras', '',     '7932 Belfast St', 'New Orleans,',  '',    'Louisiana',  'LA',   '70125', 'United States',	1,			   '504-866-8958', 'leyla_faras@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--29
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(30,         newid(),    58668,      '',       'Aranulfo',  'Feria', '',     '3394 Pepperhill Rd', 'Lexington,',  '',    'Kentucky',  'KY',   '40502', 'United States',	1,			   '859-269-9696', 'aranulfo_feria@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--30
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(31,         newid(),    58669,      '',       'Stephen',  'Fenick', '',     '200 S Windsor Dr', 'Arlington Heights,',  '',    'Illinois',  'IL',   '60004', 'United States',	1,			   '847-394-9029', 'stephen_fenick@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--31
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(32,         newid(),    58670,      '',       'Lawrence',  'Gaba', '',     '1090 Woodduck St', 'Fruitland,',  '',    'Idaho',  'ID',   '83619', 'United States',	1,			   '208-452-3616', 'lawrence_gaba@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--32
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(33,         newid(),    58671,      '',       'Stephan',  'Gabalac', '',     '3100 Sweetwater Rd', 'Lawrenceville,',  '',    'Georgia',  'GA',   '30044', 'United States',	1,			   '678-245-3341', 'stephan_gabalac@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--33
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(34,         newid(),    58672,      '',       'Eugene',  'Gabalski', '',     '1850 Folsom St', 'Boulder,',  '',    'Colorado',  'CO',   '80302', 'United States',	1,			   '303-443-8866', 'eugene_gabalski@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--34
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(35,         newid(),    58673,      '',       'Glenn',  'Gabamonte', '',     '3716 Celine Ct', 'Bakersfield,',  '',    'California',  'CA',   '93309', 'United States',	1,			   '661-832-4108', 'glenn_gabamonte@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--35
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(36,         newid(),    58674,      '',       'Louis',  'Gabanyic', '',     '7856 Kristen Cir', 'Mabelvale,',  '',    'Arkansas',  'AR',   '72103', 'United States',	1,			   '501-602-2189', 'louis_gabanyic@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--36
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(37,         newid(),    58675,      '',       'Stefan',  'Hasiak', '',     '2221 W Crenshaw St', 'Kuna,',  '',    'Idaho',  'ID',   '83634', 'United States',	1,			   '208-922-9838', 'stefan_hasiak@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--37
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(38,         newid(),    58676,      '',       'Emir',  'Hasic', '',     '7436 Gary Ave', 'Miami Beach,',  '',    'Florida',  'FL',   '33141', 'United States',	1,			   '305-865-9201', 'emir_hasic@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--38
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(39,         newid(),    58677,      '',       'Kimberly',  'Halom', '',     '2422 Poe Ave', 'Clovis,',  '',    'California',  'CA',   '93611', 'United States',	1,			   '559-322-5662', 'kimberly_halom@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--39
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(40,         newid(),    58678,      '',       'Tom',  'Halowell', '',     '3145 Yellow Lantana Ln', 'Kissimmee,',  '',    'Florida',  'FL',   ' 34747', 'United States',	1,			   '407-396-0366', 'tom_halowell@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--40
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(41,         newid(),    58679,      '',       'David',  'Hissey', '',     '41780 Butterfield Stage Rd', 'Temecula,',  '',    'California',  'CA',   '92592', 'United States',	1,			   '951-695-4982', 'david_hissey@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--41
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(42,         newid(),    58680,      '',       'Kathy',  'Illingworth', '',     '165 Collins St', 'Spring City,',  '',    'Tennessee',  'TN',   '37381', 'United States',	1,			   '423-365-2196', 'kathy_illingworth@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--42
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(43,         newid(),    58681,      '',       'Guss',  'Irani', '',     '1703 Hudgins Dr', 'Greensboro,',  '',    'North Carolina',  'NC',   '27406', 'United States',	1,			   '336-285-6193', 'guss_irani@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--43
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(44,         newid(),    58682,      '',       'Abdi',  'Iman', '',     '1630 S 6 St', 'Minneapolis,',  '',    'Minnesota',  'MN',   '55454', 'United States',	1,			   '612-339-3352', 'abdi_iman@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--44
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(45,         newid(),    58683,      '',       'Shahla',  'Imani', '',     '320 S Railroad St', 'Delcambre,',  '',    'Louisiana',  'LA',   '70528', 'United States',	1,			   '337-685-7777', 'shahla_imani@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--45
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(46,         newid(),    58684,      '',       'Dana',  'Imanski', '',     '2331 W Sonoma Ct', 'Meridian,',  '',    'Idaho',  'ID',   '83642', 'United States',	1,			   '208-884-4694', 'dana_imanski@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--46
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(47,         newid(),    58685,      '',       'Susie',  'Jacocks', '',     '267 Dublin Dr SE', 'Calhoun,',  '',    'Georgia',  'GA',   '30701', 'United States',	1,			   '706-602-9189', 'susie_jacocks@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--47
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(48,         newid(),    58686,      '',       'Leslie',  'Jacoway', '',     '5661 Turkey Rd', 'Pensacola,',  '',    'Florida',  'FL',   '32526', 'United States',	1,			   '850-458-2188', 'leslie_jacoway@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--48
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(49,         newid(),    58687,      '',       'Barbara',  'Jacquot', '',     '2508 Rimrock Dr', 'Colorado Springs,',  '',    'Colorado',  'CO',   '80915', 'United States',	1,			   '719-596-9231', 'barbara_jacquot@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--49
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(50,         newid(),    58688,      '',       'Charles',  'Jaecksch', '',     '3558 Dinny St', 'Santa Clara,',  '',    'California',  'CA',   '95054', 'United States',	1,			   '', '',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--50
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(51,         newid(),    58689,      '',       'Jas',  'Jaffray', '',     '3558 Dinny St', 'Santa Clara,',  '',    'California',  'CA',   '95054', 'United States',	1,			   '408-988-0434', 'jas_jaffray@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--51
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(52,         newid(),    58690,      '',       'Christian',  'Kaas', '',     '10910 E Bellflower Dr', 'Sun Lakes,',  '',    'Arizona',  'AZ',   ' 85248', 'United States',	1,			   '480-895-3026', 'christian_kaas@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--52
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(53,         newid(),    58691,      '',       'Eugene',  'Kabat', '',     '12407 N La Paloma Ct', 'Sun City,',  '',    'Arizona',  'AZ',   '85351', 'United States',	1,			   '623-972-4242', 'eugene_kabat@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--53
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(54,         newid(),    58692,      '',       'Bradford',  'Kartman', '',     '10205 N 105 Dr', 'Sun City,',  '',    'Arizona',  'AZ',   '85351', 'United States',	1,			   '623-974-8383', 'bradford_kartman@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--54
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(55,         newid(),    58693,      '',       'Jerome',  'Klint', '',     '164 W Eric St', 'Tucson,',  '',    'Arizona',  'AZ',   '85706', 'United States',	1,			   '520-807-0490', 'jerome_klint@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--55
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(56,         newid(),    58694,      '',       'Bernadette',  'Kray', '',     '2248 E Mead Pl', 'Chandler,',  '',    'Arizona',  'AZ',   '85249', 'United States',	1,			   '480-883-7795', 'bernadette_kray@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--56
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(57,         newid(),    58695,      '',       'Michael',  'Loso', '',     '728 E Main St', 'Batesville,',  '',    'Arkansas',  'AR',   '72501', 'United States',	1,			   '870-793-0086', 'michael_loso@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--57
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(58,         newid(),    58696,      '',       'Carrie',  'Losten', '',     '3670 Irby Dr', 'Conway,',  '',    'Arkansas',  'AR',   '72034', 'United States',	1,			   '501-505-8303', 'carrie_losten@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--58
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(59,         newid(),    58697,      '',       'Alana',  'Lostaunau', '',     '2802 Goldhill Rd', 'Fairbanks,',  '',    'Alaska',  'AK',   '99709', 'United States',	1,			   '907-479-3567', 'alana_lostaunau@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--59
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(60,         newid(),    58698,      '',       'Joyce',  'Lostetter', '',     'Jumbo Subd Bx Mxy', 'McCarthy,',  '',    'Alaska',  'AK',   '99695', 'United States',	1,			   '907-334-0970', 'joyce_lostetter@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--60
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(61,         newid(),    58699,      '',       'Elma',  'Macadamia', '',     '8610 Crest Ct', 'Baton Rouge,',  '',    'Louisiana',  'LA',   '70809', 'United States',	1,			   '225-761-0035', 'elma_macadamia@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--61
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(62,         newid(),    58700,      '',       'Tyrone',  'Myree', '',     '8411 Pflumm Rd', 'Lenexa,',  '',    'Kansas',  'KS',   '66215', 'United States',	1,			   '913-825-0601', 'tyrone_myree@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--62
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(63,         newid(),    58701,      '',       'James',  'Macdougald', '',     '2331 Taliesin Dr', ',',  '',    'Illinois',  'IL',   '60506', 'United States',	1,			   '630-844-0890', 'james_macdougald@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--63
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(64,         newid(),    58702,      '',       'Mary',  'McCrobie', '',     '2371 Hoohu Rd', 'Koloa,',  '',    'Hawaii',  'HI',   '96756', 'United States',	1,			   '808-742-7341', 'mary_mccrobie@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--64
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(65,         newid(),    58703,      '',       'Sadaf',  'Nabavian', '',     '1004 Chippewa Tr', 'Holly Hill,',  '',    'Florida',  'FL',   '32117', 'United States',	1,			   '386-254-2882', 'sadaf_nabavian@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--65
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(66,         newid(),    58704,      '',       'Alan',  'Neufer', '',     '3385 Independence Ct', 'Wheat Ridge,',  '',    'Colorado',  'CO',   '80033', 'United States',	1,			   '303-238-2976', 'alan_neufer@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--66
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(67,         newid(),    58705,      '',       'Razvan',  'Nicolescu', '',     '325 Sylvan Ave', 'Mountain View,',  '',    'California',  'CA',   '94041', 'United States',	1,			   '650-938-3895', 'razvan_nicolescu@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--67
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(68,         newid(),    58706,      '',       'Julieann',  'Odo', '',     '19 Finger Cir', 'Bella Vista,',  '',    'Arkansas',  'AR',   '72715', 'United States',	1,			   '479-855-3463', 'julieann_odo@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--68
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(69,         newid(),    58707,      '',       'Jodi',  'Oatney', '',     '1427 W Beacon Ave', 'Anaheim,',  '',    'California',  'CA',   '92802', 'United States',	1,			   '714-772-9996', 'jodi_oatney@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--69
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(70,         newid(),    58708,      '',       'Beverly',  'Oatfield', '',     '64 Hewitt Ave', 'Staten Island,',  '',    'New York',  'NY',   '10301', 'United States',	1,			   '718-982-8944', 'beverly_oatfield@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--70
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(71,         newid(),    58709,      '',       'Michelle',  'Palisano', '',     '950 Ridgefield Dr', 'Carson City,',  '',    'Nevada',  'NV',   '89706', 'United States',	1,			   '775-888-6812', 'michelle_palisano@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--71
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(72,         newid(),    58710,      '',       'Painting',  'Parkers', '',     '57 Tudor Dr', 'Trenton,',  '',    'New Jersey',  'NJ',   '08690', 'United States',	1,			   '609-631-8666', 'painting_parkers@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--72
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(73,         newid(),    58711,      '',       'Marguerite',  'Pechin', '',     '118 N Norris Ave', 'Pender,',  '',    'Nebraska',  'NE',   '68047', 'United States',	1,			   '402-385-2156', 'marguerite_pechin@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--73
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(74,         newid(),    58712,      '',       'Merlyn',  'Querido', '',     '1207 E 93 1/2 St', 'Bloomington,',  '',    'Minnesota',  'MN',   '55425', 'United States',	1,			   '952-888-4216', 'merlyn_querido@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--74
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(75,         newid(),    58713,      '',       'Shaijh',  'Quader', '',     '3559 18 St', 'Wyandotte,',  '',    'Michigan',  'MI',   '48192', 'United States',	1,			   '734-282-9028', 'shaijh_quader@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--75
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(76,         newid(),    58714,      '',       'Lucerio',  'Quintano', '',     'Beech Hill Rd', 'Blue Hill,',  '',    'Maine',  'ME',   '04614', 'United States',	1,			   '207-374-5172', 'lucerio_quintano@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--76
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(77,         newid(),    58715,      '',       'Lori',  'Raffone', '',     '222 Michele Cir', 'Millersville,',  '',    'Maryland',  'MD',   '21108', 'United States',	1,			   '410-729-2577', 'lori_raffone@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--77
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(78,         newid(),    58716,      '',       'Tom',  'Radden', '',     '1200 Bourbon St', 'Thibodaux,',  '',    'Louisiana',  'LA',   '70301', 'United States',	1,			   '985-446-2476', 'tom_radden@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--78
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(79,         newid(),    58717,      '',       'David',  'Regenbogen', '',     '3329 Alford Ave', '',  '',    'Kentucky',  'KY',   '40212', 'United States',	1,			   '502-614-8026', 'david_regenbogen@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--79
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(80,         newid(),    58718,      '',       'Kanalieh',  'Saberi', '',     '7647 Winding Way', 'Fishers,',  '',    'Indiana',  'IN',   '46038', 'United States',	1,			   '317-570-9069', 'kanalieh_saberi@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--80
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(81,         newid(),    58719,      '',       'Clifton',  'Sigworth ', '',     '527 Reliance Dr', 'Evansville,',  '',    'Indiana',  'IN',   '47711', 'United States',	1,			   '812-867-7004', 'clifton_sigworth@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--81
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(82,         newid(),    58720,      '',       'Cassandra',  'Sawney', '',     '1287 Lopaka Pl', 'Kailua,',  '',    'Hawaii',  'HI',   '96734', 'United States',	1,			   '808-261-5030', 'cassandra_sawney@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--82
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(83,         newid(),    58721,      '',       'Kevin',  'Taberski', '',     '121 Park Plaza Dr', 'Daly City,',  '',    'California',  'CA',   '94015', 'United States',	1,			   '650-994-4751', 'kevin_taberski@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--83
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(84,         newid(),    58722,      '',       'Darius',  'Tandon', '',     '1167 W Lisa Ln', 'Tempe,',  '',    'Arizona',  'AZ',   '85284', 'United States',	1,			   '480-592-9908', 'darius_tandon@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--84
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(85,         newid(),    58723,      '',       'Gina',  'Taymon', '',     '964 Morris Ave', 'Green Bay,',  '',    'Wisconsin',  'WI',   ' 54304', 'United States',	1,			   '920-494-4658', 'gina_taymon@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--85
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(86,         newid(),    58724,      '',       'Miguel',  'Ubaldo', '',     '220 E Ohio Ave', 'Milwaukee,',  '',    'Wisconsin',  'WI',   '53207', 'United States',	1,			   '414-483-5508', 'miguel_ubaldo@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--86
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(87,         newid(),    58725,      '',       'Ram',  'Udani', '',     'N63 W37913 Vista Dr', 'Oconomowoc,',  '',    'Wisconsin',  'WI',   '53066', 'United States',	1,			   '262-567-3805', 'ram_udani@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--87
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(88,         newid(),    58726,      '',       'Daniel McKeithen',  'Ulven', '',     '7825 W Bender Ave', 'Milwaukee,',  '',    'Wisconsin',  'WI',   '53218', 'United States',	1,			   '414-760-0631', 'danielmckeithen_ulven@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--88
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(89,         newid(),    58727,      '',       'Antonio',  'Vanson', '',     '41143 Calla Lily St', 'Fort Mill,',  '',    'South Carolina',  'SC',   '29715', 'United States',	1,			   '803-802-2192', 'antonio_vanson@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--89
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(90,         newid(),    58728,      '',       'Theresa',  'Vaulet', '',     '3 Jenkins St', 'Bristol,',  '',    'Rhode Island',  'RI',   '02809', 'United States',	1,			   '401-254-1487', 'theresa_vaulet@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--90
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(91,         newid(),    58729,      '',       'Richard',  'Vetterick', '',     '51 Woodcross Dr', 'Columbia,',  '',    'South Carolina',  'SC',   '29212', 'United States',	1,			   '803-781-7987', 'richard_vetterick@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--91
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(92,         newid(),    58730,      '',       'Amanda',  'Waley', '',     '409 E Calhoun Crossing Ct', 'Spartanburg,',  '',    'South Carolina',  'SC',   '29307', 'United States',	1,			   '864-529-0058', 'amanda_waley@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--92
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(93,         newid(),    58731,      '',       'Dale',  'Waser', '',     '3397 Calle Calvi', 'Rincon,',  '',    'Puerto Rico',  'PR',   '00677', 'United States',	1,			   '787-823-1871', 'dale_waser@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--93
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(94,         newid(),    58732,      '',       'Sharon',  'Weibe', '',     '3791 NW Boxwood Pl', 'Corvallis,',  '',    'Oregon',  'OR',   '97330', 'United States',	1,			   '541-754-0281', 'sharon_weibe@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--94
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(95,         newid(),    58733,      '',       'Bounmy',  'Xayasith', '',     '23555 N Henney Rd', 'Arcadia,',  '',    'Oklahoma',  'OK',   '73007', 'United States',	1,			   '405-396-2214', 'bounmy_xayasith@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--95
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(96,         newid(),    58734,      '',       'May',  'Xyong', '',     '8327 S 43 West Ave', 'Tulsa,',  '',    'Oklahoma',  'OK',   '74132', 'United States',	1,			   '918-445-0414', 'may_xyong@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--96
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(97,         newid(),    58735,      '',       'Debbie',  'Yarwood', '',     '901 W Martin Luther King St', 'Muskogee,',  '',    'Oklahoma',  'OK',   '74401', 'United States',	1,			   '918-684-9916', 'debbie_yarwood@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--97
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(98,         newid(),    58736,      '',       'Albert',  'Yozzo', '',     '821 Squire Rd', 'Harrisburg,',  '',    'Pennsylvania',  'PA',   '17111', 'United States',	1,			   '717-695-6332', 'albert_yozzo@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--98
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(99,         newid(),    58737,      '',       'Doug',  'Yray', '',     '6 Earl St', 'Glouster,',  '',    'Ohio',  'OH',   '45732', 'United States',	1,			   '740-767-3051', 'doug_yray@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--99
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(100,         newid(),    58738,      '',       'Antoinette',  'Zirker', '',     '1446 Cloud Dance Ct', 'North Las Vegas,',  '',    'Nevada',  'NV',   '89031', 'United States',	1,			   '702-655-2437', 'antoinette_zirker@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--100
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(101,         newid(),    58739,      '',       'Randy',  'Zotti', '',     '2001 Hopewell St', 'Santa Fe,',  '',    'New Mexico',  'NM',   '87505', 'United States',	1,			   '505-983-1405', 'randy_zotti@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


/*NON-US ADDRESSES*/

--101
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(102,         newid(),    58640,      '',       'Arnold',  'Alishio', '',     '26 Antheon Street', 'Paleo Psychico,',  '',    'Athens',  '--',   '15452', 'Greece',	1,			   '210-672-8318', 'arnold_alishio@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--102
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(103,         newid(),    58645,      '',       'Guillermo',  'Brena', '',     'Jl. Imam Bonjol No. 29', '',  '',    'Jakarta',  '--',   '10310', 'Indonesia',	1,			   '3193-2372', 'guillermo_brena@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--103
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(104,         newid(),    58650,      '',       'Doug',  'Clore', '',     'No. 1 Changkat Kia Peng', '',  '',    'Kuala Lumpur',  '--',   '50450', 'Malaysia',	1,			   '2148-3342', 'doug_clore@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--104
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(105,         newid(),    58655,      '',       'Toni',  'Doro', '',     '1 Moonah Place Yarralumla ACT 2600', 'P.O. Box 3297,',  '',    'Manuka',  '--',   '2603', 'Australia',	1,			   '6273-3525', 'tony_dori@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--105
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(106,         newid(),    58660,      '',       'Kathlene',  'Elledge', '',     'No. 23 Xiu Shui Bei-jie', 'Jiangoumenwai,',  '',    'Beijing',  '--',   '100600', 'China',	1,			   '6532-1825', 'kathlene_elledge@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--106
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(107,         newid(),    58665,      '',       'Sahra',  'Farah', '',     '13th Floor, Textile Center Building,', '2 Kaufman Street,',  '',    'Tel-Aviv ',  '--',   '68012', 'Israel',	1,			   '5175-263', 'sahra_farah@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--107
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(108,         newid(),    58670,      '',       'Lawrence',  'Gaba', '',     '50-N Nyaya Marg', 'Chanakyapuri,',  '',    'New Delhi ',  '--',   '110021', 'India',	1,			   '2410-1120', 'lawrence_gaba@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO
 
--108
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(109,         newid(),    58675,      '',       'Stefan',  'Hasiak', '',     'Site D3 Collector Road C, Diplomatic Quarter', 'PO Box 94366,',  '',    'Riyadh',  '--',   '11693', 'Saudi Arabia',	1,			   '4825-935', 'stefan_hasiak@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--109
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(110,         newid(),    58680,      '',       'Kathy',  'Illingworth', '',     '173 Park Road', 'Johnsonville,',  '',    'Wellington',  '--',   '6004', 'New Zealand',	1,			   '4725-170', 'kathy_illingworth@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--110
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(111,         newid(),    58685,      '',       'Susie',  'Jacocks', '',     'Villa # 7 A1 Eithar Street', 'Saha 2, West Bay Area,',  '',    'Doha',  '--',   '24900', 'Qatar',	1,			   '4831-855', 'susie_jacocks@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--111
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(112,         newid(),    58690,      '',       'Christian',  'Kaas', '',     'Villa No. 2 Street 5, E-18/02, Plot No. 97 behind Al Falah Plaza,', 'Madinat Zayed ,',  '',    'Abu Dhabi',  '--',   '3215', 'United Arab Emirates',	1,			   '641-9259', 'christian_kaas@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--112
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(113,         newid(),    58695,      '',       'Michael',  'Loso', '',     '54 Nicholson Street', 'P.O. Box 2562, Brooklyn Square 0075 Muckleneuk,',  '',    'Pretoria',  '--',   '0181', 'South Africa',	1,			   '3460-145', 'michael_loso@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--113
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(114,         newid(),    58699,      '',       'Elma',  'Macadamia', '',     'No. 56 Mahatma Gandhi Caddesi', 'Gaziosmanpasa,',  '',    'Ankara',  '--',   '06700', 'Turkey',	1,			   '446-315858', 'elma_macadamia@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--114
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(115,         newid(),    58703,      '',       'Sadaf',  'Nabavian', '',     'Calle Aduana, 29', '',  '',    'Madrid',  '--',   '28070', 'Spain',	1,			   '411-0666', 'sadaf_nabavian@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--115
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(116,         newid(),    58706,      '',       'Julieann',  'Odo', '',     '4, Hameau de Boulainvilliers', '',  '',    'Paris',  '--',  '75016', 'France',	1,			   '44-14-07-05', 'julieann_odo@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--116
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(117,         newid(),    58709,      '',       'Michelle',  'Palisano', '',     'Tinkune', '',  '',    'Kathmandu',  '--',   '2640', 'Nepal',	1,			   '478-103', 'michelle_palisano@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

--117
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(118,         newid(),    58712,      '',       'Merlyn',  'Querido', '',     'Mariscal Ram?n Castilla 3075', '',  '',    'Buenos Aires',  '--',   '1425', 'Argentina',	1,			   '4807-3433', 'merlyn_querido@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--118
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(119,         newid(),    58715,      '',       'Lori',  'Raffone', '',     'Glanhofen 6', '',  '',    'Salzburg',  '--',   '5017', 'Austria',	1,			   '823-8084', 'lori_raffone@yahoo.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--119
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(120,         newid(),    58718,      '',       'Kanalieh',  'Saberi', '',     'No. 33 Road 294 Khan Chamcarmon', '',  '',    'Phnom Penh',  '--',   '2018', 'Cambodia',	1,			   '215-154', 'kanalieh_saberi@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO


--120
SET IDENTITY_INSERT [dbo].Address ON;
INSERT [dbo].Address(AddressID, AddressGUID, CustomerID, NickName, FirstName, LastName,  Company, Address1,				 Address2,             Suite, City,		  State,  Zip,	   Country,			ResidenceType, Phone,		   Email,						 Deleted, CreatedOn, Crypt) 
VALUES				(121,         newid(),    58721,      '',       'Kevin',  'Taberski', '',     'Kirchenfeldstrasse 73', '',  '',    'Bern',  '--',   '3005', 'Switzerland',	1,			   '350-7171', 'kevin_taberski@gmail.com',   0,       getdate(), 1);
SET IDENTITY_INSERT [dbo].Address OFF;
GO

/*MAP CUSTOMER A BILLING AND SHIPPING ADDRESSES*/
UPDATE Customer SET BillingAddressID = 2, ShippingAddressID = 102 WHERE CustomerID = 58640
UPDATE Customer SET BillingAddressID = 3, ShippingAddressID = 3 WHERE CustomerID = 58641
UPDATE Customer SET BillingAddressID = 4, ShippingAddressID = 4 WHERE CustomerID = 58642
UPDATE Customer SET BillingAddressID = 5, ShippingAddressID = 5 WHERE CustomerID = 58643
UPDATE Customer SET BillingAddressID = 6, ShippingAddressID = 6 WHERE CustomerID = 58644
UPDATE Customer SET BillingAddressID = 7, ShippingAddressID = 103 WHERE CustomerID = 58645
UPDATE Customer SET BillingAddressID = 8, ShippingAddressID = 8 WHERE CustomerID = 58646
UPDATE Customer SET BillingAddressID = 9, ShippingAddressID = 9 WHERE CustomerID = 58647
UPDATE Customer SET BillingAddressID = 10, ShippingAddressID = 10 WHERE CustomerID = 58648

UPDATE Customer SET BillingAddressID = 11, ShippingAddressID = 11 WHERE CustomerID = 58649
UPDATE Customer SET BillingAddressID = 12, ShippingAddressID = 104 WHERE CustomerID = 58650
UPDATE Customer SET BillingAddressID = 13, ShippingAddressID = 13 WHERE CustomerID = 58651
UPDATE Customer SET BillingAddressID = 14, ShippingAddressID = 14 WHERE CustomerID = 58652
UPDATE Customer SET BillingAddressID = 15, ShippingAddressID = 15 WHERE CustomerID = 58653

UPDATE Customer SET BillingAddressID = 16, ShippingAddressID = 16 WHERE CustomerID = 58654
UPDATE Customer SET BillingAddressID = 17, ShippingAddressID = 105 WHERE CustomerID = 58655
UPDATE Customer SET BillingAddressID = 18, ShippingAddressID = 18 WHERE CustomerID = 58656
UPDATE Customer SET BillingAddressID = 19, ShippingAddressID = 19 WHERE CustomerID = 58657
UPDATE Customer SET BillingAddressID = 20, ShippingAddressID = 20 WHERE CustomerID = 58658

UPDATE Customer SET BillingAddressID = 21, ShippingAddressID = 21 WHERE CustomerID = 58659
UPDATE Customer SET BillingAddressID = 22, ShippingAddressID = 106 WHERE CustomerID = 58660
UPDATE Customer SET BillingAddressID = 23, ShippingAddressID = 23 WHERE CustomerID = 58661
UPDATE Customer SET BillingAddressID = 24, ShippingAddressID = 24 WHERE CustomerID = 58662
UPDATE Customer SET BillingAddressID = 25, ShippingAddressID = 25 WHERE CustomerID = 58663

UPDATE Customer SET BillingAddressID = 26, ShippingAddressID = 26 WHERE CustomerID = 58664
UPDATE Customer SET BillingAddressID = 27, ShippingAddressID = 107 WHERE CustomerID = 58665
UPDATE Customer SET BillingAddressID = 28, ShippingAddressID = 28 WHERE CustomerID = 58666
UPDATE Customer SET BillingAddressID = 29, ShippingAddressID = 29 WHERE CustomerID = 58667
UPDATE Customer SET BillingAddressID = 30, ShippingAddressID = 30 WHERE CustomerID = 58668

UPDATE Customer SET BillingAddressID = 31, ShippingAddressID = 31 WHERE CustomerID = 58669
UPDATE Customer SET BillingAddressID = 32, ShippingAddressID = 108 WHERE CustomerID = 58670
UPDATE Customer SET BillingAddressID = 33, ShippingAddressID = 33 WHERE CustomerID = 58671
UPDATE Customer SET BillingAddressID = 34, ShippingAddressID = 34 WHERE CustomerID = 58672
UPDATE Customer SET BillingAddressID = 35, ShippingAddressID = 35 WHERE CustomerID = 58673

UPDATE Customer SET BillingAddressID = 36, ShippingAddressID = 36 WHERE CustomerID = 58674
UPDATE Customer SET BillingAddressID = 37, ShippingAddressID = 109 WHERE CustomerID = 58675
UPDATE Customer SET BillingAddressID = 38, ShippingAddressID = 38 WHERE CustomerID = 58676
UPDATE Customer SET BillingAddressID = 39, ShippingAddressID = 39 WHERE CustomerID = 58677
UPDATE Customer SET BillingAddressID = 40, ShippingAddressID = 40 WHERE CustomerID = 58678

UPDATE Customer SET BillingAddressID = 41, ShippingAddressID = 41 WHERE CustomerID = 58679
UPDATE Customer SET BillingAddressID = 42, ShippingAddressID = 110 WHERE CustomerID = 58680
UPDATE Customer SET BillingAddressID = 43, ShippingAddressID = 43 WHERE CustomerID = 58681
UPDATE Customer SET BillingAddressID = 44, ShippingAddressID = 44 WHERE CustomerID = 58682
UPDATE Customer SET BillingAddressID = 45, ShippingAddressID = 45 WHERE CustomerID = 58683

UPDATE Customer SET BillingAddressID = 46, ShippingAddressID = 46 WHERE CustomerID = 58684
UPDATE Customer SET BillingAddressID = 47, ShippingAddressID = 111 WHERE CustomerID = 58685
UPDATE Customer SET BillingAddressID = 48, ShippingAddressID = 48 WHERE CustomerID = 58686
UPDATE Customer SET BillingAddressID = 49, ShippingAddressID = 49 WHERE CustomerID = 58687
UPDATE Customer SET BillingAddressID = 50, ShippingAddressID = 50 WHERE CustomerID = 58688

UPDATE Customer SET BillingAddressID = 51, ShippingAddressID = 51 WHERE CustomerID = 58689
UPDATE Customer SET BillingAddressID = 52, ShippingAddressID = 112 WHERE CustomerID = 58690
UPDATE Customer SET BillingAddressID = 53, ShippingAddressID = 53 WHERE CustomerID = 58691
UPDATE Customer SET BillingAddressID = 54, ShippingAddressID = 54 WHERE CustomerID = 58692
UPDATE Customer SET BillingAddressID = 55, ShippingAddressID = 55 WHERE CustomerID = 58693

UPDATE Customer SET BillingAddressID = 56, ShippingAddressID = 56 WHERE CustomerID = 58694
UPDATE Customer SET BillingAddressID = 57, ShippingAddressID = 113 WHERE CustomerID = 58695
UPDATE Customer SET BillingAddressID = 58, ShippingAddressID = 58 WHERE CustomerID = 58696
UPDATE Customer SET BillingAddressID = 59, ShippingAddressID = 59 WHERE CustomerID = 58697
UPDATE Customer SET BillingAddressID = 60, ShippingAddressID = 60 WHERE CustomerID = 58698

UPDATE Customer SET BillingAddressID = 61, ShippingAddressID = 114 WHERE CustomerID = 58699
UPDATE Customer SET BillingAddressID = 62, ShippingAddressID = 62 WHERE CustomerID = 58700
UPDATE Customer SET BillingAddressID = 63, ShippingAddressID = 63 WHERE CustomerID = 58701
UPDATE Customer SET BillingAddressID = 64, ShippingAddressID = 64 WHERE CustomerID = 58702
UPDATE Customer SET BillingAddressID = 65, ShippingAddressID = 115 WHERE CustomerID = 58703

UPDATE Customer SET BillingAddressID = 66, ShippingAddressID = 66 WHERE CustomerID = 58704
UPDATE Customer SET BillingAddressID = 67, ShippingAddressID = 67 WHERE CustomerID = 58705
UPDATE Customer SET BillingAddressID = 68, ShippingAddressID = 116 WHERE CustomerID = 58706
UPDATE Customer SET BillingAddressID = 69, ShippingAddressID = 69 WHERE CustomerID = 58707
UPDATE Customer SET BillingAddressID = 70, ShippingAddressID = 70 WHERE CustomerID = 58708

UPDATE Customer SET BillingAddressID = 71, ShippingAddressID = 117 WHERE CustomerID = 58709
UPDATE Customer SET BillingAddressID = 72, ShippingAddressID = 72 WHERE CustomerID = 58710
UPDATE Customer SET BillingAddressID = 73, ShippingAddressID = 73 WHERE CustomerID = 58711
UPDATE Customer SET BillingAddressID = 74, ShippingAddressID = 118 WHERE CustomerID = 58712
UPDATE Customer SET BillingAddressID = 75, ShippingAddressID = 75 WHERE CustomerID = 58713

UPDATE Customer SET BillingAddressID = 76, ShippingAddressID = 76 WHERE CustomerID = 58714
UPDATE Customer SET BillingAddressID = 77, ShippingAddressID = 119 WHERE CustomerID = 58715
UPDATE Customer SET BillingAddressID = 78, ShippingAddressID = 78 WHERE CustomerID = 58716
UPDATE Customer SET BillingAddressID = 79, ShippingAddressID = 79 WHERE CustomerID = 58717
UPDATE Customer SET BillingAddressID = 80, ShippingAddressID = 120 WHERE CustomerID = 58718

UPDATE Customer SET BillingAddressID = 81, ShippingAddressID = 81 WHERE CustomerID = 58719
UPDATE Customer SET BillingAddressID = 82, ShippingAddressID = 82 WHERE CustomerID = 58720
UPDATE Customer SET BillingAddressID = 83, ShippingAddressID = 121 WHERE CustomerID = 58721
UPDATE Customer SET BillingAddressID = 84, ShippingAddressID = 84 WHERE CustomerID = 58722
UPDATE Customer SET BillingAddressID = 85, ShippingAddressID = 85 WHERE CustomerID = 58723

UPDATE Customer SET BillingAddressID = 86, ShippingAddressID = 86 WHERE CustomerID = 58724
UPDATE Customer SET BillingAddressID = 87, ShippingAddressID = 87 WHERE CustomerID = 58725
UPDATE Customer SET BillingAddressID = 88, ShippingAddressID = 88 WHERE CustomerID = 58726
UPDATE Customer SET BillingAddressID = 89, ShippingAddressID = 89 WHERE CustomerID = 58727
UPDATE Customer SET BillingAddressID = 90, ShippingAddressID = 90 WHERE CustomerID = 58728

UPDATE Customer SET BillingAddressID = 91, ShippingAddressID = 91 WHERE CustomerID = 58729
UPDATE Customer SET BillingAddressID = 92, ShippingAddressID = 92 WHERE CustomerID = 58730
UPDATE Customer SET BillingAddressID = 93, ShippingAddressID = 93 WHERE CustomerID = 58731
UPDATE Customer SET BillingAddressID = 94, ShippingAddressID = 94 WHERE CustomerID = 58732
UPDATE Customer SET BillingAddressID = 95, ShippingAddressID = 95 WHERE CustomerID = 58733

UPDATE Customer SET BillingAddressID = 96, ShippingAddressID = 96 WHERE CustomerID = 58734
UPDATE Customer SET BillingAddressID = 97, ShippingAddressID = 97 WHERE CustomerID = 58735
UPDATE Customer SET BillingAddressID = 98, ShippingAddressID = 98 WHERE CustomerID = 58736
UPDATE Customer SET BillingAddressID = 99, ShippingAddressID = 99 WHERE CustomerID = 58737
UPDATE Customer SET BillingAddressID = 100, ShippingAddressID = 100 WHERE CustomerID = 58738
UPDATE Customer SET BillingAddressID = 101, ShippingAddressID = 101 WHERE CustomerID = 58739

UPDATE Customer SET BillingEqualsShipping = 1 WHERE BillingAddressID <> ShippingAddressID 



set identity_insert ordernumbers on;
insert into OrderNumbers (ordernumber) values (100137)
insert into OrderNumbers (ordernumber) values (100139)
insert into OrderNumbers (ordernumber) values (100140)
insert into OrderNumbers (ordernumber) values (100141)
insert into OrderNumbers (ordernumber) values (100156)
set identity_insert ordernumbers off;

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,SubscriptionIntervalType,TaxRate) 
values(100137,188,58640,102,111,1,'Lasko Air Director Floor/Window Fan','01-00102','39.99','39.99','<Detail><Address><AddressID>1</AddressID><NickName></NickName><FirstName>Admin</FirstName><LastName>User</LastName><Company></Company><ResidenceType>0</ResidenceType><Address1>140 Stump Dr</Address1><Address2></Address2><Suite></Suite><City>Pennsylvania</City><State>PA</State><Zip>15012</Zip><Country>United States</Country><Phone>724-930-9470</Phone><EMail>steve_alisauskas@gmail.com</EMail></Address><Shipping><CustomerID>58640</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',4,'Parcel Select BMC and OBMC Presort',1,3,20.00)

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,SubscriptionIntervalType,TaxRate) 
values(100139,188,58640,102,111,1,'Lasko Air Director Floor/Window Fan','01-00102','39.99','39.99','<Detail><Address><AddressID>1</AddressID><NickName></NickName><FirstName>Admin</FirstName><LastName>User</LastName><Company></Company><ResidenceType>0</ResidenceType><Address1>140 Stump Dr</Address1><Address2></Address2><Suite></Suite><City>Pennsylvania</City><State>PA</State><Zip>15012</Zip><Country>United States</Country><Phone>724-930-9470</Phone><EMail>steve_alisauskas@gmail.com</EMail></Address><Shipping><CustomerID>58640</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',4,'Parcel Select BMC and OBMC Presort',1,3,20.00)

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,SubscriptionIntervalType,TaxRate) 
values(100140,188,58640,102,111,1,'Lasko Air Director Floor/Window Fan','01-00102','39.99','39.99','<Detail><Address><AddressID>1</AddressID><NickName></NickName><FirstName>Admin</FirstName><LastName>User</LastName><Company></Company><ResidenceType>0</ResidenceType><Address1>140 Stump Dr</Address1><Address2></Address2><Suite></Suite><City>Pennsylvania</City><State>PA</State><Zip>15012</Zip><Country>United States</Country><Phone>724-930-9470</Phone><EMail>steve_alisauskas@gmail.com</EMail></Address><Shipping><CustomerID>58640</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',4,'Parcel Select BMC and OBMC Presort',1,3,20.00)

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,SubscriptionIntervalType,TaxRate) 
values(100141,188,58640,102,111,1,'Lasko Air Director Floor/Window Fan','01-00102','39.99','39.99','<Detail><Address><AddressID>1</AddressID><NickName></NickName><FirstName>Admin</FirstName><LastName>User</LastName><Company></Company><ResidenceType>0</ResidenceType><Address1>140 Stump Dr</Address1><Address2></Address2><Suite></Suite><City>Pennsylvania</City><State>PA</State><Zip>15012</Zip><Country>United States</Country><Phone>724-930-9470</Phone><EMail>steve_alisauskas@gmail.com</EMail></Address><Shipping><CustomerID>58640</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',4,'Parcel Select BMC and OBMC Presort',1,3,20.00)

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,IsTaxable,ShippingAddressID,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,IsSystem,TaxClassID,TaxRate)
values  (100156,215,58639,97,106,1,'Wall Mounted Vent-free Gas Fireplace','01-00097',296.99,329.99,1,1,'<Detail><Address><AddressID>122</AddressID><NickName>joseph</NickName><FirstName>joseph</FirstName><LastName>joseph</LastName><Company>joseph</Company><ResidenceType>0</ResidenceType><Address1>123 joseph</Address1><Address2></Address2><Suite></Suite><City>boston</City><State>MA</State><Zip>01432</Zip><Country>United States</Country><Phone>911-11</Phone><EMail></EMail></Address><Shipping><CustomerID>58639</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',0,'',1,NULL,1,15.00)

insert into Orders_ShoppingCart (OrderNumber,ShoppingCartRecID,CustomerID,ProductID,VariantID,Quantity,OrderedProductName,OrderedProductSKU,OrderedProductPrice,OrderedProductRegularPrice,IsTaxable,ShippingAddressID,ShippingDetail,ShippingMethodID,ShippingMethod,DistributorID,IsSystem,TaxClassID,TaxRate)
values  (100156,214,58639,97,106,1,'Wall Mounted Vent-free Gas Fireplace','01-00097',296.99,329.99,1,121,'<Detail><Address><AddressID>1</AddressID><NickName></NickName><FirstName>Admin</FirstName><LastName>User</LastName><Company></Company><ResidenceType>0</ResidenceType><Address1>123 Main St</Address1><Address2></Address2><Suite></Suite><City>New York</City><State>NY</State><Zip>10451</Zip><Country>United States</Country><Phone>123-456-7890</Phone><EMail>admin@admin.com</EMail></Address><Shipping><CustomerID>58639</CustomerID><Date>0001-01-01T00:00:00</Date></Shipping></Detail>',0,'',1,NULL,1,15.00)						

insert into Orders (OrderNumber,CustomerID,CustomerGUID,SkinID,ShippingMethodID,ShippingCalculationID,CardType,OrderSubtotal,OrderTax,OrderShippingCosts,OrderTotal,PaymentGateway,AuthorizationResult,AuthorizationPNREF,TransactionCommand,PaymentMethod,TransactionState,AVSResult,LocaleSetting,AlreadyConfirmed,CartType,AuthorizedOn,OrderWeight,CapturedOn,Last4,RTShipRequest,RTShipResponse,LastIPAddress,TransactionType,ReceiptEmailSentOn,AuthorizationCode,OkToEmail,RegisterDate,ShippingMethod,StoreVersion,VoidTXCommand,VoidTXResult,VoidedOn,BillingAddress1,BillingCity,BillingState,BillingZip,BillingPhone,ShippingAddress1,ShippingCity,ShippingCountry,BillingLastName,BillingFirstName,ShippingLastName,ShippingFirstName,Email)
values (100137,58640,'78659F0E-44E5-4A5A-BB5A-083962B5DC6C',1,4,8,'VISA',39.99,8.91,4.55,53.45,'MANUAL','MANUAL GATEWAY SAID OK','83138C97-896F-46F6-BAFC-8E94D0BAACC6','x_type=AUTH_CAPTURE&x_test_request=TRUE&x_description=AspDotNetStorefront+Order+100137&x_amount=53.45&x_card_num=****1111&x_card_code=***&x_exp_date=03/2010&x_phone=***-456-7890&x_fax=&x_customer_tax_id=&x_cust_id=58640&x_invoice_num=100137&x_email=admin%40aspdotnetstorefront.com&x_customer_ip=127.0.0.1&x_first_name=Admin&x_last_name=User&x_company=&x_address=***+Main+St&x_city=New+York&x_state=NY&x_zip=10002&x_country=United+States&x_ship_to_first_name=Admin&x_ship_to_last_name=User&x_ship_to_company=&x_ship_to_address=***+Main+St&x_ship_to_city=New+York&x_ship_to_state=NY&x_ship_to_zip=10002&x_ship_to_country=United+States&x_customer_ip=127.0.0.1','CREDITCARD','VOIDED','OK','en-US',1,0,'2008-11-14 18:15:58.807',1,'2008-11-14 18:15:58.947',1111,'<UPSRequest><AccessRequest xml:lang="en-us"><AccessLicenseNumber>FB91B6D3F6A6AFC8</AccessLicenseNumber><UserId>mikecoburn</UserId><Password>j1i1m1i1</Password></AccessRequest><RatingServiceSelectionRequest xml:lang="en-US"><Request><RequestAction>Rate</RequestAction><RequestOption>Shop</RequestOption><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference></Request><PickupType><Code>01</Code></PickupType><Shipment><Shipper><Address><City>DAYTON</City><StateProvinceCode>OH</StateProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></Address></Shipper><ShipTo><Address><City>NEW YORK</City><StateProvinceCode>WA</StateProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode><ResidentialAddressIndicator/></Address></ShipTo><ShipmentWeight><UnitOfMeasurement><Code>LBS</Code></UnitOfMeasurement><Weight>1.5</Weight></ShipmentWeight><Package><PackagingType><Code>02</Code></PackagingType><Dimensions><UnitOfMeasurement><Code>IN</Code></UnitOfMeasurement><Length>0</Length><Width>0</Width><Height>0</Height></Dimensions><Description>1</Description><PackageWeight><UnitOfMeasure><Code>LBS</Code></UnitOfMeasure><Weight>1.5</Weight></PackageWeight><OversizePackage /></Package><ShipmentServiceOptions/></Shipment></RatingServiceSelectionRequest></UPSRequest><USPSRequest><RateV2Request USERID="758PARAC7739"><Package ID="1-0"><Service>Express</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-1"><Service>Priority</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-2"><Service>Parcel</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-3"><Service>Library</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-4"><Service>Media</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package></RateV2Request></USPSRequest><FedExRequest><FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XmlSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd"><RequestHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier><AccountNumber>183045091</AccountNumber><MeterNumber>7298194</MeterNumber><CarrierCode></CarrierCode></RequestHeader><ShipDate>2008-10-18</ShipDate><DropoffType>REGULARPICKUP</DropoffType><Packaging>YOURPACKAGING</Packaging><WeightUnits>LBS</WeightUnits><ListRate>false</ListRate><Weight>1.5</Weight><OriginAddress><StateOrProvinceCode>OH</StateOrProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></OriginAddress><DestinationAddress><StateOrProvinceCode>WA</StateOrProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode></DestinationAddress><Payment><PayorType>SENDER</PayorType></Payment><PackageCount>1</PackageCount></FDXRateAvailableServicesRequest></FedExRequest><DHLRequest><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Request" version="1.1"><Requestor><ID /><Password /></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce></DHLRequest>','<UPSResponse><RatingServiceSelectionResponse><Response><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference><ResponseStatusCode>0</ResponseStatusCode><ResponseStatusDescription>Failure</ResponseStatusDescription><Error><ErrorSeverity>Hard</ErrorSeverity><ErrorCode>111285</ErrorCode><ErrorDescription>The postal code 10451 is invalid for WA United States.</ErrorDescription></Error></Response></RatingServiceSelectionResponse></UPSResponse><USPSResponse>  <RateV2Response><Package ID="1-0"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Express Mail</MailService><Rate>24.65</Rate></Postage></Package><Package ID="1-1"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Priority Mail</MailService><Rate>5.60</Rate></Postage></Package><Package ID="1-2"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Machinable>FALSE</Machinable><Zone>4</Zone><Postage><MailService>Parcel Post</MailService><Rate>9.05</Rate></Postage></Package><Package ID="1-3"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Library Mail</MailService><Rate>2.45</Rate></Postage></Package><Package ID="1-4"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Media Mail</MailService><Rate>2.58</Rate></Postage></Package></RateV2Response>  </USPSResponse><FedExResponse><FDXRateAvailableServicesReply xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesReply.xsd"><ReplyHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier></ReplyHeader><Error><Code>61468</Code><Message>Recipient postal code does not match recipient state/province code.</Message></Error></FDXRateAvailableServicesReply></FedExResponse><DHLResponse><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Response" version="1.1" timestamp="2008/10/17T03:21:22" transmission_reference="680E6900"><Faults><Fault><Code>1002</Code><Description><![CDATA[Required element/node is missing.]]></Description><Context><![CDATA[The required node <ID> is missing, empty, or contains a value that is not the correct data type.]]></Context></Fault></Faults><Requestor><ID/><Password/></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce>  </DHLResponse>','127.0.0.1',1,GETDATE(),0,1,'2008-09-22 12:02:23.000','Parcel Select BMC and OBMC Presort','AspDotNetStorefront ML 8.0.1.2/8.0.1.2','x_type=VOID&x_test_request=TRUE&x_customer_ip=127.0.0.1&x_trans_id=83138C97-896F-46F6-BAFC-8E94D0BAACC6','MANUAL GATEWAY SAID OK',GETDATE(),'140 Stump Dr','Pennsylvania','PA','15012','724-930-9470','26 Antheon Street','Athens','Greece','Alisauskas','Steve','Alishio','Arnold','steve_alisauskas@gmail.com')

insert into Orders (OrderNumber,CustomerID,CustomerGUID,SkinID,ShippingMethodID,ShippingCalculationID,CardType,OrderSubtotal,OrderTax,OrderShippingCosts,OrderTotal,PaymentGateway,AuthorizationResult,AuthorizationPNREF,TransactionCommand,PaymentMethod,TransactionState,AVSResult,LocaleSetting,AlreadyConfirmed,CartType,AuthorizedOn,OrderWeight,CapturedOn,Last4,RTShipRequest,RTShipResponse,LastIPAddress,TransactionType,ReceiptEmailSentOn,AuthorizationCode,OkToEmail,RegisterDate,ShippingMethod,StoreVersion,BillingAddress1,BillingCity,BillingState,BillingZip,BillingPhone,ShippingAddress1,ShippingCity,ShippingCountry,BillingLastName,BillingFirstName,ShippingLastName,ShippingFirstName,Email,RefundTXCommand,RefundTXResult,RefundedOn,RefundReason)
values (100139,58640,'78659F0E-44E5-4A5A-BB5A-083962B5DC6C',1,4,8,'VISA',39.99,8.91,4.55,53.45,'MANUAL','MANUAL GATEWAY SAID OK','83138C97-896F-46F6-BAFC-8E94D0BAACC6','x_type=AUTH_CAPTURE&x_test_request=TRUE&x_description=AspDotNetStorefront+Order+100137&x_amount=53.45&x_card_num=****1111&x_card_code=***&x_exp_date=03/2010&x_phone=***-456-7890&x_fax=&x_customer_tax_id=&x_cust_id=58640&x_invoice_num=100137&x_email=admin%40aspdotnetstorefront.com&x_customer_ip=127.0.0.1&x_first_name=Admin&x_last_name=User&x_company=&x_address=***+Main+St&x_city=New+York&x_state=NY&x_zip=10002&x_country=United+States&x_ship_to_first_name=Admin&x_ship_to_last_name=User&x_ship_to_company=&x_ship_to_address=***+Main+St&x_ship_to_city=New+York&x_ship_to_state=NY&x_ship_to_zip=10002&x_ship_to_country=United+States&x_customer_ip=127.0.0.1','CREDITCARD','REFUNDED','OK','en-US',1,0,'2008-11-14 18:15:58.807',1,'2008-11-14 18:15:58.947',1111,'<UPSRequest><AccessRequest xml:lang="en-us"><AccessLicenseNumber>FB91B6D3F6A6AFC8</AccessLicenseNumber><UserId>mikecoburn</UserId><Password>j1i1m1i1</Password></AccessRequest><RatingServiceSelectionRequest xml:lang="en-US"><Request><RequestAction>Rate</RequestAction><RequestOption>Shop</RequestOption><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference></Request><PickupType><Code>01</Code></PickupType><Shipment><Shipper><Address><City>DAYTON</City><StateProvinceCode>OH</StateProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></Address></Shipper><ShipTo><Address><City>NEW YORK</City><StateProvinceCode>WA</StateProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode><ResidentialAddressIndicator/></Address></ShipTo><ShipmentWeight><UnitOfMeasurement><Code>LBS</Code></UnitOfMeasurement><Weight>1.5</Weight></ShipmentWeight><Package><PackagingType><Code>02</Code></PackagingType><Dimensions><UnitOfMeasurement><Code>IN</Code></UnitOfMeasurement><Length>0</Length><Width>0</Width><Height>0</Height></Dimensions><Description>1</Description><PackageWeight><UnitOfMeasure><Code>LBS</Code></UnitOfMeasure><Weight>1.5</Weight></PackageWeight><OversizePackage /></Package><ShipmentServiceOptions/></Shipment></RatingServiceSelectionRequest></UPSRequest><USPSRequest><RateV2Request USERID="758PARAC7739"><Package ID="1-0"><Service>Express</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-1"><Service>Priority</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-2"><Service>Parcel</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-3"><Service>Library</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-4"><Service>Media</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package></RateV2Request></USPSRequest><FedExRequest><FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XmlSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd"><RequestHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier><AccountNumber>183045091</AccountNumber><MeterNumber>7298194</MeterNumber><CarrierCode></CarrierCode></RequestHeader><ShipDate>2008-10-18</ShipDate><DropoffType>REGULARPICKUP</DropoffType><Packaging>YOURPACKAGING</Packaging><WeightUnits>LBS</WeightUnits><ListRate>false</ListRate><Weight>1.5</Weight><OriginAddress><StateOrProvinceCode>OH</StateOrProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></OriginAddress><DestinationAddress><StateOrProvinceCode>WA</StateOrProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode></DestinationAddress><Payment><PayorType>SENDER</PayorType></Payment><PackageCount>1</PackageCount></FDXRateAvailableServicesRequest></FedExRequest><DHLRequest><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Request" version="1.1"><Requestor><ID /><Password /></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce></DHLRequest>','<UPSResponse><RatingServiceSelectionResponse><Response><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference><ResponseStatusCode>0</ResponseStatusCode><ResponseStatusDescription>Failure</ResponseStatusDescription><Error><ErrorSeverity>Hard</ErrorSeverity><ErrorCode>111285</ErrorCode><ErrorDescription>The postal code 10451 is invalid for WA United States.</ErrorDescription></Error></Response></RatingServiceSelectionResponse></UPSResponse><USPSResponse>  <RateV2Response><Package ID="1-0"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Express Mail</MailService><Rate>24.65</Rate></Postage></Package><Package ID="1-1"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Priority Mail</MailService><Rate>5.60</Rate></Postage></Package><Package ID="1-2"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Machinable>FALSE</Machinable><Zone>4</Zone><Postage><MailService>Parcel Post</MailService><Rate>9.05</Rate></Postage></Package><Package ID="1-3"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Library Mail</MailService><Rate>2.45</Rate></Postage></Package><Package ID="1-4"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Media Mail</MailService><Rate>2.58</Rate></Postage></Package></RateV2Response>  </USPSResponse><FedExResponse><FDXRateAvailableServicesReply xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesReply.xsd"><ReplyHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier></ReplyHeader><Error><Code>61468</Code><Message>Recipient postal code does not match recipient state/province code.</Message></Error></FDXRateAvailableServicesReply></FedExResponse><DHLResponse><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Response" version="1.1" timestamp="2008/10/17T03:21:22" transmission_reference="680E6900"><Faults><Fault><Code>1002</Code><Description><![CDATA[Required element/node is missing.]]></Description><Context><![CDATA[The required node <ID> is missing, empty, or contains a value that is not the correct data type.]]></Context></Fault></Faults><Requestor><ID/><Password/></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce>  </DHLResponse>','127.0.0.1',1,GETDATE(),0,1,'2008-09-22 12:02:23.000','Parcel Select BMC and OBMC Presort','AspDotNetStorefront ML 8.0.1.2/8.0.1.2','140 Stump Dr','Pennsylvania','PA','15012','724-930-9470','26 Antheon Street','Athens','Greece','Alisauskas','Steve','Alishio','Arnold','steve_alisauskas@gmail.com','x_type=CREDIT&x_test_request=TRUE&x_trans_id=3689A94A-5109-4E5F-BADF-711B83D91687&x_amount=39.99&x_customer_ip=127.0.0.1&x_card_num=1111','MANUAL GATEWAY SAID OK',getdate(),'NOTHING')

insert into Orders (OrderNumber,CustomerID,CustomerGUID,SkinID,ShippingMethodID,ShippingCalculationID,CardType,OrderSubtotal,OrderTax,OrderShippingCosts,OrderTotal,PaymentGateway,AuthorizationResult,AuthorizationPNREF,TransactionCommand,PaymentMethod,TransactionState,AVSResult,LocaleSetting,AlreadyConfirmed,CartType,AuthorizedOn,OrderWeight,CapturedOn,Last4,RTShipRequest,RTShipResponse,LastIPAddress,TransactionType,ReceiptEmailSentOn,AuthorizationCode,OkToEmail,RegisterDate,ShippingMethod,StoreVersion,BillingAddress1,BillingCity,BillingState,BillingZip,BillingPhone,ShippingAddress1,ShippingCity,ShippingCountry,BillingLastName,BillingFirstName,ShippingLastName,ShippingFirstName,Email,ShippingTrackingNumber,ShippedVIA,ShippedOn)
values (100140,58640,'78659F0E-44E5-4A5A-BB5A-083962B5DC6C',1,4,8,'VISA',39.99,8.91,4.55,53.45,'MANUAL','MANUAL GATEWAY SAID OK','83138C97-896F-46F6-BAFC-8E94D0BAACC6','x_type=AUTH_CAPTURE&x_test_request=TRUE&x_description=AspDotNetStorefront+Order+100137&x_amount=53.45&x_card_num=****1111&x_card_code=***&x_exp_date=03/2010&x_phone=***-456-7890&x_fax=&x_customer_tax_id=&x_cust_id=58640&x_invoice_num=100137&x_email=admin%40aspdotnetstorefront.com&x_customer_ip=127.0.0.1&x_first_name=Admin&x_last_name=User&x_company=&x_address=***+Main+St&x_city=New+York&x_state=NY&x_zip=10002&x_country=United+States&x_ship_to_first_name=Admin&x_ship_to_last_name=User&x_ship_to_company=&x_ship_to_address=***+Main+St&x_ship_to_city=New+York&x_ship_to_state=NY&x_ship_to_zip=10002&x_ship_to_country=United+States&x_customer_ip=127.0.0.1','CREDITCARD','CAPTURED','OK','en-US',1,0,'2008-11-14 18:15:58.807',1,'2008-11-14 18:15:58.947',1111,'<UPSRequest><AccessRequest xml:lang="en-us"><AccessLicenseNumber>FB91B6D3F6A6AFC8</AccessLicenseNumber><UserId>mikecoburn</UserId><Password>j1i1m1i1</Password></AccessRequest><RatingServiceSelectionRequest xml:lang="en-US"><Request><RequestAction>Rate</RequestAction><RequestOption>Shop</RequestOption><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference></Request><PickupType><Code>01</Code></PickupType><Shipment><Shipper><Address><City>DAYTON</City><StateProvinceCode>OH</StateProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></Address></Shipper><ShipTo><Address><City>NEW YORK</City><StateProvinceCode>WA</StateProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode><ResidentialAddressIndicator/></Address></ShipTo><ShipmentWeight><UnitOfMeasurement><Code>LBS</Code></UnitOfMeasurement><Weight>1.5</Weight></ShipmentWeight><Package><PackagingType><Code>02</Code></PackagingType><Dimensions><UnitOfMeasurement><Code>IN</Code></UnitOfMeasurement><Length>0</Length><Width>0</Width><Height>0</Height></Dimensions><Description>1</Description><PackageWeight><UnitOfMeasure><Code>LBS</Code></UnitOfMeasure><Weight>1.5</Weight></PackageWeight><OversizePackage /></Package><ShipmentServiceOptions/></Shipment></RatingServiceSelectionRequest></UPSRequest><USPSRequest><RateV2Request USERID="758PARAC7739"><Package ID="1-0"><Service>Express</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-1"><Service>Priority</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-2"><Service>Parcel</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-3"><Service>Library</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-4"><Service>Media</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package></RateV2Request></USPSRequest><FedExRequest><FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XmlSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd"><RequestHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier><AccountNumber>183045091</AccountNumber><MeterNumber>7298194</MeterNumber><CarrierCode></CarrierCode></RequestHeader><ShipDate>2008-10-18</ShipDate><DropoffType>REGULARPICKUP</DropoffType><Packaging>YOURPACKAGING</Packaging><WeightUnits>LBS</WeightUnits><ListRate>false</ListRate><Weight>1.5</Weight><OriginAddress><StateOrProvinceCode>OH</StateOrProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></OriginAddress><DestinationAddress><StateOrProvinceCode>WA</StateOrProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode></DestinationAddress><Payment><PayorType>SENDER</PayorType></Payment><PackageCount>1</PackageCount></FDXRateAvailableServicesRequest></FedExRequest><DHLRequest><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Request" version="1.1"><Requestor><ID /><Password /></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce></DHLRequest>','<UPSResponse><RatingServiceSelectionResponse><Response><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference><ResponseStatusCode>0</ResponseStatusCode><ResponseStatusDescription>Failure</ResponseStatusDescription><Error><ErrorSeverity>Hard</ErrorSeverity><ErrorCode>111285</ErrorCode><ErrorDescription>The postal code 10451 is invalid for WA United States.</ErrorDescription></Error></Response></RatingServiceSelectionResponse></UPSResponse><USPSResponse>  <RateV2Response><Package ID="1-0"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Express Mail</MailService><Rate>24.65</Rate></Postage></Package><Package ID="1-1"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Priority Mail</MailService><Rate>5.60</Rate></Postage></Package><Package ID="1-2"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Machinable>FALSE</Machinable><Zone>4</Zone><Postage><MailService>Parcel Post</MailService><Rate>9.05</Rate></Postage></Package><Package ID="1-3"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Library Mail</MailService><Rate>2.45</Rate></Postage></Package><Package ID="1-4"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Media Mail</MailService><Rate>2.58</Rate></Postage></Package></RateV2Response>  </USPSResponse><FedExResponse><FDXRateAvailableServicesReply xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesReply.xsd"><ReplyHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier></ReplyHeader><Error><Code>61468</Code><Message>Recipient postal code does not match recipient state/province code.</Message></Error></FDXRateAvailableServicesReply></FedExResponse><DHLResponse><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Response" version="1.1" timestamp="2008/10/17T03:21:22" transmission_reference="680E6900"><Faults><Fault><Code>1002</Code><Description><![CDATA[Required element/node is missing.]]></Description><Context><![CDATA[The required node <ID> is missing, empty, or contains a value that is not the correct data type.]]></Context></Fault></Faults><Requestor><ID/><Password/></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce>  </DHLResponse>','127.0.0.1',1,GETDATE(),0,1,'2008-09-22 12:02:23.000','Parcel Select BMC and OBMC Presort','AspDotNetStorefront ML 8.0.1.2/8.0.1.2','140 Stump Dr','Pennsylvania','PA','15012','724-930-9470','26 Antheon Street','Athens','Greece','Alisauskas','Steve','Alishio','Arnold','steve_alisauskas@gmail.com',123456,'FEDEX Express',GETDATE())

insert into Orders (OrderNumber,CustomerID,CustomerGUID,SkinID,ShippingMethodID,ShippingCalculationID,CardType,OrderSubtotal,OrderTax,OrderShippingCosts,OrderTotal,PaymentGateway,AuthorizationResult,AuthorizationPNREF,TransactionCommand,PaymentMethod,TransactionState,AVSResult,LocaleSetting,AlreadyConfirmed,CartType,AuthorizedOn,OrderWeight,CapturedOn,Last4,RTShipRequest,RTShipResponse,LastIPAddress,TransactionType,ReceiptEmailSentOn,AuthorizationCode,OkToEmail,RegisterDate,ShippingMethod,StoreVersion,BillingAddress1,BillingCity,BillingState,BillingZip,BillingPhone,ShippingAddress1,ShippingCity,ShippingCountry,BillingLastName,BillingFirstName,ShippingLastName,ShippingFirstName,Email)
values (100141,58640,'78659F0E-44E5-4A5A-BB5A-083962B5DC6C',1,4,8,'VISA',39.99,8.91,4.55,53.45,'MANUAL','MANUAL GATEWAY SAID OK','83138C97-896F-46F6-BAFC-8E94D0BAACC6','x_type=AUTH_CAPTURE&x_test_request=TRUE&x_description=AspDotNetStorefront+Order+100137&x_amount=53.45&x_card_num=****1111&x_card_code=***&x_exp_date=03/2010&x_phone=***-456-7890&x_fax=&x_customer_tax_id=&x_cust_id=58640&x_invoice_num=100137&x_email=admin%40aspdotnetstorefront.com&x_customer_ip=127.0.0.1&x_first_name=Admin&x_last_name=User&x_company=&x_address=***+Main+St&x_city=New+York&x_state=NY&x_zip=10002&x_country=United+States&x_ship_to_first_name=Admin&x_ship_to_last_name=User&x_ship_to_company=&x_ship_to_address=***+Main+St&x_ship_to_city=New+York&x_ship_to_state=NY&x_ship_to_zip=10002&x_ship_to_country=United+States&x_customer_ip=127.0.0.1','CREDITCARD','CAPTURED','OK','en-US',1,0,'2008-11-14 18:15:58.807',1,'2008-11-14 18:15:58.947',1111,'<UPSRequest><AccessRequest xml:lang="en-us"><AccessLicenseNumber>FB91B6D3F6A6AFC8</AccessLicenseNumber><UserId>mikecoburn</UserId><Password>j1i1m1i1</Password></AccessRequest><RatingServiceSelectionRequest xml:lang="en-US"><Request><RequestAction>Rate</RequestAction><RequestOption>Shop</RequestOption><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference></Request><PickupType><Code>01</Code></PickupType><Shipment><Shipper><Address><City>DAYTON</City><StateProvinceCode>OH</StateProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></Address></Shipper><ShipTo><Address><City>NEW YORK</City><StateProvinceCode>WA</StateProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode><ResidentialAddressIndicator/></Address></ShipTo><ShipmentWeight><UnitOfMeasurement><Code>LBS</Code></UnitOfMeasurement><Weight>1.5</Weight></ShipmentWeight><Package><PackagingType><Code>02</Code></PackagingType><Dimensions><UnitOfMeasurement><Code>IN</Code></UnitOfMeasurement><Length>0</Length><Width>0</Width><Height>0</Height></Dimensions><Description>1</Description><PackageWeight><UnitOfMeasure><Code>LBS</Code></UnitOfMeasure><Weight>1.5</Weight></PackageWeight><OversizePackage /></Package><ShipmentServiceOptions/></Shipment></RatingServiceSelectionRequest></UPSRequest><USPSRequest><RateV2Request USERID="758PARAC7739"><Package ID="1-0"><Service>Express</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-1"><Service>Priority</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-2"><Service>Parcel</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-3"><Service>Library</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package><Package ID="1-4"><Service>Media</Service><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>Regular</Size><Machinable>False</Machinable></Package></RateV2Request></USPSRequest><FedExRequest><FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XmlSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd"><RequestHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier><AccountNumber>183045091</AccountNumber><MeterNumber>7298194</MeterNumber><CarrierCode></CarrierCode></RequestHeader><ShipDate>2008-10-18</ShipDate><DropoffType>REGULARPICKUP</DropoffType><Packaging>YOURPACKAGING</Packaging><WeightUnits>LBS</WeightUnits><ListRate>false</ListRate><Weight>1.5</Weight><OriginAddress><StateOrProvinceCode>OH</StateOrProvinceCode><PostalCode>45459</PostalCode><CountryCode>US</CountryCode></OriginAddress><DestinationAddress><StateOrProvinceCode>WA</StateOrProvinceCode><PostalCode>10451</PostalCode><CountryCode>US</CountryCode></DestinationAddress><Payment><PayorType>SENDER</PayorType></Payment><PackageCount>1</PackageCount></FDXRateAvailableServicesRequest></FedExRequest><DHLRequest><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Request" version="1.1"><Requestor><ID /><Password /></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr /></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr /></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions /><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce></DHLRequest>','<UPSResponse><RatingServiceSelectionResponse><Response><TransactionReference><CustomerContext>Rating and Service</CustomerContext><XpciVersion>1.0001</XpciVersion></TransactionReference><ResponseStatusCode>0</ResponseStatusCode><ResponseStatusDescription>Failure</ResponseStatusDescription><Error><ErrorSeverity>Hard</ErrorSeverity><ErrorCode>111285</ErrorCode><ErrorDescription>The postal code 10451 is invalid for WA United States.</ErrorDescription></Error></Response></RatingServiceSelectionResponse></UPSResponse><USPSResponse>  <RateV2Response><Package ID="1-0"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Express Mail</MailService><Rate>24.65</Rate></Postage></Package><Package ID="1-1"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Priority Mail</MailService><Rate>5.60</Rate></Postage></Package><Package ID="1-2"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Machinable>FALSE</Machinable><Zone>4</Zone><Postage><MailService>Parcel Post</MailService><Rate>9.05</Rate></Postage></Package><Package ID="1-3"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Library Mail</MailService><Rate>2.45</Rate></Postage></Package><Package ID="1-4"><ZipOrigination>45459</ZipOrigination><ZipDestination>10451</ZipDestination><Pounds>1</Pounds><Ounces>8</Ounces><Size>REGULAR</Size><Zone>4</Zone><Postage><MailService>Media Mail</MailService><Rate>2.58</Rate></Postage></Package></RateV2Response>  </USPSResponse><FedExResponse><FDXRateAvailableServicesReply xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesReply.xsd"><ReplyHeader><CustomerTransactionIdentifier>RatesRequest</CustomerTransactionIdentifier></ReplyHeader><Error><Code>61468</Code><Message>Recipient postal code does not match recipient state/province code.</Message></Error></FDXRateAvailableServicesReply></FedExResponse><DHLResponse><ECommerce xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" action="Response" version="1.1" timestamp="2008/10/17T03:21:22" transmission_reference="680E6900"><Faults><Fault><Code>1002</Code><Description><![CDATA[Required element/node is missing.]]></Description><Context><![CDATA[The required node <ID> is missing, empty, or contains a value that is not the correct data type.]]></Context></Fault></Faults><Requestor><ID/><Password/></Requestor><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>G</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Ground Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>S</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL 2nd Day Service</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>N</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 3:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 12:00 pm</TransactionTrace></Shipment><Shipment action="RateEstimate" version="1.0"><ShippingCredentials><ShippingKey>54233F2B2C41554143565B555D503053414A544B4258565D50</ShippingKey><AccountNbr/></ShippingCredentials><ShipmentDetail><ShipDate>2008-10-20</ShipDate><Service><Code>E</Code></Service><ShipmentType><Code>P</Code></ShipmentType><Weight>2</Weight><SpecialServices><SpecialService><Code>1030</Code></SpecialService></SpecialServices></ShipmentDetail><Billing><Party><Code>S</Code></Party><AccountNbr/></Billing><Receiver><Address><State>WA</State><Country>US</Country><PostalCode>10451</PostalCode></Address></Receiver><ShipmentProcessingInstructions/><TransactionTrace>DHL Next Day 10:30 am</TransactionTrace></Shipment></ECommerce>  </DHLResponse>','127.0.0.1',1,GETDATE(),0,1,'2008-09-22 12:02:23.000','Parcel Select BMC and OBMC Presort','AspDotNetStorefront ML 8.0.1.2/8.0.1.2','140 Stump Dr','Pennsylvania','PA','15012','724-930-9470','26 Antheon Street','Athens','Greece','Alisauskas','Steve','Alishio','Arnold','steve_alisauskas@gmail.com')

insert into orders (OrderNumber,CustomerID,CustomerGUID,SkinID,ShippedOn,LastName,FirstName,Email,BillingLastName,BillingFirstName,BillingAddress1,BillingCity,BillingState,BillingZip,BillingCountry,BillingPhone,ShippingLastName,ShippingFirstName,ShippingCompany,ShippingResidenceType,ShippingAddress1,ShippingAddress2,ShippingSuite,ShippingCity,ShippingState,ShippingZip,ShippingCountry,ShippingMethodID,ShippingMethod,ShippingPhone,ShippingCalculationID,Phone,RegisterDate,OkToEmail,Deleted,CardType,CardName,CardNumber,CardExpirationMonth,CardExpirationYear,OrderSubtotal,OrderTax,OrderTotal,PaymentGateWay,AuthorizationResult,AuthorizationPNREF,TransactionCommand,OrderDate,LastIPAddress,PaymentMethod,ReceiptEmailSentOn,TransactionState,AVSResult,OrderWeight,LocaleSetting,FinalizationData,AlreadyConfirmed,CartType,Last4,ReadyToShip,IsPrinted,AuthorizedOn,CapturedOn,TransactionType,StoreVersion)
values (100156,58639,'F40420EB-6B38-4F4C-9D57-164A7C1F2DB1',1,NULL,'User','Admin','admin@admin.com','User','Admin','123 Main St','New York','NY',10451,'United States',123-456-7890,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,8,911,'2008-11-17 09:34:01.000',1,0,'VISA','Admin User','Not Stored',04,2010,593.98,74.25,668.23,'MANUAL','MANUAL GATEWAY SAID OK','1722927B-5ABD-466D-9BED-624ED6BC788A','x_type=AUTH_CAPTURE&x_test_request=TRUE&x_description=AspDotNetStorefront+Order+100156&x_amount=668.23&x_card_num=****1111&x_card_code=***&x_exp_date=04/2010&x_phone=***-456-7890&x_fax=&x_customer_tax_id=&x_cust_id=58639&x_invoice_num=100156&x_email=admin%40aspdotnetstorefront.com&x_customer_ip=127.0.0.1&x_first_name=Admin&x_last_name=User&x_company=&x_address=***+Main+St&x_city=New+York&x_state=NY&x_zip=10451&x_country=United+States&x_customer_ip=127.0.0.1',GETDATE(),'127.0.0.1','CREDITCARD',GETDATE(),'CAPTURED','OK',1,'en-US','<root></root>',1,0,1111,0,0,GETDATE(),GETDATE(),1,'AspDotNetStorefront ML 8.0.1.2/8.0.1.2')


--_OrderOption
SET IDENTITY_INSERT [dbo].OrderOption ON;
INSERT INTO [dbo].OrderOption (OrderOptionID,Name,Description,Cost,DisplayOrder,DefaultIsChecked,TaxClassID) VALUES (1,'Gift Wrap','Gift Wrap your present',10.00,1,0,5)
SET IDENTITY_INSERT [dbo].OrderOption OFF;

--_MicroPay
-- MICROPAY System Product:
INSERT [dbo].Product(Name,Description,ProductTypeID,SalesPromptID,SKU,ManufacturerPartNumber,Published) values('Add $5 to my MicroPay account','Add $5 to my MicroPay account System Product, Do Not delete',1,1,'MICROPAY','MICROPAY',1);
go
INSERT [dbo].ProductVariant(ProductID,Name,IsDefault) select ProductID,SKU,1 from Product where SKU='MICROPAY';
go
update [dbo].ProductVariant set Name='',Description='',SKUSuffix='',Price=5.00,Inventory=100000,Published=1,IsDownload=0,FreeShipping=1,DownloadLocation=NULL where Name='MICROPAY';
GO
update [dbo].Product set IsSystem=1 where SKU='MICROPAY';
go











