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

## Performance

Coverage does not come for free in CRuby. The presence of the extra 'trace'
instruction has overhead, and that overhead is increased when Coverage is running.

TODO: Graph, single servers, frequency.

## Installation

Add this line to your application's Gemfile:

    gem 'halogen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install halogen

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
