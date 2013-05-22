require "pre_push/version"

module PrePush
	module ClassMethods
		def run
			success = build
			if (!success)
				puts 'build has failed'
				exit(1)
			end
			success = run_tests @assemblies
			if (!success)
				puts 'Tests have failed'
				exit(1)
			end
		end
		def build
			msbuild = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe'
			system "#{msbuild} #{@solution}"
			$?.success?
		end
	  def run_tests assemblies
			gem_lib = File.dirname(__FILE__)
			assemblies = assemblies || [@solution]
			assemblies.each do |assembly|
	  		system "#{gem_lib}/runners/nunit262/nunit-console.exe #{assembly}"
	  		$?.success?
	  	end
	  end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		#receiver.send :include, InstanceMethods
	end
end
# TODO: upon prepush install drop a pre-push hook & a ruby file with module including PrePush & necessary solution/assemblies.