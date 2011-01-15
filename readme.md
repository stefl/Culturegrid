Culturegrid
===========

[Culturegrid](http://www.culturegrid.org.uk/) provides an XML API for searching cultural datasets in the UK. I don't know about you, but to be honest I find these kinds of things quite hard to work with in their raw form. Lots of Dublin Core metadata floating around in nested XML tags, and so on.

So, here's a ruby gem that simplifies a few use cases for the API and let's you get on with your mashup.

To use

    gem install culturegrid

Example:
    
    require 'culturegrid'
    
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
    
Each result is a CultureGrid::Doc, which is a Hashie::Mash, so look at this:

    require 'json'
    require 'culturegrid'
    
    CultureGrid.search("joy").first.to_json
    => "{\"dcterms.rightsHolder\":\"Leeds Central Library\",\"dc.title\":[\"York Road, Joy's Fold\"],\"aggregator.internal_record_link\":\"/dpp/resource/2541087/stream/CultureGrid_Item\",\"aggregator.internal.id\":\"2541087\",\"dcterms.spatial\":[\"World, Europe, United Kingdom\"],\"timestamp\":\"2010-12-07T11:08:13.869Z\",\"dcterms.isPartOf_AllNames\":\"People's Network|CG_BREAK|Leodis\",\"pndsterms.thumbnail\":\"http://www.leodis.net/imagesLeodis/thumbnail/24/20091124_169824.jpg\",\"dcmi.type\":[\"Image\"],\"dc.identifier\":\"http://www.leodis.net/display.aspx?id=20091124_169824\",\"dc.description\":[\"18th September 1935.\\nView of Joy's Fold, a yard off York Road near the junction with Marsh Lane. In the centre are the premises of Cecil Gilbert, shoeing smith, of no.15 Joy's Fold. These buildings were all soon to be demolished as part of the slum clearance programme in the area.\"],\"cached_thumbnail\":\"/dpp/resource/2541087/stream/thumbnail_image_jpeg\",\"have_temporal\":\"false\",\"dc.related.link\":\"http://www.leodis.net/display.aspx?id=20091124_169824\",\"dcterms.license\":\"http://www.leodis.net/article.aspx?id=12\",\"dc.subject\":[\"York Road\",\"Joy's Fold\"],\"authority_name\":\"Leodis - A photographic archive of Leeds\",\"authority\":\"Leodis\",\"dcterms.isPartOf_AllIDs\":\"PN|CG_BREAK|Leodis\",\"dcterms.isPartOf\":[\"PN\",\"Leodis\"],\"dcterms.isPartOf_Name\":[\"People's Network\",\"Leodis\"],\"restp\":\"ServiceProvider\"}"