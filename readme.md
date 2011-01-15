Culturegrid
===========

[Culturegrid](http://www.culturegrid.org.uk/) provides an XML API for searching cultural datasets in the UK. I don't know about you, but to be honest I find these kinds of things quite hard to work with in their raw form. Lots of Dublin Core metadata floating around in nested XML tags, and so on.

So, here's a ruby gem that simplifies a few use cases for the API and let's you get on with your mashup.

Example:

    grid = CultureGrid::Index.new
    => #<CultureGrid::Index:0x10139a920 @base="http://culturegrid.org.uk/index/select/">
    
    results = grid.search("scree")
    
    results.size
    => 10
    
    ascent_of_snowdon = results.last
    
    pp ascent_of_snowdon
    => {"aggregator.internal.id"=>"2103130",
     "aggregator.internal_record_link"=>
      "/dpp/resource/2103130/stream/CultureGrid_Item",
     "dc.language"=>"EN-GB",
     "dc.title"=>["Ascent of Snowdon from Rhyd-ddu, Screes near top"],
     "dcterms.rightsHolder"=>"Kirklees",
     "dcterms.spatial"=>["Kirklees"],
     "timestamp"=>"2010-12-07T09:38:02.324Z",
     "dc.contributor"=>["Kirklees"],
     "dcterms.isPartOf_AllNames"=>
      "People's Network|CG_BREAK|Kirklees Image Archive",
     "cached_thumbnail"=>"/dpp/resource/2103130/stream/thumbnail_image_jpeg",
     "dc.identifier"=>
      "http://www.kirkleesimages.org.uk/frontend.php?keywords=Ref_No_increment;EQUALS;kw01090&pos=2&action=zoom",
     "dcmi.type"=>["Image"],
     "pndsterms.thumbnail"=>
      "https://www.hpacde.org.uk/kirklees/jpgs_kirklees/kw01090.jpg",
     "dc.related.link"=>
      "http://www.kirkleesimages.org.uk/frontend.php?keywords=Ref_No_increment;EQUALS;kw01090&pos=2&action=zoom",
     "have_temporal"=>"false",
     "dc.format"=>["JPEG/IMAGE"],
     "dc.publisher"=>"Kirklees",
     "authority"=>"KirkleesImages",
     "authority_name"=>"Kirklees Image Archive OAI Feed",
     "dc.subject"=>["Kirklees"],
     "dcterms.license"=>"http://creativecommons.org/licenses/by-nc-nd/2.0/uk/",
     "dc.location"=>"Kirklees",
     "dcterms.isPartOf"=>["PN", "KirkleesImageArchive"],
     "dcterms.isPartOf_AllIDs"=>"PN|CG_BREAK|KirkleesImageArchive",
     "dcterms.isPartOf_Name"=>["People's Network", "Kirklees Image Archive"],
     "dcterms.audience"=>["General_Educational"],
     "restp"=>"ServiceProvider"}
    
    ascent_of_snowdon.authority
    => "KirkleesImages"
    
    ascent_of_snowdon.title
    => "Ascent of Snowdon from Rhyd-ddu, Screes near top"
    
    ascent_of_snowdon["dcterms.isPartOf"]
    => ["PN", "KirkleesImageArchive"]