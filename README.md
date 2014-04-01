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

After installing the gem,open the command line and cd to the git repository you wish to add the hook to 
(the directory containing a .git dir) and from there type:
	
		$ prepush

This will drop a pre-push hook into the git hooks directory.
The hook contains the following fields which you will need to specify:

    @test_runner = 'nunit262' #will tell the prepush hook to use nunit 2.6.2 runner
    @solution = [path/to/sln1.sln, path/to/sln2.sln] # the paths to the solutions to build
    @assemblies = [test_dlls] # insert dlls to test if different to the solution.
    @tests_to_run = {xunit191: ["./path/to/xunit/tests.dll"], nunit262: ["./path/to/nunit/tests1.dll", "./path/to/nunit/tests2.dll"]}
    override_msbuild 'path/to/custom/msbuild.exe'
    force_test_runner 'path/to/my/custom/test_runner.exe' # uncomment to use a custom test runner

 **Assigning the @tests_to_run attr will override anything you may have assigned to @assemblies!**

By default, the pre-push hook will use the first .sln file it finds.

## Command line arguments

You could use the following command line arguments as follow, however editing the file would be much easier to control.
(These would probably get deprecated)
The arguments accepted are:
	
		/r={test runner}
		/td={testable dlls}
		/msb={path/to/custom/MSBuild.exe}

If you wish to specify the dlls that your test runner should run/test use:
	
		$ prepush /td=./path/to/some.dll,./path/to/another.dll


The default msbuild path used is C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe.
If you wish to override it use:
		
		$ prepush /msb=c:/my/path/to/MSBuild.exe

If you wish to modify the default msbuild path that will be used by default on all your prepush hooks use:
		
		$ prepush-config d:/my/path/to/MSBuild.exe

If you're using mspec, you may need to specify the dlls you wish to test in the @assemblies array variable. Failing to do so may result in the error "Could not load file or assembly 'path/to/your.sln' or one of its dependencies. The module was expected to contain an assembly manifest."

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
