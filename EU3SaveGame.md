EU3 Savegame structure
======================
Taken from my "England1399_10_14.eu3" file - game started as England; saved without unpausing

### Table of Contents
**[Header](#header)**  
**[Rebel Faction Info](#rebel-faction-info)**  
**[Imperial Information](#imperial-information)**  
**[Religious Faction Information](#religious-faction-information)**  
**[Papacy Information](#papacy-information)**  
**[Trade](#trade)**  
**[Province Information](#province-information)**  
**[Nation Information](#nation-information)**  
**[Diplomacy](#diplomacy)**  
**[Combat](#combat)**  
**[Active Wars](#active-wars)**  
**[Previous Wars](#previous-wars)**  
**[Footer A](#footer-a)**  
**[Japanese Stuff](#japanese-stuff)**  
**[Footer B](#footer-b)**  

Header
------
~23 lines

Entirety:

    date="1399.10.14"
    player="ENG"
    monarch=6840
    cardinal=16
    leader=1184
    advisor=1889
    rebel=41
    unit=1589
    flags=
    {
    }
    gameplaysettings=
    {
      setgameplayoptions=
      {
    0 0 0 0 0 0 0 2 0 1 0 0 0   }
    }
    start_date="1399.10.14"
    id=
    {
      id=3001
      type=4713
    }

Rebel Faction Info
------------------
Each ~35 lines (starts at line 24)

Example (in its entirety), can have multiple entries:

    rebel_faction=
    {
        id=
        {
            id=1
            type=40
        }
        type="nationalist_rebels"
        name="Smolenskian Nationalists"
        heretic="Old Believer"
        country="LIT"
        independence="SMO"
        culture="russian"
        religion="orthodox"
        government="feudal_monarchy"
        province=293
        leader=
        {
            id=1181
            type=38
        }
        army=
        {
            id=2
            type=40
        }
        army=
        {
            id=21
            type=40
        }
        provinces=
        {
            293 297     }
    }

Imperial Information
--------------------
~8 lines, (starts at line 89)

Entirety:

    emperor="HUN"
    imperial_influence=20.000
    internal_hre_cb=yes
    old_emperor=
    {
        id=2338
        country="HUN"
        date="1387.3.31"
    }

Religious Faction Information
-----------------------------
~35 lines, (starts at line 98)

Example, several entries:

    protestant=
    {
    }

Papacy Information
------------------
~ 170 lines (starts at line 137)

- Is comprised of a header, then specific cardinal information (see below)

Header:

    papacy=
    {
        controller="HUN"
        crusade_target="---"
        crusade_start="1.1.1"
        last_excom="1.1.1"
        papacy_active=yes
        // Followed cardinal information, multiple entries
    }

#### Cardinal Entries
Same indentation as "papacy_active" above

Example:

        cardinal=
            {
                name="Alvinczy"
                location=156
                controller="TRA"
                id=
                {
                    id=1
                    type=42
                }
            }

Trade
-----
~ 1400 lines (starts at line 310)

- Comprised entirely of cot brackets (Center of Trade)

Example:

    trade=
    {
        // multiple cot entries; see below)
    }

#### COT entry
~130 lines each

Contains:
- Header (~4 lines)
- Nation information (multiples) (~7 lines)

Example of header and ONE nation information (from line 312)

        cot=
            {
                location=101
                stagnation=0.000
                value=585.133
                level=18
                ACH=
                {
                    level=1
                    value=7.284
                    priority=0
                    control=0.000
                }     
                // And many more           
            }

Province Information
--------------------
~80,000 lines total (starts at line 1699, Provinces #1-1882

Consists of:

- Header
- History

Parent example:

    1=
    {
        // Header (see below)
        // History (see below)
        // Footer & discovery information
    }

#### Header Example:

    flags=
    {
    }
    variables=
    {
    }
    name="Stockholm"
    owner="SWE"
    controller="SWE"
    core="SWE"
    culture=swedish
    religion=catholic
    capital="Stockholm"
    citysize=5504.583
    garrison=1000.000
    base_tax=5.000
    manpower=3.000
    trade_goods=grain
    temple=yes
    barracks=yes
    drydock=yes
    workshop=yes
    marketplace=yes
    fort1=yes

#### History Example
Has its own header, then advisor information

    history=
    {
       // header
       // multiple advisors
    }
    
###### History header:

        add_core="SWE"
        owner="SWE"
        controller="SWE"
        culture=swedish
        religion=catholic
        hre=no
        base_tax=5.000
        trade_goods=grain
        manpower=3.000
        fort1=yes
        capital="Stockholm"
        citysize=5500.000
        temple=yes
        workshop=yes
        marketplace=yes
        discovered_by="eastern"
        discovered_by="western"
        discovered_by="muslim"
        discovered_by="ottoman"

###### Advisor information (one of multiples)

        1399.10.14=
        {
            advisor=
            {
                name="Fredrik Adolf Åkerhielm"
                type=high_judge
                skill=1
                location=1
                home="SWE"
                date="1399.10.14"
                hire_date="1.1.1"
                move=0
                id=
                {
                    id=1301
                    type=39
                }
            }
        }

#### Footer & Discovery information

Base indentation for discovery information

        patrol=0
    discovery_dates={9999.1.1 9999.1.1 1.1.1 1.1.1 1.1.1 1.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 }
    discovery_religion_dates={9999.1.1 1399.10.14 9999.1.1 9999.1.1 1399.10.14 1399.10.14 1399.10.14 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 }
    discovered_by={SWE DAN NOR SHL ACH BOS BYZ CEP CYP EPI KNI MOL MON NAX RAG SER TRA WAL HUN TUR CNN ENG LEI MNS SCO TYR LIT MAZ POL RIG TEU ALE ALS AMG AUV AVI BOU BRI BUR FOI FRA ORL PRO BER AAC ANH ANS AUG BAD BAV BOH BRA BRE BRU FRN HAB HES KLE KOL LAU LOR LUN MAG MAI MEI MKL MUN OLD PAL POM SAX SIL SLZ SWI THU TRI ULM WBG WUR ARA CAS GRA NAV POR AQU FER GEN MAN MLO MOD NAP PAP SAR SAV SIC TUS URB VEN BRB FRI GEL HAI HOL LIE LUX UTR GEO MOS NOV PSK RYA TVE YAR ADE ALH OMA NAJ HED CND DUL KAR TRE RAM ALG MAM MOR TRP TUN JAI BAR HSA }
        winter=1

Nation Information
------------------
(starts at line 80,796)

Consists of:

- Header (this is really complicated, should break it out further)
    - History
    - Flags
    - Hidden flags
    - Variables
    - Assorted Information
        - Capital
        - Technology
        - Income
        - Etc.
    - Distribution
    - Ledger
    - Various other information (officials, sliders, etc.)
- Mercenary (multiples)
- Army (multiples)
- Navy (multiples)
- Relations (multiples)
- Footer (this is also complicated; hard to find a pattern right now)
    - Leaders (multiples)
    - More trade stuff?

Example (see the save file - Sweden, starts at line 84257)

Diplomacy
---------
(starts at line 525446)

- Casus belli (multiple)
- Open markets (multiple)

Example:

    diplomacy=
    {
        casus_belli=
        {
            type="cb_primitives"
            first="SWE"
            second="IRO"
            start_date="1820.12.31"
        }
        open_market=
        {
            first="SWE"
            second="DAN"
            start_date="1.1.1"
        }
    }

Combat
------
line 735835

Entirety:

    combat=
    {
    }

Active Wars
-----------

Example:

    active_war=
    {
        name="Golden Horde-Genoese War"
        history=
        {
            1499.10.14=
            {
                rem_attacker="GOL"
            }
        }
        defender="GEN"
        original_attacker="GOL"
        original_defender="GEN"
        action="1399.10.14"
    }

Previous Wars
-------------

Example:

    previous_war=
    {
        name="First Muscovite-Lithuanian War"
        history=
        {
            name="First Muscovite-Lithuanian War"
            casus_belli="cb_nationalist"
            name="GOL - NOV war"
            casus_belli="cb_dishonored_call"
            name="Ming - Horde war"
            casus_belli="cb_dishonored_call"
            1399.1.1=
            {
                add_attacker="GOL"
                add_defender="NOV"
            }
            1399.1.1=
            {
                add_attacker="KHA"
                add_attacker="OIR"
                add_defender="MNG"
            }
            1399.10.14=
            {
                rem_attacker="GOL"
                rem_defender="NOV"
            }
            1399.10.14=
            {
                rem_attacker="KHA"
                rem_attacker="OIR"
                rem_defender="MNG"
            }
            1486.1.1=
            {
                add_attacker="MOS"
                add_defender="LIT"
            }
            1492.1.1=
            {
                add_attacker="CRI"
            }
            1495.1.1=
            {
                rem_attacker="MOS"
                rem_attacker="CRI"
                rem_defender="LIT"
            }
        }
        original_attacker="GOL"
        original_defender="NOV"
        action="1.1.1"
        casus_belli="cb_nationalist"
    }

Footer A
-------------

Entirety:

    income_statistics=
    {
    }
    nation_size_statistics=
    {
    }
    inflation_statistics=
    {
    }

Japanese Stuff
--------------

Entirety:

    shogun=
    {
        shogun=16.000
        emperor=
        {
            status=0
            emperor=1
            back_kampaku=0
            active=1
            country="JAP"
        }
        daimyo=
        {
            status=3
            emperor=0
            back_kampaku=0
            active=1
            country="MIN"
        }
        daimyo=
        {
            status=0
            emperor=0
            back_kampaku=0
            active=1
            country="TAC"
        }
        daimyo=
        {
            status=0
            emperor=0
            back_kampaku=0
            active=1
            country="FUJ"
        }
        daimyo=
        {
            status=0
            emperor=0
            back_kampaku=0
            active=1
            country="TAI"
        }
    }

Footer B
------

Entirety:

    nr="BUILD_TO_FORCELIMIT"
    nr="PURE_CAPITALISM"
    nr="CONQUER_AZTECS_INCAS"
    nr="TEN_THOUSAND_KILLED"
    nr="ALL_ABOUT_THE_MONEY"
    nr="RESPECTED"
    nr="TRUE_CATHOLIC"
    nr="TRULY_DIVINE_RULER"
    nr="CONTROL_CARRIBEAN"
    nr="MASTER_OF_INDIA"
    nr="INVINCIBLE_ARMIES"
    nr="THE_WOODEN_WALL"
    nr="WORLD_DISCOVERER"
    nr="MARKET_CONTROL"
    nr="INVINCIBLE_NAVY"
    nr="ALL_ABOUT_LUCK"
    nr="TRADITIONAL_PLAYER"
    nr="AT_EVERY_CONTINENT"
    nr="REGENCY_WAR"
    nr="EAST_AND_WEST"
    nr="FIVE_MONOPOLIES"
    nr="CONQUER_THE_WORLD"
    nr="UNITE_THE_EMPIRE"
    nr="CAN_HE_BE_TRUSTED"
    }
    0ba0c155e640ef169a8d12c64def5045