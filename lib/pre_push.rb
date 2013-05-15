require "pre_push/version"

module PrePush
  def self.run assemblies
  	spec = Gem::Specification.find_by_name("pre_push")
		gem_root = spec.gem_dir
		gem_lib = gem_root + "/lib"
		puts gem_lib
		puts assemblies
  	system "#{gem_lib}/nunit262/nunit-console.exe '#{assemblies}'"
  end
end
