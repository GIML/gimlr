module GIMLR
  extend self

  TYPES = [':text:', ':num:', ':list:', ':vlist:'].freeze
  TYPE_CHAR = ':'.freeze
  COMMENT_CHAR = '#'.freeze
  LIST_NEW_LINE_CHAR = '-'.freeze

  def parse(content)
    result = {}
    var = nil
    var_type = nil
    content.each_line do |line|
      var, var_type, result = parse_line line, result, var, var_type
    end

    result
  end

  def parse_file(file_path)
    result = {}
    var = nil
    var_type = nil
    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        var, var_type, result = parse_line line, result, var, var_type
      end
    end

    result
  end

  private

  def parse_line(line, result, var, var_type)
    return var, var_type, result if line.start_with? COMMENT_CHAR
    if line.start_with?(TYPE_CHAR) && TYPES.find { |t| line.start_with? t }
      var_type, var = line.split(' ')
    elsif var
      case var_type
      when TYPES[0]
        result[var] ||= ''
        result[var] << line
      when TYPES[1]
        if line.chomp != ''
          if line =~ /\./
            result[var] = line.to_f
          else
            result[var] = line.to_i
          end
        end
      when TYPES[2]
        if line[2..-1]
          result[var] ||= []
          result[var] += line.
            gsub('\, ', '\,\ ').
            split(', ').
            map { |it| it.gsub('\,\ ', ', ').chomp }
        end
      else
        if line[2..-1]
          result[var] ||= []
          if line.start_with? LIST_NEW_LINE_CHAR
            result[var] << line[2..-1].chomp
          end
        end
      end
    end

    [var, var_type, result]
  end

end
