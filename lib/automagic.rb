require 'csv'
require 'i18n'

def import(csv)
  @csv = CSV.read(csv)
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
      @properties[@headers[num]] = row[num]
    end
  end
  @data[x]=@properties
  x+=1
end
end

def preview
6.times do |x| 
@preview << @data[x]
end 
@preview.slice!(0)
end

def normalise(csv)
@object = [] 
@csv.each do |line|
@array = line.map do |object|
unless object.nil?
I18n.transliterate(object)
end
end
@object << @array
end
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
