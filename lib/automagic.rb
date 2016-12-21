require 'csv'
require 'i18n'
require 'json'
require_relative 'col_sep_sniffer.rb'

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
puts x
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



  #   end
  #   end
  # end
  # end
  # end


      @data.length.times do | num |
             @properties={}
      @custom_properties={}
      @data[1].each do | key, value |
        key = match_name(key) unless match_name(key).nil?
        key = match_email(key) unless match_email(key).nil?
         key = match_last_name(key) unless match_last_name(key).nil?
          if @standard_properties.include? key.downcase
            @properties[key] = value
          else
            @custom_properties[key] = value
          end
        end

        end







# @standard_properties = ['id', 'email', 'name', 'first_name', 'last_name', 'user_name', 'phone', 'created_at']

# FIRST_NAMES_ALIASES=['first_name', 'First Name', ‘FirstName’]
# EMAIL_ALIASES=['Email', 'Email Address', 'EmailAddress’]
# LAST_NAMES_ALIASES=['last_name', 'Last Name', ‘LastName', 'Last name' ]
# USERNAME_ALIASES=['username', ‘user_name', 'UserName’ ]

# def match_first_name(key)
# re = Regexp.union(FIRST_NAMES_ALIASES)
# key.match(re)
# if key.match(re)
# key = 'first_name'
# else
# key
# end
# end

# def match_email(key)
# re = Regexp.union(EMAIL_ALIASES)
# key.match(re)
# if key.match(re)
# key = 'email'
# else
# key
# end
# end

# def match_last_name(key)
# re = Regexp.union(LAST_NAME_ALIASES)
# key.match(re)
# if key.match(re)
# key = 'last_name'
# else
# key
# end
# end

