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

class DummyClr2
	@clr = 'clr2'
	@solution = "solution/path/whammy"
	include PrePush
end

class SetExeDummy
	@solution = 'meh'
	@runner_exe = 'bar.exe'
	@test_runner = 'nunit262'
	def self.get_runners_exes
		@runners_exes
	end
	def self.set_exes
		self.build
	end
	include PrePush
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
			Dummy.should_receive("system").with(/^C:\/Windows\/Microsoft.NET\/Framework\/v4.0.30319/)
			Dummy.build
		end
	end
	describe 'run_tests' do
		it 'should call system to run tests on specified assemblies' do
			Dummy.should_receive("system").with(/some_test_proj.csproj/)
			Dummy.run_tests(['some_test_proj.csproj'])
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
	describe 'set_exes_cache' do
		it 'should set runners individually and uniquely' do
			SetExeDummy.should_receive("system").with(/meh$/)
			SetExeDummy.set_exes
			subject = SetExeDummy.get_runners_exes
			subject[subject.keys[0]].should_not == subject[subject.keys[1]]
			subject[subject.keys[0]].should_not == subject[subject.keys[2]]
			subject[subject.keys[1]].should_not == subject[subject.keys[2]]
		end
	end
end