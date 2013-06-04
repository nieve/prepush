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
			found = Dir.entries(runners_dir).any?{|file| file == "#{runner}.rb"}
			unless found
				all = Dir.entries(runners_dir).select{|f| !File.directory? f}.join(', ')
				puts "Couldn't find test runner #{runner} in #{all}"
				return false
			end
			return true
		end
	end
end