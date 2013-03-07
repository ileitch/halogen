# Halogen

Identifying unused code in Ruby is hard. Test suite coverage will get you so far,
but you're out of luck if you have old tests covering unused code.

Halogen consists of a patch to CRuby (MRI) and instrumentation for your framework to
allow running Coverage in production.

## How it Works

When you require a file with Coverage enabled, CRuby generates extra 'trace'
instructions which the Coverage module then listens for. CRuby does not currently
support starting, stopping and starting again coverage for a previously required
file. Halogen's patch adds the ability to retain coverage results between runs.

With this patch applied, Halogen can enable coverage for a percentage
of your requests and gradually build a coverage report.

## Performance

Coverage does not come for free in CRuby. The presence of the extra 'trace'
instruction has overhead, and that overhead is increased when Coverage is running.

TODO: Graph, single servers, frequency.

## Installation

First you need to install CRuby with the Halogen patch applied.

### rvm

```
$ wget "https://github.com/ileitch/halogen/blob/master/patches/1_9_3_p392.patch"
$ rvm install ruby-1.9.3-p392 -n halogen --patch 1_9_3_p392.patch
```

### ruby-build

```
$ wget "https://github.com/ileitch/halogen/blob/master/ruby-build/1.9.3-p392-halogen"
$ ruby-build install 1.9.3-p392-halogen
```

Add Halogen to your Gemfile:

    gem 'halogen'

## Usage

### Rails

`app/controllers/application_controller.rb`

```ruby
class ApplicationController
  require Halogen::RailsFilter
end
```

Note: You should include this at the very top of the class.

## Configuration

`config/initializers/halogen.rb`

```ruby
Halogen.configure do |config|
  # Perform coverage on every 500th request.
  config.frequency = 500

  # Dispatch report complication job over Resque.
  # Options are :resque, :sidekiq and :thread.
  config.dispatcher = :resque

  # Path on disk to write the coverage report.
  config.coverage_path = '/tmp/app_coverage'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2013 Ian Leitch, LivingSocial, Inc. See LICENSE for details.
