require 'spec_helper'

class MspecRunnerTesterClr4
	@solution = "spec/TestProj/TestProj/TestProj.csproj"
	@assemblies = ["C:/Code/Ruby Projects/prepush/spec/TestProj/TestProj/bin/Debug/TestProj.exe"]
	@test_runner = 'mspec'
	#@runner_exe = 'mspec-clr4.exe' # will be selected by default
	include PrePush
end

class MspecRunnerTesterClr2
	@solution = "spec/TestProj/TestProj/TestProj.csproj"
	@assemblies = ["C:/Code/Ruby Projects/prepush/spec/TestProj/TestProj/bin/Debug/TestProj.exe"]
	@test_runner = 'mspec'
	@clr = :clr2
	#@runner_exe = 'mspec-clr4.exe' # will be selected by default
	include PrePush
end

describe "MspecRunner" do
	describe "on clr 4" do
		before do
			ReplaceClr.between('v2.0', 'v3.5')
		end
		it "should compile and run tests" do
			MspecRunnerTesterClr4.run
		end
	end
end