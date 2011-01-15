$:.unshift(File.expand_path(File.join(File.dirname(__FILE__))))
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..","lib")))

require 'spec_helper'
require "culturegrid"
require 'json'

describe CultureGrid::Index do
  
  before do
    @grid = CultureGrid::Index.new
  end
  
  describe "Searching for things" do
    
    before do
     WebMock.stub_request(:get, /.*/).to_return(:body => File.open(File.join(File.expand_path(File.dirname(__FILE__)),"example_response.xml")).read)
    end
    
    it "should find a set of things for a valid search" do
      @grid.search("scree").size.should eql(10)
    end
    
    it "should parse the results into Docs" do
       @grid.search("scree").first.should be_a(CultureGrid::Doc)
    end
    
    it "should deserialize Docs into hashie mashes" do
      @grid.search("scree").first["dc.title"].should eql(["Screes near Badger Slacks"])
      @grid.search("scree").first["pndsterms.thumbnail"].should eql("https://www.hpacde.org.uk/kirklees/jpgs_kirklees/k006195.jpg")
    end
    
    it "should get a document's title" do
      @grid.search("scree").first.title.should eql("Screes near Badger Slacks")
    end
    
    it "should serialize Doc objects with an ID and title" do
      JSON.parse(@grid.search("scree").first.to_json)["id"].should eql(2082977)
      JSON.parse(@grid.search("scree").first.to_json)["title"].should eql("Screes near Badger Slacks")
    end
     
  end

end