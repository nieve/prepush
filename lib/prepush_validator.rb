module PrePush
	class Validator
		def self.validate runner
			if !Dir.exists?('.git')
				puts "Couldn't find a git repository"
				return false
			end
			if !Dir.exists?('.git/hooks')
				puts "Couldn't find the git hooks dir"
				return false
			end
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