#define forex(%0,%1) for(new %0 = 0; %0 < %1; %0++)
#define IsNull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#define RGBAToInt(%0,%1,%2,%3) ((16777216 * (%0)) + (65536 * (%1)) + (256 * (%2)) + (%3))
#define SEM(%0,%1) SendClientMessage(%0,0xBFC0C200,%1)
#define Pressed(%0) ((newkeys & %0) && !(oldkeys & %0))
#define Holding(%0) ((newkeys & (%0)) == (%0))
#define Released(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define strToLower(%0) \
    for(new i; %0[i] != EOS; ++i) \
        %0[i] = ('A' <= %0[i] <= 'Z') ? (%0[i] += 'a' - 'A') : (%0[i])
#define function%0(%1) \
        forward%0(%1); public%0(%1)


#define MYSQL_HOST      	"localhost"
#define MYSQL_USER      	"gta"
#define MYSQL_PASSWORD  	""
#define MYSQL_DATABASE  	"gta_dayz"

#define MAX_INVENTORY_SLOT  (36)
#define MAX_ZOMBIES			(5000)
#define MAX_ZOMBIE_NODE		(100)
#define MAX_DROPS           (2500)
#define MAX_PLAYER_DROPS    (5000)
#define MAX_DEAD_BODIES		(2000)
#define MAX_MOTIVE			(2000)
#define TOTAL_ITEMS         (41)
#define ZOMBIE_SPEED    	(6.5)
#define ZOMBIE_DETECTION	(40.0)

#define DEBUG_KILLS         (1)
#define DEBUG_MURDERS       (2)
#define DEBUG_BLOOD         (3)
#define DEBUG_TEMPERATURE   (4)
#define DEBUG_WEAPON        (5)
#define DEBUG_AMMO			(6)

#define INDICATOR_HUNGER    (1)
#define INDICATOR_THIRST    (2)
#define INDICATOR_BLOOD     (3)
#define INDICATOR_NOISE		(4)

#define BAG_SMALL           (1) // 6 slots
#define BAG_MEDIUM          (2) // 12 slots
#define BAG_LARGE           (3) // 24 slots
#define BAG_HUGE            (4) // 36 slots

#define AREA_TYPE_DROP      	(1)
#define AREA_TYPE_PLAYER_DROP   (2)
#define AREA_TYPE_VEHICLE		(3)
#define AREA_TYPE_BODY			(4)
#define AREA_TYPE_ZOMBIE_FAR	(5)
#define AREA_TYPE_ZOMBIE_NEAR	(6)

#define WEAPON_PRIMARY      (0)
#define WEAPON_SECONDARY    (1)
#define WEAPON_MELEE        (2)

#define ITEM_NONE           (0)
#define ITEM_BEANS			(1)
#define ITEM_PIZZA          (2)
#define ITEM_HOTDOG         (3)
#define ITEM_BOTTLE_EMPTY   (4)
#define ITEM_BOTTLE_FULL    (5)
#define ITEM_SODA           (6)
#define ITEM_BEER           (7)
#define ITEM_BANDAGE        (8)
#define ITEM_MORPHINE       (9)
#define ITEM_BLOOD_BAG      (10)
#define ITEM_HEATPACK		(11)
#define ITEM_ENGINE         (12)
#define ITEM_TIRE           (13)
#define ITEM_TOOLBOX        (14)
#define ITEM_MAP            (15)
#define ITEM_GPS            (16)
#define ITEM_RADIO          (17)
#define ITEM_BATTERY        (18)
#define ITEM_BASEBALL       (19)
#define ITEM_KATANA         (20)
#define ITEM_PISTOL         (21)
#define ITEM_SILENT_PISTOL  (22)
#define ITEM_SMG            (23)
#define ITEM_SHOTGUN        (24)
#define ITEM_SPAS           (25)
#define ITEM_RIFLE          (26)
#define ITEM_SNIPER         (27)
#define ITEM_AK47           (28)
#define ITEM_M4             (29)
#define ITEM_PISTOL_AMMO    (30)
#define ITEM_SMG_AMMO       (31)
#define ITEM_SHOTGUN_AMMO   (32)
#define ITEM_RIFLE_AMMO     (33)
#define ITEM_ASSAULT_AMMO   (34)
#define ITEM_BAG_SMALL      (35)
#define ITEM_BAG_MEDIUM     (36)
#define ITEM_BAG_LARGE      (37)
#define ITEM_BAG_HUGE       (38)
#define ITEM_GASCAN_EMPTY   (39)
#define ITEM_GASCAN_FULL    (40)

#define DIALOG_REGISTER     		(1)
#define DIALOG_LOGIN        		(2)
#define DIALOG_CHOOSE_GENDER    	(3)
#define DIALOG_INVENTORY_SHOW		(4)
#define DIALOG_INVENTORY_ACTION 	(5)
#define DIALOG_DROP_FOUND       	(6)
#define DIALOG_PLAYER_DROP_FOUND    (7)
#define DIALOG_VEHICLE_MAIN			(8)
#define DIALOG_VEHICLE_ACTION		(9)
#define DIALOG_VEHICLE_STORAGE_MENU	(10)
#define DIALOG_VEHICLE_STORAGE_GIVE	(11)
#define DIALOG_VEHICLE_STORAGE_TAKE	(12)
#define DIALOG_BODY_MENU			(13)
#define DIALOG_BODY_LOOT			(14)
#define DIALOG_ZOMBIE_LOOT			(15)
#define DIALOG_UNEQUIP_WARN			(16)
#define DIALOG_UNEQUIP_OPTION		(17)

#define COLOR_DARKPURPLE 	0xD900D300
#define COLOR_YAKUZA 		0x212121AA
#define TEAM_MONEY_COLOR 	0xFF00AAFF
#define COLOR_NEWB 			0x99CCFFAA
#define TEAM_RUGGED_COLOR 	0x000066FF
#define TEAM_BEARS_COLOR 	0x660022FF
#define COLOR_LIME 			0x33FF00AA
#define COLOR_SAMP 			0xA9C4E400
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C200
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_CORLEONE 		0x212121AA
#define COLOR_CYAN 			0x00FFFF00
#define COLOR_PISS 			0xFFFFCCAA
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_BLACK 		0x000000FF
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_NATGUARD 		0x00330000
#define COLOR_RED 			0xFF000000
#define COLOR_REDMARKER 	0xFF0000FF
#define COLOR_BACKUP 		0x00FF00FF
#define COLOR_TESTARED 		0xFF4040FF
#define COLOR_LIGHTRED 		0xFF6347AA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN 	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF0000
#define COLOR_MECH 			0x75AE5D00
#define COLOR_YELLOW2 		0xF5DEB3AA
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_FADE5 		0x6E6E6E6E
#define COLOR_PURPLE 		0xC2A2DAFF
#define COLOR_DBLUE 		0x2641FE00
#define COLOR_SASD 			0x9C721300
#define COLOR_ALLDEPT 		0xFFCC33AA
#define COLOR_NEWS 			0xFFA50000
#define COLOR_OOC 			0xE0FFFFAA
#define COLOR_GCHAT 		0x33BB44FF
#define COLOR_WT 			0x75AE5DFF
#define ZONE_NONE 			0x00000069
#define ZONE_WHITE 			0xFFFFFFB6
#define ZONE_BLACK 			0x000000C2
#define ZONE_RED 			0xFF0000AA
#define ZONE_YELLOW 		0xAEE70092
#define ZONE_GREEN 			0x00A60092
#define ZONE_BLUE 			0x0000FF8E
#define ZONE_PURPLE 		0x9600FF8E
#define ZONE_ORANGE 		0xFF6D00A2
#define ZONE_CYAN 			0x00A2FF82
#define ZONE_BROWN 			0x994100A6
#define ZONE_PINK 			0xFF00FF86
#define ZONE_SKIN 			0xFFC67DBA
#define OBJECTIVE_COLOR 	0x64000064
#define TEAM_GREEN_COLOR 	0xFFFFFFAA
#define TEAM_JOB_COLOR 		0xFFB6C1AA
#define TEAM_HIT_COLOR 		0xFFFFFF00
#define TEAM_BLUE_COLOR 	0x8D8DFF00
#define COLOR_ADD 			0x63FF60AA
#define TEAM_GROVE_COLOR 	0x00D900C8
#define TEAM_VAGOS_COLOR 	0xFFC801C8
#define TEAM_BALLAS_COLOR 	0xD900D3C8
#define TEAM_AZTECAS_COLOR 	0x01FCFFC8
#define TEAM_CYAN_COLOR 	0xFF828200
#define TEAM_ORANGE_COLOR 	0xFF830000
#define TEAM_COR_COLOR 		0x39393900
#define TEAM_BAR_COLOR 		0x00D90000
#define TEAM_TAT_COLOR 		0xBDCB9200
#define TEAM_CUN_COLOR 		0xD900D300
#define TEAM_STR_COLOR 		0x01FCFF00
#define TEAM_ADMIN_COLOR 	0x00808000
#define COLOR_INVIS 		0xAFAFAF00
#define COLOR_SPEC 			0xBFC0C200
#define GREEN 				0x21DD00FF
#define RED 				0xE60000FF
#define ADMIN_RED 			0xFB0000FF
#define YELLOW 				0xFFFF00FF
#define ORANGE 				0xF97804FF
#define LIGHTRED 			0xFF8080FF
#define LIGHTBLUE 			0x00C2ECFF
#define PURPLE 				0xB360FDFF
#define PLAYER_COLOR 		0xFFFFFFFF
#define BLUE 				0x1229FAFF
#define LIGHTGREEN 			0x38FF06FF
#define DARKPINK 			0xE100E1FF
#define DARKGREEN 			0x008040FF
#define ANNOUNCEMENT 		0x6AF7E1FF
#define COLOR_SYSTEM 		0xEFEFF7AA
#define GREY 				0xCECECEFF
#define PINK 				0xD52DFFFF
#define DARKGREY 			0x626262FF
#define AQUAGREEN 			0x03D687FF
#define NICESKY 			0x99FFFFAA
#define WHITE 				0xFFFFFFFF