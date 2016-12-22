## Ruby CSV Importer

A CSV Importer for importing user data to a GoSquared project's People Dashboard

### Setup

```ruby
bundle
```

### Use

```ruby
require './lib/csv_importer.rb'
csv_importer = CsvImporter.new('api_key', 'site_token')
csv_importer.import_csv('path_to_csv')
```

Then Watch The Magic Happen
