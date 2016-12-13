require 'csv'
require 'i18n'

def read_csv(csv)
@csv = CSV.read(csv)
  if @csv[0][0].include?(";")
  @csv = @csv.map { |row| row =  row[0].split(",") }
  convert_seperation(@csv)
  normalise(@csv)
  end
end

def convert_seperation(csv)
x = 1
@array = []
@csv.map do  |row|
@new_row = row.map{|x| x.gsub(";",",")} unless x.nil?
@array<<@new_row.split(",")
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



def trim_headers(csv)
  @headers = csv.first
  @headers.pop while @headers.last.nil? && @headers.size>0
end

def map_data(csv)
  @data = {}
  x = 0
  csv.each do |row|
   @properties = {}
   row.length.times do |number|
    @headers.length.times do |num|
      @properties[@headers[num]] = row[num]
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


 def  match_standard_props
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


      # properties = {}
      # hash[x].each do | key, value |
      #   property_fields.each do | property |
      #     if key === property
      #       properties[key] = value
      #       properties['custom'] = @custom_props
      #       properties['totals'] = @totals
      #     end
      #   end
#       # end

@standard_properties = ['id', 'email', 'name', 'first_name', 'last_name', 'user_name', 'phone', 'created_at']
# csv = CSV.read('dummy_data.csv')
# properties = {}
# hash = []


# values = csv[1]
# x = 0
# standard_properties.each  do |property|
# properties[property]  = values[x]
# x+=1
# hash << properties
# end

# end

# end
