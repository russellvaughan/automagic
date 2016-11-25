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


  property_fields = ['id', 'email', 'name', 'first_name', 'last_name',
      'username', 'phone', 'created_at']


 def first_row_values
  @values = @csv[1]
  @values.pop while @values.last.nil? && @values.size>0
 end

    end
    end
  end
  end
  end


      # properties = {}
      # hash[x].each do | key, value |
      #   property_fields.each do | property |
      #     if key === property
      #       properties[key] = value
      #       properties['custom'] = @custom_props
      #       properties['totals'] = @totals
      #     end
      #   end
      # end

standard_properties = ['id', 'email', 'name', 'first_name', 'last_name', 'user_name', 'phone', 'created_at']
csv = CSV.read('dummy_data.csv')
properties = {}
hash = []


values = csv[1]
x = 0
standard_properties.each  do |property|
properties[property]  = values[x]
x+=1
hash << properties
end

end

end
