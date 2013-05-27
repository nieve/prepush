require 'spec_helper'

class MspecRunnerTester
	@solution = "spec/TestProj/TestProj/TestProj.csproj"
	@assemblies = ["C:/Code/Ruby Projects/prepush/spec/TestProj/TestProj/bin/Debug/TestProj.exe"]
	@test_runner = 'mspec'
	include PrePush
end

describe "MspecRunner" do
	it "should compile and run tests" do
		MspecRunnerTester.run
	end
end