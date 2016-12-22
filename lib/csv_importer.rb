require 'csv'
require 'i18n'
require 'json'
require 'gosquared'
require_relative 'col_sep_sniffer.rb'

class CsvImporter

def initialize(api_key, site_token)
@api_key = api_key
@site_token = site_token
end

def import_csv(csv)
read_csv(csv)
trim_headers
map_data
segment_properties
end


def read_csv(csv)
  @csv = CSV.read(csv, encoding: "ISO8859-1:utf-8")
  if @csv[0].length > 1
    if ColSepSniffer.find(csv) != ","
      @csv = @csv.map { |row| row =  row[0].split(",") }
      convert_seperation(@csv)
      normalise(@csv)
    end
  end
end

def convert_seperation(csv)
  x = 1
  @array = []
  @csv.map do  |row|
    @new_row = row.map{|x| x.gsub(";",",")} unless x.nil?
    @array<<@new_row[0].split(",")
  end
  x+=1
  @csv = @array
end


def normalise(csv)
  I18n.available_locales = [:en]
  x = 1
  @object = []
  csv.map do |row|
    @normalised_row = row.map {|word| I18n.transliterate(word) unless word.nil?}
    puts x
    @object << @normalised_row
    x+=1
  end
  @csv = @object
end


def trim_headers
  @headers = @csv.first
  @headers.pop while @headers.last.nil? && @headers.size>0
end

def map_data
  @data = {}
  x = 0
  @csv.each do |row|
   @properties = {}
   row.length.times do |number|
    @headers.length.times do |num|
      @properties[@headers[num].strip] = row[num].strip unless row[num].nil?
    end
  end
  @data[x]=@properties
  x+=1
end

end

def preview
  @preview = []
  6.times do |x|
    @preview << @data[x]
  end
  @preview.slice!(0)
  @preview.to_json
end

def normalise(csv)
  I18n.available_locales = [:en]
  @object = []
  csv.each do |line|
    @array = line.map do |object|
      unless object.nil?
        I18n.transliterate(object)
      end
    end
    @object << @array
  end
  @csv = @object
end


def match_standard_props
  @headers.each do |header|
    @property_fields.each do |property|
      if header.downcase == property
        @standard_props << header
      end
    end
  end
end

  def segment_properties
    @all_entries = @data.length
    @data.each_with_index do |e, i|
     next if i == 0
     @properties={}
     @custom_properties={}
     @data[i].each do | key, value |
      key = match_first_name(key) unless match_first_name(key).nil?
      key = match_email(key) unless match_email(key).nil?
      key = match_last_name(key) unless match_last_name(key).nil?
      if STANDARD_PROPS.include? key.downcase
        @properties[key] = value
      else
        @custom_properties[key] = value
      end
    end
    post_data
  end
end



STANDARD_PROPS = ['id', 'email', 'name', 'first_name', 'last_name', 'user_name', 'phone', 'created_at']

FIRST_NAMES_ALIASES=['first_name', 'First Name', 'FirstName']
EMAIL_ALIASES=['Email', 'Email Address', 'EmailAddress']
LAST_NAMES_ALIASES=['last_name', 'Last Name', 'LastName', 'Last name' ]
USERNAME_ALIASES=['username', 'user_name', 'UserName' ]

def match_first_name(key)
re = Regexp.union(FIRST_NAMES_ALIASES)
key.match(re)
if key.match(re)
key = 'first_name'
else
key
end
end

def match_email(key)
re = Regexp.union(EMAIL_ALIASES)
key.match(re)
if key.match(re)
key = 'email'
else
key
end
end

def match_last_name(key)
re = Regexp.union(LAST_NAMES_ALIASES)
key.match(re)
if key.match(re)
key = 'last_name'
else
key
end
end

def post_data
  @failed = []
  puts "props: #{@properties}"
    puts "custom_props: #{@custom_properties}"
gs = Gosquared::RubyLibrary.new(@api_key, @site_token)
   gs.tracking.identify({
      "person_id": @properties['id'] ? @properties['id'] : @properties['email']  ,
      "properties": @properties,
      "custom": @custom_properties
      })

    begin
      response = gs.tracking.post
      @failed << "id = #{@properties['id']}" if response.code != '200'
      sleep(0.75)
    rescue Net::ReadTimeout, StandardError
      print "API Timeout"
      @failed << "id = #{@properties['id']}"
      sleep(10)
    end
    puts "failed entries #{@failed}"
    puts "#{@all_entries -= 1}"
    puts "Approx #{(@all_entries / 60)} minutes remaining"

end

end
