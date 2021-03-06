module Gimlr
  extend self

  TYPES = [':text:', ':num:', ':list:', ':vlist:'].freeze
  TYPE_CHAR = ':'.freeze
  COMMENT_CHAR = '#'.freeze
  LIST_NEW_LINE_CHAR = '-'.freeze

  def parse_string(content)
    parse content
  end

  def parse_file(file_path)
    File.open(file_path, 'r') do |f|
      parse f
    end
  end

  private

  def parse(enum)
    result = {}
    var = nil
    var_type = nil
    enum.each_line do |line|
      var, var_type, result = parse_line line, result, var, var_type
    end
    result.each { |k,v| result[k] = v.strip if v.is_a?(String) }

    result
  end

  def parse_line(line, result, var, var_type)
    return var, var_type, result if line.start_with? COMMENT_CHAR
    if line.start_with?(TYPE_CHAR) && TYPES.find { |t| line.start_with? t }
      var_type, var = line.split(' ')
    elsif var
      case var_type
      when TYPES[0]
        parse_text(line, var, result)
      when TYPES[1]
        parse_num(line, var, result)
      when TYPES[2]
        parse_list(line, var, result)
      else
        parse_vlist(line, var, result)
      end
    end

    [var, var_type, result]
  end

  def parse_text(line, var, result)
    result[var] ||= ''
    result[var] << line
  end

  def parse_num(line, var, result)
    if line.chomp != ''
      if line =~ /\./
        result[var] = line.to_f
      else
        result[var] = line.to_i
      end
    end
  end

  def parse_list(line, var, result)
    if line[2..-1]
      result[var] ||= []
      result[var] += line.
        gsub('\, ', '\,\ ').
        split(', ').
        map { |it| it.gsub('\,\ ', ', ').chomp }
      if result[var].last.end_with?(',') && !result[var].last.end_with?('\,')
        last = result[var].pop
        result[var] << last[0..-2]
      end
    end
  end

  def parse_vlist(line, var, result)
    if line[2..-1]
      result[var] ||= []
      if line.start_with? LIST_NEW_LINE_CHAR
        result[var] << line[2..-1].chomp
      end
    end
  end

end
