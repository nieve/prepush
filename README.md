# PrePush

Add a pre-push git hook on any of your repos to build & run tests of your .net project.
As of Git 1.8.2 you can use a pre-push hook (https://raw.github.com/git/git/master/Documentation/RelNotes/1.8.2.txt).
This gem will allow you to use a ready made hook to build your solution & run tests with either nunit, xunit or mspec.

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
		$ prepush /r=mspec
		$ prepush /r=xunit191

the first will use nunit (2.6.2) for running your tests.
By default, the pre-push hook will use the first .sln file it finds.

The arguments accepted are:
	
		/r={test runner}
		/td={testable dlls}

If you wish to specify the dlls that your test runner should run/test use:
	
		$ prepush /td=./path/to/some.dll,./path/to/another.dll

You can also modify the solution, dlls & even runner on the dropped pre-push file itself.
If you're using mspec, you may need to specify the dlls you wish to test in the @assemblies array variable. Failing to do so may result in the error "Could not load file or assembly 'path/to/your.sln' or one of its dependencies. The module was expected to contain an assembly manifest."

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
