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

class DummyCustomMSBuild < Dummy
	override_msbuild 'path/to/custom/msbuild.exe'
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
			DummyCustomMSBuild.should_receive("system").with(/^path\/to\/custom\/msbuild.exe/)
			DummyCustomMSBuild.build
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