require 'spec_helper'

module PrePush
	describe SlnFinder do
		describe 'find' do
			it "should return first sln file found" do
				Dir.stub('entries').and_return(['second.sln','first.sln'])
				File.stub('file?').with(anything()).and_return(true)
				PrePush::SlnFinder.find().should == 'second.sln'
			end
			it "should return nested sln when none found at top level" do
				Dir.stub('entries').with('.').and_return(['second.sn','first.sl', 'nested'])
				Dir.stub('entries').with('./nested').and_return(['third.sn', 'first.sln', 'second.sln','fourth.sl', 'inner'])
				File.stub('file?').with('./nested').and_return(false)
				File.stub('file?').with('./nested/third.sn').and_return(false)
				File.stub('file?').with('./nested/first.sln').and_return(true)
				File.stub('file?').with('./second.sn').and_return(true)
				File.stub('file?').with('./first.sl').and_return(true)
				File.stub('file?').with('./first.sln').and_return(true)
				File.stub('file?').with('./second.sln').and_return(true)
				File.stub('directory?').with('./nested').and_return(true)
				PrePush::SlnFinder.find().should == 'first.sln'
			end
			it "should disregard . and .. directories" do
				Dir.stub('entries').with('.').and_return(['second.sn','.', '..'])
				File.stub('file?').with('./second.sn').and_return(true)
				File.stub('file?').with('./.').and_return(false)
				File.stub('file?').with('./..').and_return(false)
				File.stub('directory?').with('./.').and_return(true)
				File.stub('directory?').with('./..').and_return(true)
				Dir.should_not_receive(:entries).with('./.')
				Dir.should_not_receive(:entries).with('./..')
				PrePush::SlnFinder.find().should be_nil
			end
		end
	end
end