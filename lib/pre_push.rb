require "pre_push/version"

module PrePush
	module ClassMethods
		def run
			success = build
			if (!success)
				puts 'build has failed'
				exit(1)
			end
			success = run_tests(@assemblies)
			if (!success)
				puts 'Tests have failed'
				exit(1)
			end
		end
		def build
			set_exes_cache
			msbuild = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe'
			system "#{msbuild} #{@solution}"
			$?.success?
		end
	  def run_tests assemblies
	  	set_exes_cache
			gem_lib = File.dirname(__FILE__)
			assemblies = assemblies || [@solution]
			success = true
			assemblies.each do |assembly|
				exe = @runners_exes[@test_runner]
	  		system "\"#{gem_lib}/runners/#{@test_runner}/#{exe}\" \"#{assembly}\""
	  		success &= $?.success?
	  	end
	  	success
	  end

	  private
	  def set_exes_cache
	  	if (@runners_exes == nil || @runners_exes.empty?) then
				@runners_exes = {}
		  	bin = File.dirname(__FILE__)
				runners_dir = "#{bin}/../lib/runners"
				Dir.entries(runners_dir).each {|file| @runners_exes[file] = Dir.entries("#{runners_dir}/#{file}").detect{|f| f.end_with?('.exe')}}	
				@runners_exes['nunit262'] = 'nunit-console.exe'
			end
	  end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		#receiver.send :include, InstanceMethods
	end
end