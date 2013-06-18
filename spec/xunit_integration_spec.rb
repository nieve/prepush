require 'spec_helper'

class XunitRunnerTester
	@solution = "spec/TestProj/TestProj.sln"
	@assemblies = ["spec/TestProj/TestProj/bin/Debug/TestProj.exe"]
	@test_runner = 'xunit191'
	#@runner_exe = 'xunit.console.exe' # will be selected by default
	include PrePush
end

class XunitRunnerTesterClr2
	@solution = "spec/TestProj/TestProj2/TestProj.sln"
	# XUnit on clr2 takes the dll path only, won't work with csproj.
	@assemblies = ["spec/TestProj/TestProj2/bin/Debug/TestProj.dll"]
	@test_runner = 'xunit191'
	include PrePush
end

describe "XunitRunner" do
	it "should compile and run tests" do
		XunitRunnerTester.run
	end
end

describe "on clr 2" do
	before do
		ReplaceClr.between('v3.5', 'v2.0', 'TestProj2')
	end
	it "should compile and run tests" do
		XunitRunnerTesterClr2.run
	end
end