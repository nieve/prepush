require 'spec_helper'

class Dummy
	@solution = "solution/path/whammy"
	include PrePush
end

class EmptyDllsDummy
	@solution = "./path/to/some.sln"
	@assemblies = []
	include PrePush
end

class MultiTesterDummy
	@tests_to_run = {mspec0515: ["./path/to/mspec/tests.dll"], nunit262: ["./path/to/nunit/tests1.dll", "./path/to/nunit/tests2.dll"]}
	include PrePush
end

class DummyCustomMSBuild < Dummy
	override_msbuild 'path/to/custom/msbuild.exe'
	@solution = 'some/solution.sln'
end

class DummyMultipleSolutions < Dummy
	@solution = ["path/to/solution1.sln","path/to/solution2.sln"]
end

class DummyCustomTestRunner < Dummy
	force_test_runner 'path/to/my/custom/test_runner.exe'
end

class NilClass
	def success?	
	end
end

describe PrePush do
	describe 'build' do
		it "should call system to build the solution" do
			Dummy.should_receive("system").with(/solution\/path\/whammy$/)
			Dummy.build
		end
		it "should use clr4 msbuild when no clr specified" do
			Dummy.should_receive("system").with(/^C:\/Windows\/Microsoft.NET\/Framework\/v4.0.30319\/MSBuild.exe/)
			Dummy.build
		end
		it "should use custom msbuild when specified" do
			DummyCustomMSBuild.should_receive("system").with(/^path\/to\/custom\/msbuild.exe some\/solution.sln/)
			DummyCustomMSBuild.build
		end
		it "should build all solutions specified" do
			DummyMultipleSolutions.should_receive("system").with(/path\/to\/solution1.sln/)
			DummyMultipleSolutions.should_receive("system").with(/path\/to\/solution2.sln/)
			DummyMultipleSolutions.build
		end
	end
	describe 'run_tests' do
		it 'should call system to run tests on specified assemblies' do
			Dummy.should_receive("system").with(/some_test_proj.csproj/)
			Dummy.run_tests(['some_test_proj.csproj'])
		end
		it "should use custom test runner when specified" do
			DummyCustomTestRunner.should_receive("system").with(/^path\/to\/my\/custom\/test_runner.exe/)
			DummyCustomTestRunner.run_tests(['some_test_proj.csproj'])
		end
		it "should use specified test runner on specified test dlls when using tests_to_run" do
			MultiTesterDummy.should_receive("system").with(/mspec-clr4.exe\" \".\/path\/to\/mspec\/tests.dll\"$/)
			MultiTesterDummy.should_receive("system").with(/nunit-console.exe\" \".\/path\/to\/nunit\/tests1.dll\"$/)
			MultiTesterDummy.should_receive("system").with(/nunit-console.exe\" \".\/path\/to\/nunit\/tests2.dll\"$/)
			MultiTesterDummy.run_tests(nil)
		end
		describe 'when assemblies are left empty' do
			it 'should call system to run tests on solution' do
				EmptyDllsDummy.should_receive("system").with(/\.\/path\/to\/some.sln"$/)
				EmptyDllsDummy.run_tests([])
			end
		end
	end
	describe 'run' do
		it 'should exit with code 1 when build or tests fail' do
			Dummy.should_receive("system").with(/solution\/path\/whammy/).twice
			system('false') if $? != nil
			Dummy.should_receive("exit").with(1).twice
			Dummy.should_receive("puts").with('build has failed')
			Dummy.should_receive("puts").with('Tests have failed')
			Dummy.run
		end
	end
end