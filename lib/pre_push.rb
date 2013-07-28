require "pre_push/version"
require "msbuild"

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
			system "#{msbuild} #{@solution}"
			$?.success?
		end
	  def run_tests assemblies
			assemblies = assemblies || [@solution]
			assemblies = assemblies.empty? ? [@solution] : assemblies
			success = true
	  	gem_lib = File.dirname(__FILE__)
			assemblies.each do |assembly|
	  		system "#{test_runner_path(gem_lib)} \"#{assembly}\""
	  		success &= $?.success?
	  	end
	  	success
	  end

	  private
	  def msbuild
	  	MSBuild
	  end
	  def test_runner_path gem_lib
	  	"\"#{gem_lib}/runners/#{@test_runner}/#{runners_exes[@test_runner]}\""
	  end
	  def override_msbuild custom_msbuild
	  	define_singleton_method :msbuild do
	  		custom_msbuild
	  	end
	  end
	  def force_test_runner runner_path
	  	define_singleton_method :test_runner_path do |gem_lib|
	  		runner_path
	  	end
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