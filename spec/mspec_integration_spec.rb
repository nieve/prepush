require 'spec_helper'

class MspecRunnerTester
	@solution = "C:/Code/Katas/MathTreeKata/MathTreeKataTests/MathTreeKataTests.csproj" #"spec/TestProj/TestProj.sln"
	@test_runner = 'mspec'
	include PrePush
end

describe "MspecRunner" do
	it "should compile and run tests" do
		MspecRunnerTester.run
	end
end