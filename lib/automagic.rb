require 'csv'

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


 gs.tracking.identify({
  person_id: "email:user@test.com", # Required

  # Reserved property names
  properties: {
    name: "Test User",
    username: "testuser",
    phone: "+44123456789",
    created_at:"2016-06-07T15:44:20Z", # ISO 8601 formatted String
    company_name:"GoSquared",
    company_industry:"Customer Analytics",
    company_size: 15000,

    # Custom properties
    custom: {
      # custom_property_name: "custom property value"  # You can track as many custom properties as you like
    }
  }
  })

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
