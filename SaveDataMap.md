Save Data Map
=============
Reference the CK2SaveGame.md and EU3SaveGame.md files for further details.

- Data parts (headers in structure files) will map to objects
- Each object's variables will map

Header
------
- Ignore version
- date => date
- player{id, type} - keep track of for later
- player_realm => player="TAG"
- # DOESN'T USE in CK2 - these will be pulled from a TAG matching file to autopopulate
  - monarch
  - leader
  - cardinal
  - advisor
- rebel => rebel
- unit => unit
- flags{} => flags{}
- gameplaysettings={} # THIS IS AUTOPOPULATED
- start_date => start_date # will this mess up if I use the CK2 Start date? Is so, use CK2 date above
- id={} # Is this related to ID in the CK2 file (above)
