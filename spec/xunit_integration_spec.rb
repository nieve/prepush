require 'spec_helper'

class XunitRunnerTester
	@solution = "spec/TestProj/TestProj.sln"
	@assemblies = ["spec/TestProj/TestProj/bin/Debug/TestProj.exe"]
	@test_runner = 'xunit191'
	include PrePush
end

describe "XunitRunner" do
	it "should compile and run tests" do
		XunitRunnerTester.run
	end
end