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
			set_exes_cache
			msbuild = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe'
			system "#{msbuild} #{@solution}"
			$?.success?
		end
	  def run_tests assemblies
	  	puts '1'
	  	set_exes_cache
	  	puts '2'
			gem_lib = File.dirname(__FILE__)
	  	puts '3'
			assemblies = assemblies || [@solution]
	  	puts assemblies
			assemblies.each do |assembly|
				puts assembly
				exe = @runners_exes[@test_runner]
				puts exe
	  		puts "#{gem_lib}/runners/#{@test_runner}/#{exe} #{assembly}"
	  		system "#{gem_lib}/runners/#{@test_runner}/#{exe} #{assembly}"
	  		puts 'ran'
	  		puts $?.success?
	  		$?.success?
	  	end
	  end

	  private
	  def set_exes_cache
	  	if (@runners_exes == nil || @runners_exes.empty?) then
				@runners_exes = {}
		  	bin = File.dirname(__FILE__)
				runners_dir = "#{bin}/../lib/runners"
				Dir.entries(runners_dir).each {|file| @runners_exes[file] = Dir.entries("#{runners_dir}/#{file}").detect{|f| f.end_with?('.exe')}}	
			end
	  end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		#receiver.send :include, InstanceMethods
	end
end