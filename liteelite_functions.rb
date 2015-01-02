module LE
end
module LE::Functions
	def self.le_write(x)
		print x
	end
	def self.le_exit
		exit
	end
	def self.le_spacewrite
		print " "
	end
	def self.le_linewrite
		print "\n"
	end
	def self.le_keywait
		$stdin.gets
	end
	def self.le_fwrite(x)
		print x.gsub!("+", " ")
	end
	def self.le_setvar(x,y)
		$variables[x] = y
	end
	def self.le_getvar(x)
		print $variables[x]
	end
	def self.le_fileread(x)
		file = File.open(x,'rb')
		data = file.read
		file.close
		print data
		data = nil
	end
	def self.le_varfileread(x,y)
		file = File.open(x, 'rb')
		data = file.read
		file.close
		$variables[y] = data
		data = nil
	end
	def self.le_filewrite(x,y)
		file = File.open(y,'wb')
		file.write(x)
		file.close
	end
	def self.le_varfilewrite(x,y)
		file = File.open(y,'wb')
		file.write($variables[x])
		file.close
	end
	def self.le_afilewrite(x,y)
		file = File.open(y,'ab')
		file.write(x)
		file.close
	end
	def self.le_varafilewrite(x,y)
		file = File.open(y,'ab')
		file.write($variables[x])
		file.close
	end
	def self.le_copyfile(x,y)
		FileUtils.cp(x,y)
	end
	def self.le_renamefile(x,y)
		File.rename(x,y)
	end
	def self.le_deletefile(x)
		File.delete(x)
	end
	def self.le_varcopyfile(x,y)
		FileUtils.cp($variables[x], $variables[y])
	end
	def self.le_varrenamefile(x,y)
		File.rename($variables[x],$variables[y])
	end
	def self.le_vardeletefile(x)
		File.delete($variables[x])
	end
	def self.le_prompt(x)
		$variables[x] = $stdin.gets.chomp!
	end
	def self.le_dirlist(x,y)
		z = Dir.entries(x)
		s = ""
		z.each{|p|
			next if p == '.'
			next if p == '..'
			s << "#{p}\n"
		}
		$variables[y] = s
		s = ""
		z = ""
	end
	def self.le_vardirlist(x,y)
		z = Dir.entries($variables[x])
		s = ""
		z.each{|p|
			next if p == '.'
			next if p == '..'
			s << "#{p}\n"
		}
		$variables[y] = s
		s = ""
		z = ""
	end
	def self.le_load(x)
		file = File.open(x,'rb')
		data = file.read
		file.close
		Thread.new { LE.interprete(x) }
	end
	def self.le_ruby(x)
		file = File.open(x,'rb')
		data = file.read
		file.close
		eval(data)
	end
	def self.le_vareql(x,y,z,a)
		if $variables[x] == $variables[y]
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varneql(x,y,z,a)
		if $variables[x] != $variables[y]
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_download(x,y)
		open(x){|f|
			$variables[y] = f.read
		}
		
	end
	def self.le_plus(x,y,z)
		$variables[x] = $variables[y].to_i + $variables[z].to_i
	end
	def self.le_minus(x,y,z)
		$variables[x] = $variables[y].to_i - $variables[z].to_i
	end
	def self.le_mul(x,y,z)
		$variables[x] = $variables[y].to_i * $variables[z].to_i
	end
	def self.le_div(x,y,z)
		$variables[x] = $variables[y].to_i / $variables[z].to_i
	end
	def self.le_modulo(x,y,z)
		$variables[x] = $variables[y].to_i % $variables[z].to_i
	end
	def self.le_xor(x,y,z)
		$variables[x] = $variables[y].to_i * $variables[z].to_i
	end
	def self.le_or(x,y,z)
		$variables[x] = $variables[y].to_i / $variables[z].to_i
	end
	def self.le_and(x,y,z)
		$variables[x] = $variables[y].to_i % $variables[z].to_i
	end
	def self.le_fplus(x,y,z)
		$variables[x] = $variables[y].to_f + $variables[z].to_f
	end
	def self.le_fminus(x,y,z)
		$variables[x] = $variables[y].to_f - $variables[z].to_f
	end
	def self.le_fmul(x,y,z)
		$variables[x] = $variables[y].to_f * $variables[z].to_f
	end
	def self.le_fdiv(x,y,z)
		$variables[x] = $variables[y].to_f / $variables[z].to_f
	end
	def self.le_vargreater(x,y,z,a)
		if $variables[x].to_i > $variables[y].to_i
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varlower(x,y,z,a)
		if $variables[x].to_i < $variables[y].to_i
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varfgreater(x,y,z,a)
		if $variables[x] > $variables[y]
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varflower(x,y,z,a)
		if $variables[x] < $variables[y]
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_vargreatereql(x,y,z,a)
		if $variables[x].to_i >= $variables[y].to_i
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varlowereql(x,y,z,a)
		if $variables[x].to_i <= $variables[y].to_i
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varfgreatereql(x,y,z,a)
		if $variables[x] >= $variables[y]
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_varflowereql(x,y,z,a)
		if $variables[x].to_f <= $variables[y].to_f
			LE::Functions.le_load(z)
		elsif a != nil
			LE::Functions.le_load(a)
		end
	end
	def self.le_vartype(x,y)
		case y
		when 'int' || 'i'
			$variables[x] = $variables[x].to_i
		when 'float' || 'f'
			$variables[x] = $variables[x].to_f
		when 'string' || 's'
			$variables[x] = $variables[x].to_s
		when 'array' || 'a'
			$variables[x] = $variables[x].to_a
		end
	end
	def self.le_strjoin(x,y,z)
		$variables[x] = $variables[y].to_s + $variables[z].to_s
	end
end
