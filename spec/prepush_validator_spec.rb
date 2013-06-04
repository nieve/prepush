require 'spec_helper'

module PrePush
	describe Validator do
		describe 'validate' do
			it "should fail when a .git dir doesn't exit" do
				Dir.stub('exists?').with('.git').and_return(false)
				PrePush::Validator.should_receive('puts').with("Couldn't find a git repository")
				PrePush::Validator.validate('nunit262').should be false
			end
			it "should fail when a .git/hooks dir doesn't exit" do
				Dir.stub('exists?').with('.git').and_return(true)
				Dir.stub('exists?').with('.git/hooks').and_return(false)
				PrePush::Validator.should_receive('puts').with("Couldn't find the git hooks dir")
				PrePush::Validator.validate('nunit262').should be false
			end
			it "should fail when runner not found" do
				Dir.stub('exists?').with('.git').and_return(true)
				Dir.stub('exists?').with('.git/hooks').and_return(true)
				PrePush::Validator.should_receive('puts').with(/^Couldn't find test runner non-existant-runner/)
				PrePush::Validator.validate('non-existant-runner').should be false
			end
			it "should validate when runner found" do
				Dir.stub('exists?').with('.git').and_return(true)
				Dir.stub('exists?').with('.git/hooks').and_return(true)
				Dir.stub('entries').with(/lib\/runners$/).and_return(['existant-runner.rb'])
				PrePush::Validator.validate('existant-runner').should be true
			end
		end
	end
end