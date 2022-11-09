using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003C RID: 60
public class MonsterTraits
{
	// Token: 0x06000223 RID: 547 RVA: 0x0000E604 File Offset: 0x0000C804
	public MonsterTraits()
	{
		this.name = new MonsterTraits.Name();
		this.bloodtype = new MonsterTraits.BloodType();
	}

	// Token: 0x04000211 RID: 529
	public MonsterTraits.Name name;

	// Token: 0x04000212 RID: 530
	public MonsterTraits.BloodType bloodtype;

	// Token: 0x0200003D RID: 61
	public class Name
	{
		// Token: 0x06000224 RID: 548 RVA: 0x0000E624 File Offset: 0x0000C824
		public Name()
		{
			this.firstname = MonsterTraits.Name.createFirstName();
			this.lastname = MonsterTraits.Name.createLastName();
		}

		// Token: 0x17000037 RID: 55
		// (get) Token: 0x06000226 RID: 550 RVA: 0x0000EC04 File Offset: 0x0000CE04
		public string fullname
		{
			get
			{
				return this.firstname + " " + this.lastname;
			}
		}

		// Token: 0x06000227 RID: 551 RVA: 0x0000EC1C File Offset: 0x0000CE1C
		public static string createFirstName()
		{
			return MonsterTraits.Name.possiblenames[UnityEngine.Random.Range(0, MonsterTraits.Name.possiblenames.Length)];
		}

		// Token: 0x06000228 RID: 552 RVA: 0x0000EC34 File Offset: 0x0000CE34
		public static string createLastName()
		{
			return MonsterTraits.Name.createFirstName();
		}

		// Token: 0x06000229 RID: 553 RVA: 0x0000EC3C File Offset: 0x0000CE3C
		public static string createFullName()
		{
			return MonsterTraits.Name.createFirstName() + " " + MonsterTraits.Name.createLastName();
		}

		// Token: 0x0600022A RID: 554 RVA: 0x0000EC54 File Offset: 0x0000CE54
		public static implicit operator string(MonsterTraits.Name name)
		{
			return name.fullname;
		}

		// Token: 0x04000213 RID: 531
		public static string[] possiblenames = new string[]
		{
			"Cave",
			"Robby",
			"Grape",
			"Isabel",
			"Pink",
			"Flip",
			"George",
			"Blue",
			"Berry",
			"Dust",
			"Pup",
			"Cave",
			"Rock",
			"Mobile",
			"Sand",
			"Tree",
			"Tim",
			"Trombone",
			"Drum",
			"Hour",
			"Sand",
			"Stick",
			"Burn",
			"Despair",
			"Carp",
			"Physics",
			"Blood",
			"H20",
			"Bubble",
			"Baby",
			"Crawl",
			"Knee",
			"Puddle",
			"Tussle",
			"Vanilla",
			"Salt",
			"Float",
			"Blood",
			"Fate",
			"Bones",
			"Under",
			"Drip",
			"Teeth",
			"Adil",
			"Adult",
			"Brick",
			"Scab",
			"Bucket",
			"Dunk",
			"Gems",
			"Crystal",
			"Rare",
			"Dirt",
			"Pet",
			"Diary",
			"Dusty",
			"Tea",
			"Hell",
			"Home",
			"Fish",
			"Dairy",
			"Rockin'",
			"Fall",
			"Legs",
			"Coat",
			"Boiled",
			"Fizzy",
			"King",
			"Dog",
			"Whiskey",
			"Cop",
			"Speed",
			"Hair",
			"Rolling",
			"Pod",
			"Champ",
			"Master",
			"Straw",
			"Wood",
			"Jr",
			"Sr",
			"Land",
			"Air",
			"Sea",
			"Jungle",
			"Dragon",
			"Chase",
			"Ocean",
			"Time",
			"Baby",
			"Swamp",
			"Bog",
			"Mud",
			"Dirt",
			"Grass",
			"Flower",
			"Food",
			"Soda",
			"Pop",
			"Milk",
			"Spike",
			"Sharp",
			"House",
			"Metal",
			"Evil",
			"Fresh",
			"Dribble",
			"Hill",
			"Quiz",
			"Justice",
			"Book",
			"Hook",
			"Spill",
			"Foot",
			"Shirt",
			"Red",
			"Eye",
			"Shock",
			"Scoop",
			"Jazz",
			"Bark",
			"Moss",
			"Net",
			"Slam",
			"Coyote",
			"Rash",
			"Lion",
			"Tiger",
			"Gym",
			"File",
			"Law",
			"Seal",
			"Flood",
			"Skull",
			"Wiz",
			"Double",
			"Wow",
			"Hanger",
			"Mist",
			"Pond",
			"Dude",
			"Lady",
			"Tent",
			"Ring",
			"Jelly",
			"Magic",
			"Glue",
			"Cat",
			"Pooch",
			"Jam",
			"Yell",
			"Junk",
			"Mold"
		};

		// Token: 0x04000214 RID: 532
		public string firstname;

		// Token: 0x04000215 RID: 533
		public string lastname;
	}

	// Token: 0x0200003E RID: 62
	public class Opinions
	{
		// Token: 0x0600022B RID: 555 RVA: 0x0000EC5C File Offset: 0x0000CE5C
		public Opinions()
		{
			this.likes = MonsterTraits.Opinions.createLikes();
			this.dislikes = MonsterTraits.Opinions.createLikes(this.likes);
		}

		// Token: 0x0600022D RID: 557 RVA: 0x0000FD60 File Offset: 0x0000DF60
		public static string GetRandomSubject()
		{
			return MonsterTraits.Opinions.subjects[UnityEngine.Random.Range(0, MonsterTraits.Opinions.subjects.Length)];
		}

		// Token: 0x0600022E RID: 558 RVA: 0x0000FD78 File Offset: 0x0000DF78
		public static string GetRandomAdjective()
		{
			return MonsterTraits.Opinions.adjectives[UnityEngine.Random.Range(0, MonsterTraits.Opinions.adjectives.Length)];
		}

		// Token: 0x0600022F RID: 559 RVA: 0x0000FD90 File Offset: 0x0000DF90
		public static string GetRandomPhrase()
		{
			string text = MonsterTraits.Opinions.phrases[UnityEngine.Random.Range(0, MonsterTraits.Opinions.phrases.Length)];
			return text.Replace("{subject}", MonsterTraits.Opinions.GetRandomSubject()).Replace("{adjective}", MonsterTraits.Opinions.GetRandomAdjective());
		}

		// Token: 0x06000230 RID: 560 RVA: 0x0000FDD4 File Offset: 0x0000DFD4
		public static string NewGetPossibleOpinion()
		{
			float num = (float)MonsterTraits.Opinions.phrases.Length / (float)MonsterTraits.Opinions.subjects.Length * 2f;
			if (UnityEngine.Random.value <= num)
			{
				return MonsterTraits.Opinions.GetRandomPhrase();
			}
			return MonsterTraits.Opinions.GetRandomAdjective() + " " + MonsterTraits.Opinions.GetRandomSubject();
		}

		// Token: 0x06000231 RID: 561 RVA: 0x0000FE20 File Offset: 0x0000E020
		public static string GetRandomOpinion()
		{
			return MonsterTraits.Opinions.possibleopinions[UnityEngine.Random.Range(0, MonsterTraits.Opinions.possibleopinions.Length)];
		}

		// Token: 0x06000232 RID: 562 RVA: 0x0000FE38 File Offset: 0x0000E038
		public static List<string> createLikes()
		{
			return MonsterTraits.Opinions.createLikes(new List<string>());
		}

		// Token: 0x06000233 RID: 563 RVA: 0x0000FE44 File Offset: 0x0000E044
		public static List<string> createLikes(List<string> ignorelist)
		{
			List<string> list = new List<string>();
			int num = UnityEngine.Random.Range(1, 4);
			for (int i = 0; i < num; i++)
			{
				string item = MonsterTraits.Opinions.possibleopinions[UnityEngine.Random.Range(0, MonsterTraits.Opinions.possibleopinions.Length)];
				if (!ignorelist.Contains(item))
				{
					list.Add(item);
					ignorelist.Add(item);
				}
			}
			return list;
		}

		// Token: 0x04000216 RID: 534
		public static readonly string[] subjects = new string[]
		{
			"Bugs",
			"Homework",
			"Taxes",
			"Ice Cream",
			"Ice",
			"Cream",
			"Sunsets",
			"Pups",
			"Itchy Skin",
			"Skin",
			"Summer Savings",
			"Savings",
			"Cleaning",
			"Fussin'",
			"Cheese",
			"Light",
			"Punk Music",
			"Punks",
			"Music",
			"Fast Cars",
			"Cars",
			"Red Objects",
			"Objects",
			"Shaking Hands",
			"Hands",
			"Mutual Respect",
			"Respect",
			"Healthy Diet",
			"Diet",
			"Underdogs",
			"Pipes",
			"Synergy",
			"Jungling",
			"Dinner Plans",
			"Plans",
			"Musical Tunes",
			"Tunes",
			"Trash",
			"Transparency",
			"Traveling",
			"Vacation",
			"Thanksgiving",
			"Heat",
			"Mondays",
			"TV Shows",
			"Shows",
			"Soft Drinks",
			"Drinks",
			"Fate",
			"Blue Eyes",
			"Eyes",
			"Ethnic Slurs",
			"Slurs",
			"Hard Work",
			"Work",
			"Charity",
			"Moon Beams",
			"Beams",
			"Yogurt",
			"Rocking Chairs",
			"Chairs",
			"Backup Plans",
			"Plans",
			"Emergency Exits",
			"Exits",
			"Threats",
			"Veggies",
			"Apples",
			"Oranges",
			"Bugs",
			"Defeat",
			"Slam Dunks",
			"Dunks",
			"Art",
			"Individuality",
			"Dining",
			"Math",
			"Spells",
			"Sticky Fingers",
			"Fingers",
			"Garbage",
			"Noses",
			"Glass Eyes",
			"Fancy Clothes",
			"Clothes",
			"Horror Movies",
			"Movies",
			"Folk Tales",
			"Tales",
			"Theory",
			"Swimming",
			"Shopping",
			"Scraping",
			"Spelunking",
			"Tiny Clues",
			"Clues",
			"Big Dogs",
			"Dogs",
			"Gamers",
			"Silence",
			"Depression",
			"Despair",
			"Pizza",
			"Rigs",
			"Chores",
			"Passion",
			"Illusions",
			"Rashes",
			"Warm Milk",
			"Milk",
			"Slides",
			"Kids",
			"Retirement",
			"Childhood",
			"Teens",
			"Parents",
			"Pop Quizes",
			"Quizes",
			"Grinding",
			"Drifting",
			"Leaves",
			"House Parties",
			"Parties",
			"Wigs",
			"Involuntary Solitude",
			"Solitude",
			"Bigshots",
			"Pooches",
			"Fun",
			"Holiday Memories",
			"Memories",
			"Tubs",
			"Youth",
			"Rad Tricks",
			"Tricks",
			"Elbow Grease",
			"Grease",
			"Pranks",
			"Silly Gags",
			"Gags",
			"Hijinks",
			"Lumber Yards",
			"Yards",
			"Graphic Novels",
			"Novels",
			"Video Games",
			"Games",
			"Videos",
			"Joyful Reunions",
			"Reunions",
			"Moolah",
			"Petting Zoos",
			"Zoos",
			"Spirited Debates",
			"Debates",
			"Ghosts",
			"Ancient Tech",
			"Tech",
			"Human Dogs",
			"Dogs",
			"Dirt",
			"Rural Myths",
			"Myths",
			"Aspect Ratios",
			"Ratios",
			"Outdoor Flames",
			"Flames",
			"Fires",
			"Tropical Sunsets",
			"Sunsets",
			"Risky Trails",
			"Trails",
			"Undiscovered Flora",
			"Flora",
			"Movie Magic",
			"Magic",
			"Howling Tundras",
			"Tundras",
			"Regret",
			"Ruined Birthdays",
			"Birthdays",
			"Anarchy",
			"Anarchy",
			"Chaos",
			"Rivers And Mud",
			"Friendships",
			"Reptialian Monarchies",
			"Monarchies",
			"Cats",
			"Aggressive Jokes",
			"Jokes",
			"Cooking",
			"Phantoms",
			"Dealings",
			"Sleuthing",
			"Exotic Pets",
			"Pets",
			"Space Movies",
			"Movies",
			"Docs"
		};

		// Token: 0x04000217 RID: 535
		public static readonly string[] adjectives = new string[]
		{
			"Ice",
			"Light",
			"Fast",
			"Red",
			"Shaking",
			"Healthy",
			"Musical",
			"TV",
			"Soft",
			"Blue",
			"Ethnic",
			"Hard",
			"Windy",
			"Rocking",
			"Backup",
			"Very Small",
			"Slam",
			"Ancient",
			"Sticky",
			"Glass",
			"Fancy",
			"Horror",
			"Folk",
			"Itchy",
			"Tiny",
			"Big",
			"Fantastic",
			"Warm",
			"Autumn",
			"House",
			"Involuntary",
			"Fun",
			"Fun Loving",
			"Loving",
			"Holiday",
			"Rad",
			"Great",
			"Joke",
			"Prank",
			"Silly",
			"Wacky",
			"Lumber",
			"Eternal",
			"Graphic",
			"Novel",
			"Video",
			"Joyful",
			"Pet",
			"Spirited",
			"Ancient",
			"Human",
			"Rural",
			"Urban",
			"Outdoor",
			"Big",
			"Tropical",
			"Risky",
			"Movie",
			"Howling",
			"Ruined",
			"Total",
			"Absolute",
			"Reptilian",
			"Aggressive",
			"Shady",
			"Exotic",
			"Space",
			"Dreary",
			"Animal",
			"Internal",
			"Dank",
			"Moldy"
		};

		// Token: 0x04000218 RID: 536
		public static readonly string[] phrases = new string[]
		{
			"Losin' the {subject}",
			"Growing Up {adjective}",
			"Typin' Up {adjective} Drafts",
			"Rolling in {subject}",
			"Buttoning Up",
			"Crying Alone",
			"Rollin' Around",
			"The {adjective} Autumn Breeze",
			"The {adjective} Breeze",
			"The Big Bucks",
			"Diggin' Up {subject}",
			"Gasping For Breath",
			"The Spirit Of Anarchy",
			"The Spirit Of {subject}",
			"Canceling {adjective} Friendships",
			"The {subject} Man",
			"The {adjective} Man",
			"Fun Loving Pooches",
			"Sleuthing Around"
		};

		// Token: 0x04000219 RID: 537
		public static readonly string[] possibleopinions = new string[]
		{
			"Bugs",
			"Homework",
			"Taxes",
			"Ice Cream",
			"Sunsets",
			"Pups",
			"Itchy Skin",
			"Summer Savings",
			"Spring Cleaning",
			"Fussin'",
			"String Cheese",
			"Light",
			"Punk Music",
			"Fast Cars",
			"Red Objects",
			"Shaking Hands",
			"Mutual Respect",
			"Healthy Diet",
			"Underdogs",
			"Pipes",
			"Synergy",
			"Jungling",
			"Dinner Plans",
			"Losin' the Keys",
			"Musical Tunes",
			"Trash",
			"Transparency",
			"Traveling",
			"Vacation",
			"Thanksgiving",
			"Buttoning Up",
			"Heat",
			"Mondays",
			"TV Shows",
			"Soft Drink",
			"Fate",
			"Blue Eyes",
			"Ethnic Slurs",
			"Crying Alone",
			"Hard Work",
			"Charity",
			"Windy Conditions",
			"Moon Beams",
			"Yogurt",
			"Rocking Chairs",
			"Backup Plans",
			"Emergency Exits",
			"Threats",
			"Veggies",
			"Apples",
			"Oranges",
			"Very Small Bugs",
			"Losing",
			"Slam Dunks",
			"Art",
			"Individuality",
			"Rollin' Around",
			"Dining Alone",
			"Math",
			"Ancient Spells",
			"Sticky Fingers",
			"Garbage",
			"Noses",
			"Glass Eyes",
			"Fancy Clothes",
			"Horror Movies",
			"Folk Tales",
			"Color Theory",
			"Swimming",
			"Shopping",
			"Scraping",
			"Spelunking",
			"Tiny Clues",
			"Big Dogs",
			"Gamers",
			"Silence",
			"Depression",
			"Despair",
			"Pizza",
			"Gaming Rigs",
			"Chores",
			"Passion",
			"Fantastic Illusions",
			"Rashes",
			"Warm Milk",
			"Slides",
			"Kids",
			"Growing Up",
			"Retirement",
			"Middle Age",
			"Childhood",
			"Teens",
			"Parents",
			"Pop Quizes",
			"Grinding",
			"Drifting",
			"Typin' Up Drafts",
			"Rolling in Leaves",
			"The Autumn Breeze",
			"House Parties",
			"Wigs",
			"Involuntary Solitude",
			"Bigshots",
			"Fun Loving Pooches",
			"Holiday Memories",
			"Tubs",
			"Youth",
			"Rad Tricks",
			"Elbow Grease",
			"Great Pranks",
			"Silly Gags",
			"Wacky Hijinks",
			"Lumber Yards",
			"Graphic Novels",
			"Video Games",
			"Joyful Reunions",
			"Moolah",
			"The Big Bucks",
			"Petting Zoos",
			"Spirited Debates",
			"Ghosts",
			"Ancient Tech",
			"Human Dogs",
			"Diggin' Up Dirt",
			"Rural Myths",
			"Aspect Ratios",
			"Outdoor Flames",
			"Big Fires",
			"Tropical Sunsets",
			"Risky Trails",
			"Undiscovered Flora",
			"Movie Magic",
			"Howling Tundras",
			"Regret",
			"Gasping For Breath",
			"Ruined Birthdays",
			"Total Anarchy",
			"Absolute Chaos",
			"Rivers And Mud",
			"The Spirit Of Anarchy",
			"Canceling Friendships",
			"Reptialian Monarchies",
			"Cats",
			"The Bird Man",
			"Aggressive Jokes",
			"Cooking",
			"Phantoms",
			"Shady Dealings",
			"Sleuthing Around",
			"Exotic Pets",
			"Space Movies",
			"Dreary Docs"
		};

		// Token: 0x0400021A RID: 538
		public List<string> likes;

		// Token: 0x0400021B RID: 539
		public List<string> dislikes;
	}

	// Token: 0x0200003F RID: 63
	public class BloodType
	{
		// Token: 0x06000234 RID: 564 RVA: 0x0000FEA0 File Offset: 0x0000E0A0
		public BloodType()
		{
			this.typename = MonsterTraits.BloodType.Generate();
		}

		// Token: 0x06000236 RID: 566 RVA: 0x0000FEF4 File Offset: 0x0000E0F4
		private static string Generate()
		{
			return MonsterTraits.BloodType.bloodtypes[UnityEngine.Random.Range(0, MonsterTraits.BloodType.bloodtypes.Length)];
		}

		// Token: 0x06000237 RID: 567 RVA: 0x0000FF0C File Offset: 0x0000E10C
		public static implicit operator string(MonsterTraits.BloodType bloodtype)
		{
			return bloodtype.typename;
		}

		// Token: 0x0400021C RID: 540
		private static string[] bloodtypes = new string[]
		{
			"burger",
			"cake",
			"cupcake",
			"hotdog",
			"pizza",
			"soda"
		};

		// Token: 0x0400021D RID: 541
		public string typename;
	}
}
