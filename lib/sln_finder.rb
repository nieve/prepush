module PrePush
	class SlnFinder
		def self.find
			try_find_sln('.')
		end

		private
		def self.try_find_sln location
			sln = Dir.entries(location).find {|f| File.file?("#{location}/#{f}") && f.end_with?('.sln')}
			return sln if sln != nil

			dirs = Dir.entries(location).select {|e| !File.file?("#{location}/#{e}") && File.directory?("#{location}/#{e}") && !(/^\.{1,2}$/ =~ e)}
			dirs.each do |dir|
				sln = try_find_sln("#{location}/#{dir}")
				return sln if sln != nil
			end
			sln
		end
	end
end