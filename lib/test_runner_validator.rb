module PrePush
	class TestRunnerValidator
		def self.validate runner
			bin = File.dirname(__FILE__)
			runners_dir = "#{bin}/../lib/runners"
			found = false
			Dir.entries(runners_dir).each {|file| found = true if file == runner}
			unless found
				puts "Couldn't find test runner #{runner}"
				return false
			end
			return true
		end
	end
end