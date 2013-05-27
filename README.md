# PrePush

Add a pre-push git hook on any of your repos to build & run tests of your .net project.

## Installation

Add this line to your application's Gemfile:

    gem 'pre_push'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pre_push

## Usage

After installing the gem, cd to the git repository you wish to add the hook to 
(the directory containing a .git dir) and from there use one of the following:
	
		$ prepush
		$ prepush mspec
		$ prepush xunit191

the first will use nunit (2.6.2) for running your tests.
And insert the solution or assemblies paths.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
