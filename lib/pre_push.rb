require "pre_push/version"

module PrePush
	module ClassMethods
		MSBuildPaths = {:clr4 => 'C:/Windows/Microsoft.NET/Framework/v4.0.30319'}
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
			system "#{msbuild} #{@solution}"
			$?.success?
		end
	  def run_tests assemblies
	  	gem_lib = File.dirname(__FILE__)
			assemblies = assemblies || [@solution]
			assemblies = assemblies.empty? ? [@solution] : assemblies
			success = true
			assemblies.each do |assembly|
				exe = runners_exes[@test_runner]
	  		system "\"#{gem_lib}/runners/#{@test_runner}/#{exe}\" \"#{assembly}\""
	  		success &= $?.success?
	  	end
	  	success
	  end

	  private
	  def msbuild
	  	'C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe'
	  end
	  def runners_exes
	  	{
				'mspec' => 'mspec-clr4.exe',
				'nunit262' => 'nunit-console.exe',
				'xunit191' => 'xunit.console.exe'
			}	  	
	  end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		#receiver.send :include, InstanceMethods
	end
end