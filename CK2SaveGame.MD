CK2 Savegame structure
======================

Taken from my "WilliamBeginning.ckd" file - game started as Duke William of Normandy; saved without unpausing

Header
------
~15 lines (starts at line 1)

Example:

    version="CK2 v1.06b"
    date="1066.9.15"
    player=
    {
      id=140
      type=45
    }
    player_realm="d_normandy"
    rebel=1
    unit=54
    sub_unit=107
    start_date="1066.9.15"
    flags=
    {
    }

Dynasties
---------
~120,000 lines (starts at line 16)

Example:

      2000011=
      {
        name="Gårdske"
        culture="swedish"
        coat_of_arms=
        {
          data=
          {
    1 0 8 13 2 11 10 0 8 13 2 11 10       }
          religion_group="none"
        }
        decadence=0.00000
      }

Characters
----------
~ lines (starts at line 116938)