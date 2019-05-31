# LarvataTimesheet
Timesheet functionality in a small Rails engine

## Usage
Read the specs.

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

## Persisting Workdays
* Assume weekday is M-F, weekend is Sa/Su.

### Normal cases
* Weekday is work day
* Weekend is off day

### Special cases
* Weekday is off day
* Weekend is work day
* Assume holidays are manually handled by admin, differs year to year

### Multiple calendar support
* Offdays must be associated with a certain calendar
* Name, default (only one can be default)

### Conclusion
* If a weekday has a row, it is an off day
* If weekend has a row, it is a work day

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
