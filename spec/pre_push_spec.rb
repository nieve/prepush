require 'spec_helper'

class Dummy
	@solution = "solution/path/whammy"
	include PrePush
end

class SetExeDummy
	@solution = 'meh'
	@runner_exe = 'bar.exe'
	@test_runner = 'nunit262'
	def self.get_runner_exe(key)
		@runners_exes[key]
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
	end
	describe 'run_tests' do
		it 'should call system to run tests in specified assemblies' do
			Dummy.should_receive("system").with(/some_test_proj.csproj/)
			Dummy.run_tests(['some_test_proj.csproj'])
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
		it 'should add predefined runner exe' do
			SetExeDummy.should_receive("system").with(/meh$/)
			SetExeDummy.set_exes
			SetExeDummy.get_runner_exe('nunit262').should == 'bar.exe'
		end
	end
end