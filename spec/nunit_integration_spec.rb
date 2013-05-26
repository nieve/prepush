require 'spec_helper'

class NunitRunnerTester
	@solution = "spec/TestProj/TestProj.sln"
	@assemblies = ["spec/TestProj/TestProj/TestProj.csproj"]
	@test_runner = 'nunit262'
	include PrePush
end

describe "NunitRunnerTester" do
	it "should compile and run tests" do
		NunitRunnerTester.run
	end
end