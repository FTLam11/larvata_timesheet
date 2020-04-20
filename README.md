# LarvataTimesheet
~~Timesheet~~ *Incomplete* calendar functionality in a small Rails engine

## Usage
Read the specs. Also read the [RAILS GUIDES ON ENGINES](https://guides.rubyonrails.org/engines.html#hooking-into-an-application).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'larvata_timesheet'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install larvata_timesheet
```

## Key assumptions
* Assume weekday is M-F, weekend is Sa/Su.
* Weekday is work day
* Weekend is off day
* Assume holidays are manually handled by admin, differs year to year

## Multiple calendar support
* Offdays must be associated with a certain calendar
* Only one calendar can be designated as default
* If a weekday has a database record, it is an off day
* If weekend has a database record, it is a work day

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
