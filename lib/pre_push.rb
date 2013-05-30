require "pre_push/version"

module PrePush
	module ClassMethods
		MSBuildPaths = {:clr4 => 'C:/Windows/Microsoft.NET/Framework/v4.0.30319', :clr2 => 'C:/Windows/Microsoft.NET/Framework/v2.0.50727'}
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
			clr = @clr == nil ? :clr4 : @clr.to_sym
			if MSBuildPaths[clr] == nil
				puts 'please assign clr2 or clr4 to @clr'
				exit(1)
			end
			msbuild = "#{MSBuildPaths[clr]}/MSBuild.exe"
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
				Dir.entries(runners_dir).each {|file| @runners_exes[file] = @runner_exe || Dir.entries("#{runners_dir}/#{file}").detect{|f| f.end_with?('.exe')}}	
				@runners_exes['nunit262'] = @runner_exe || 'nunit-console.exe'
				@runners_exes['mspec'] = @runner_exe || 'mspec-clr4.exe'
				@runners_exes['xunit191'] = @runner_exe || 'xunit.console.exe'
			end
	  end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		#receiver.send :include, InstanceMethods
	end
end