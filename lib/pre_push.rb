require "pre_push/version"

module PrePush
	@msbuild = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe'
  def self.run assemblies
		gem_lib = File.dirname(__FILE__)
  	system "#{gem_lib}/nunit262/nunit-console.exe #{assemblies}"
  end
end
