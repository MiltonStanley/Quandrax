= What is Quandrax?

   This is the QUick ANd Dirty paRAdoX converter, a project to create a single,
   unified save game converter. Currently, it is primarily focused on CK2-EU3,
   as that seems to be the biggest need.

== How does it work?

   Load the CK2 savegame into the same folder as Quandrax, along with any other
   files Quandrax comes with. Run Quandrax, and you'll have a new EU3 savegame
   called "conversion.eu3". Place that in your EU3 save folder, and you're done!

== What's left to do on the project?

   There are a few things left to do before Quandrax is released for bug testing.

=== Tag Mapping

   REQUIRES: tag_manual_adder.rb, tag_map.rb
   This will automate the rough parts of tag mapping. You will be prompted with
   a title, and will need to type in the tag. Run tag_manual_adder with the -d
   or -debug flag, and it will report how much is left to do. tag_map.rb is the
   hash of completed tags.

=== Province Mapping

    REQUIRES: prov_manual_adder, prov_map.rb
    Same as Tag Mapping, but this time with provinces.

=== Quandrax
    First, how it works:
    * Loads old saved file.
    * Strips out player and date info.
    * Strips out province controllers and vassal-liege structures.
    * Uses tag_map.rb to update that information to tags.
    * Load the template.eu3 file.
    * Make a new save file, converted.eu3, which is template.eu3 read in, subbing
      in the information for player, date, and tags.

    WORK TO DO
    * Finish the last step - pulling in template.rb, subbing in date.

     
