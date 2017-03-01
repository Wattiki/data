require_relative "../file_type.rb"
require "rest-client"

class FileTei < FileType
  # TODO we could include the tei_to_es and other modules directly here
  # as a mixin, though then we'll need to namespace them or perish
  attr_reader :es_json


  def initialize file_location, proj_dir, options
    super file_location, proj_dir, options
    @es_json = nil
    @script_html = options["tei_html_xsl"]
    @script_solr = options["tei_solr_xsl"]
  end

  def post_es
    begin
      transformed = @es_json || transform_es(@options["output"])
      if !@options["transform_only"]
        transformed.each do |doc|
          id = doc["identifier"]
          type = @options["es_type"]
          puts "posting #{id}"
          path = "#{@options["es_path"]}/#{@options["es_index"]}"
          puts "PATH: #{path}/#{type}/#{id}" if options["verbose"]
          RestClient.put("#{path}/#{type}/#{id}", doc.to_json, {:content_type => :json } )
        end
      end
      return { "docs" => transformed }
    rescue => e
      return { "error" => "Error transforming or posting to ES for #{self.filename(false)}: #{e.inspect}" }
    end
    # TODO pull out PUT to ES so VRA / DC / CSV can use it too
    # but we'll cross that bridge when we get to it in the distant future
  end

  def print_es
    json = @es_json || transform_es
    return pretty_json json
  end

  def transform_es output=false
    begin
      @es_json = TeiToEs.create_json(self, @options)
      if output
        filepath = "#{@out_es}/#{self.filename(false)}.json"
        File.open(filepath, "w") { |f| f.write(self.print_es) }
      end
      return @es_json
    rescue => e
      raise e
    end
  end

  # if there should not be any html transformation taking place
  # then leave this method empty but uncommented to override default behavior

  # if you would like to use the default transformation behavior
  # then comment or remove both of the following methods!
  # def transform_html
  # end

  def transform_solr output=false
  end
end
