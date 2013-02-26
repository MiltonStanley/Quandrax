CK2 Savegame structure
======================
Taken from my "WilliamBeginning.ck2" file - game started as Duke William of Normandy; saved without unpausing, and adjusted with a later-game file.

### Table of Contents
**[Header](#header)**  
**[Dynasties](#dynasties)**  
**[Characters](#characters)**  
**[ID Info](#id-info)**  
**[Religious Authority Info](#religious-authority-info)**  
**[Province Info](#province-info)**  
**[Title Info](#title-info)**  
**[Diplomacy](#diplomacy)**  
**[Combat](#combat)**  
**[War](#war)**  
**[Active Wars](#active-wars)**  
**[Footer](#footer)**  

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
~455000 lines (starts at line 116938)

Example:

    20662=
      {
        birth_name="Durgulel"
        historical=yes
        birth_date="992.1.1"
        father=41592
        attributes=
        {
    4 7 4 5 6     }
        fertility=0.500
        health=5.000
        traits=
        {
    19 74 95 85 101     }
        prestige=30.000
        piety=15.000
        religion="orthodox"
        culture="alan"
        dynasty=100603
        dna="pxkdqhmcxwr"
        properties="0b0did0000"
        demesne=
        {
          capital="b_vovnushki"
        }
        wealth=63.72162
        employer=20662
        host=20662
        estimated_monthly_income=1.86081
        estimated_yearly_income=22.32971
        estimated_yearly_peacetime_income=24.60974
        averaged_income=1.86081
        ledger=
        {
          income=
          {
            1.57330 1.04712 0.00000 1.10120 0.00000 0.00000 0.00000 
          }
          lastmonthincometable=
          {
            0.78665 0.52356 0.00000 0.55060 0.00000 0.00000 0.00000 
          }
          lastmonthincome=1.86081
        }
        ai=
        {
          initialized=yes
          consolidate=yes
          date="1066.9.15"
          static=no
          wanted_title=
          {
            id="c_sarpa"
            value=200
          }
          ally=
          {
            id=1732
            value=400
          }
          ally=
          {
            id=628
            value=65
          }
          ally=
          {
            id=41304
            value=56
          }
          ally=
          {
            id=9952
            value=26
          }
          ally=
          {
            id=670
            value=11
          }
          enemy=
          {
            id=806
            value=290
          }
          enemy=
          {
            id=93022
            value=125
          }
          enemy=
          {
            id=41515
            value=80
          }
          enemy=
          {
            id=9952
            value=60
          }
          enemy=
          {
            id=93089
            value=50
          }
          enemy=
          {
            id=3040
            value=40
          }
        }
        tech_focus=
        {
    0 8 16    }
      }

ID Info
--------------------
~5 lines (starts at line 571941)

Example:

    id=
    {
      id=2376
      type=4713
    }

Religious Authority Info
---------------------
~100 lines (starts at line 571946)

Example:

    catholic=
    {
      authority=0.501
    }

Province Info
-------------
~81,000 lines (starts at line 572042)

Example:

    1=
    {
      name="Vestisland"
      culture=norwegian
      religion=catholic
      max_settlements=2
      b_reykjavik=
      {
        type=castle
        date="1.1.1"
        build_time="1.1.1"
        levy=
        {
          light_infantry=
          {
            120 120 
          }
          heavy_infantry=
          {
            300 300 
          }
          light_cavalry=
          {
            30 30 
          }
          galleys=
          {
            3 3 
          }
        }
      }
      b_alftanes=
      {
        type=city
        date="1.1.1"
        build_time="1.1.1"
        ct_wall_1=yes
        levy=
        {
          light_infantry=
          {
            151 151 
          }
          archers=
          {
            81 81 
          }
          galleys=
          {
            5 5 
          }
        }
      }
      title="c_vestisland"
      technology=
      {
        level=
        {
    0 1 1 0 0 1 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 0 1 0     }
        progress=
        {
    9 2 0 5 8 4 5 5 6 6 9 9 6 9 2 3 1 6 5 5 9 6 4 5     }
      }
    }

Title Info
----------
~110,000 lines (starts at 653141)
These are nested by de jure liege; Empire top level, then king, duke, count, baron, etc.

Examples (skipping edge cases rebels/pirates, religious heads, mercs):

HRE (line 656310) is odd, as it has election results, etc.

King of Frisia (pretty standard):

    k_frisia=
    {
      succession=gavelkind
      gender=agnatic
      law="agnatic_succession"
      law="centralization_0"
      law="feudal_contract_2"
      law="feudal_tax_0"
      law="city_contract_1"
      law="city_tax_1"
      law="temple_contract_1"
      law="temple_tax_1"
      coat_of_arms=
      {
        data=
        {
    3 2 0 7 10 0 14 2 0 7 10 0 14 2 0 7 10 0 14 2 0 7 10 0 14     }
        religion_group="none"
      }
      last_change="775.1.1"
      previous=
      {
    131727 131725 131726 131728 131729 131730   }
      history=
      {
        646.1.1=
        {
          holder=131727
        }
        680.1.1=
        {
          holder=131725
        }
        719.1.1=
        {
          holder=131726
        }
        734.1.1=
        {
          holder=131728
        }
        741.1.1=
        {
          holder=131729
        }
        760.1.1=
        {
          holder=131730
        }
        775.1.1=
        {
          holder="0"
        }
      }
      de_jure_liege="e_hre"
      active=yes
    }

Diplomacy
---------
~3 lines (starts on line 761942)

Example:

    diplomacy=
    {
    }

Combat
------
starts on line 761945

Example in its entirety:

    combat=
    {
      siege_combat=
      {
        attackers=102531
        attackers=500607
        attackers=500608
        attackers=124
        location=57
        day=-1
        attacker=
        {
          unit=
          {
            id=6
            type=41
          }
          flank_center=
          {
            leader=102531
            last_leader=102531
            losses=
            {
              light_infantry=
              {
                0 2579 
              }
              heavy_infantry=
              {
                0 5095 
              }
              light_cavalry=
              {
                0 484 
              }
              archers=
              {
                0 362 
              }
            }
            target=1
            sub_unit=
            {
    14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43         }
            tactic_day=0
            phase=0
          }
        }
        defender=
        {
          flank_center=
          {
            leader=5660
            last_leader=5660
            losses=
            {
              light_infantry=
              {
                0 108 
              }
              heavy_infantry=
              {
                0 270 
              }
              light_cavalry=
              {
                0 27 
              }
              galleys=
              {
                0 3 
              }
            }
            target=1
            tactic_day=0
            phase=0
          }
        }
        event=1
      }
    }

War
---
Starts on line 762026
Total example:

    war=
    {
      name=""
      history=
      {
      }
    }

Active Wars
-----------------------------
Several entries

Example (starts on line 762066):

    active_war=
    {
      name="Norman Conquest"
      attacker=140
      defender=122
      casus_belli=
      {
        casus_belli="invasion"
        actor=140
        recipient=122
        landed_title="k_england"
        date="1066.9.10"
      }
      history=
      {
        name="Norman Conquest"
        1066.9.10=
        {
          add_attacker=140
          add_defender=122
        }
      }
      attacker_participation=
      {
        character=140
        score=1.00000
      }
      defender_participation=
      {
        character=122
        score=1.00000
      }
    }

Footer
------

Entire example:

    next_outbreak_id=432
    income_statistics=
    {
    }
    nation_size_statistics=
    {
    }
    nr="A_POPE_OF_MY_OWN"
    nr="ALL_THREE_POPES"
    nr="EXALTED_AMONG_MEN"
    nr="DEATH_DO_US_PART"
    nr="CRUSADER"
    nr="PARAGON_OF_VIRTUE"
    nr="UNITED_THE_KINGDOMS"
    nr="A_NORMAN_YOKE"
    nr="SURVIVOR"
    nr="CRUSADER_KING"
    nr="PRESTER_JOHN"
    nr="THE_HOLY_PLACES"
    nr="PENTARCH"
    character_action=0
    }
    3d968b7bb02aa1767e4b4b090cea26ed