EU3 Savegame structure
======================

Taken from my "England1399_10_14.eu3" file - game started as England; saved without unpausing

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
    - Various other information
- Armies (multiples)
- Relations (multiples)
- Leaders (multiples)
- Footer

need to verify REB is same layout as regulars (like Sweden)

Example (Sweden, starts at line 84257)

REB - 80796 - 82328