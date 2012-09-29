# What is Quandrax?

   This is the QUick ANd Dirty paRAdoX converter, a project to create a single,
   unified save game converter. Currently, it is primarily focused on CK2-EU3,
   as that seems to be the biggest need.

## How does it work?

   Load the CK2 savegame into the same folder as Quandrax, along with any other
   files Quandrax comes with. Run Quandrax, and you'll have a new EU3 savegame
   called "conversion.eu3". Place that in your EU3 save folder, and you're done!

## What's left to do on the project?

   There are a few things left to do before Quandrax is released for bug testing.


### Tag Mapping

   There are a few tags that aren't mapped yet

### Province Mapping

    There are a few provinces mapped extraneously - need to remove them from the map

### Quandrax

    REQUIRES: quandrax.rb, tag_map.rb, prov_map.rb, template.txt

   First, how it works:
   1. Loads old saved file.
   2. Strips out player and date info.
   3. Strips out province controllers and vassal-liege structures.
   4. Uses tag_map.rb to update that information to tags.
   5. Load the template.eu3 file.
   6. Make a new save file, converted.eu3, which is template.eu3 read in, subbing
      in the information for player, date, and tags.

 WORK TO DO
 * Finish the last step - pulling in template.rb, subbing in date, etc.

     
