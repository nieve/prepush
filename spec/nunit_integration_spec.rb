require 'spec_helper'

class NunitRunnerTester
	@solution = "spec/TestProj/TestProj.sln"
	@assemblies = ["spec/TestProj/TestProj/TestProj.csproj"]
	@test_runner = 'nunit262'
	#@runner_exe = 'nunit-console.exe' # will be selected by default
	include PrePush
end

describe "NunitRunnerTester" do
	before do
		ReplaceClr.between('v2.0', 'v3.5')
	end
	it "should compile and run tests" do
		NunitRunnerTester.run
	end
end

describe "on clr 2" do
	before do
		ReplaceClr.between('v3.5', 'v2.0', 'TestProj2')
	end
	it "should compile and run tests" do
		NunitRunnerTester.run
	end
end