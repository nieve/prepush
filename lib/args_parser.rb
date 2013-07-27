module PrePush
	class ArgsParser
		class << self
			attr_accessor :args_props
			ArgsParser.args_props = {
				'r' => [:runner, :str], 
				'td' => [:test_dlls, :array], 
				'msb' => [:msbuild, :str]
			}
		end
		def self.execute args
			result = {:runner => 'nunit262'}
			return result if args == nil
			args_props.each_pair do |arg, prop|
				current_parsed_arg = args.find {|a| a.start_with?("/#{arg}=")}
				if current_parsed_arg != nil
					value = current_parsed_arg.sub("/#{arg}=", "")
					value = value.split(',') if prop[1] == :array
					result[prop[0]] = value
				end
			end
			result
		end
	end
end