require 'nokogiri'
require 'open-uri'
require 'hashie'
require 'weary'

module CultureGrid
  
  class Index

    def initialize(base="http://culturegrid.org.uk/index/select/")
      @base = base
    end
    
    def get(opts)
      q = []
      opts[:version] ||= "2.2"
      opts[:indent] ||= "on"
      opts.each_pair do |opt,val|
        q << "#{opt}=#{CGI::escape(val)}"
      end
      url = "#{@base}?#{q.join("&")}"
      puts url
      
      Nokogiri::XML(Weary.get(url).perform.body)
    end
    
    def result(opts)
      self.get(opts).css("doc").collect{|a| Doc.new(a)}
    end
    
    def query(terms, opts={})
      self.result({:q=>terms}.merge(opts))
    end

    def search(terms, opts={})
      self.query("dc.title all \"#{terms}\" OR fullText all \"#{terms}\"", opts)
    end
    
  end

  class Doc < Hashie::Mash
    def initialize(d)
      hash = {}
      
      d.children.each do |prop|
        if prop.attributes["name"]
          case prop.name
          when "arr"
            hash[prop.attributes["name"].value] = prop.children.collect{|c| c.text}
          else
            if prop.children
              hash[prop.attributes["name"].value] = prop.children.text
            else
              hash[prop.attributes["name"].value] = prop.text
            end
          end
        end
      end
      super(hash)
    end
  end
end