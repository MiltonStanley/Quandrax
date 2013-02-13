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

Example of header and ONE nation information:

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