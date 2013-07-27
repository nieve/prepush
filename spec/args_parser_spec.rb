require 'spec_helper'

module PrePush
	describe ArgsParser do
		describe 'execute' do
			describe "when no args provided" do
				it "should return default" do
					result = PrePush::ArgsParser.execute(nil)
					result[:runner].should == "nunit262"
				end
			end
			describe "when /r is specfied" do
				it "should parse value as a string" do
					result = PrePush::ArgsParser.execute(["/r=mspec,invalid,data"])
					result[:runner].should == "mspec,invalid,data"
				end
				it "should return a result with a runner" do
					result = PrePush::ArgsParser.execute(["/r=mspec"])
					result[:runner].should == "mspec"
				end
			end
			describe "when /msb is specfied" do
				it "should return a result with a string msbuild" do
					result = PrePush::ArgsParser.execute(["/msb=path/to/custom/msbuild.exe"])
					result[:msbuild].should == "path/to/custom/msbuild.exe"
				end
			end
			describe "when /td is specified" do
				it "should parse value as an array" do
					result = PrePush::ArgsParser.execute(["/td=./path/to/testable.dll"])
					result[:test_dlls].should == ["./path/to/testable.dll"]
				end
				it "should return a result with multiple test dlls" do
					result = PrePush::ArgsParser.execute(["/td=./path/to/testable.dll,./path/to/another.dll"])
					result[:test_dlls].should == ["./path/to/testable.dll","./path/to/another.dll"]
				end
			end
		end
	end
end