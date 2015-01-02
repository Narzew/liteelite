require "fileutils"
require "zlib"
require "open-uri"
require "./liteelite_functions.rb"
module LE
	def self.get_function_name(line)
		return line.split("\x20").at(0)
	end
	def self.get_argument(line,arg_id)
		return line.split("\x20").at(arg_id)
	end
	def self.get_arguments(line)
		return line.split("\x20").delete_at(0)
	end
	def self.get_command_and_arguments(line)
		return line.split("\x20")
	end
	def self.get_one_big_argument(line)
		return line.split("\x20").delete_at(0)
	end
	def self.generate_function_list
		file = File.open('liteelite.conf','rb')
		data = file.read
		file.close
		s = ""
		s << "case LE.get_function_name(x)\n"
		data.each_line {|x|
		y = x.split(',')
		s << "when \"#{y.at(1)}\" then $result << [#{y.at(0)}"
		mtcount = y.at(2).to_i
		if mtcount == 0
			s << "]\n"
		else
			mtcount.times{|x|
				s << ",LE.get_argument(x,#{x+1})"
			}
			s << "]\n"
		end
		}
		s << "else\nraise\"Compile Error!\"\nend\n"
		return s
	end
	def self.generate_eval_list
		file = File.open('liteelite.conf','rb')
		data = file.read
		file.close
		s = ""
		s << "case function_data\n"
		data.each_line{|x|
		y = x.split(',')
		k = y.at(3).delete("\n")
		s << "when #{y.at(0)} then LE::Functions.#{k}"
		mtcount = y.at(2).to_i
		if mtcount == 0
			s << "\n"
		else
			s << "("
			mtcount.times{|x|
			if x == mtcount-1
				s << "function_args.at(#{x+1})"
			else
				s << "function_args.at(#{x+1}),"
			end
			}
			s << ")\n"
		end
		}
		s << "else\nraise\"Invalid Command!\"\nend\n"
		return s
	end
	def self.compile(sourcefile, output)
		file = File.open(sourcefile, 'rb')
		source = file.read
		file.close
		$result = []
		source.each_line{|x|
		eval(LE.generate_function_list)
		}
		file = File.open(output, 'wb')
		file.write(Zlib::Deflate.deflate(Marshal.dump($result)))
		file.close
	end
	def self.interprete(source)
		$variables = {}
		file = File.open(source, 'rb')
		$result = Marshal.load(Zlib::Inflate.inflate(file.read))
		file.close
		$result.each{|x|
			function_args = x
			function_data = x.at(0)
			x = x.at(1)
			eval(LE.generate_eval_list)
		}
	end
end
begin
	case ARGV[0]
	when 'c'
		if ARGV[2] == nil
			LE.compile(ARGV[1], ARGV[1].gsub('.lel','.lcc').gsub('.lll','.lcc'))
		else
			LE.compile(ARGV[1], ARGV[2])
		end
	when 'i'
		LE.interprete(ARGV[1])
	end
end
