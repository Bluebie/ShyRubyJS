# July - August 2011
# Library to convert Ruby blocks into Javascript functions
# Originally designed to help build CouchDB map and reduce functions

# Sample usage: 


require 'sourcify'

#TODO: 
# Deal with javascript string immutability.
# Implement a stack for indendation
# Maybe also a stack for variable scope?

module ShyRubyJS

  class ShySexpParser
  
    NL = "\n"
    SPACE = " "
    INDENT = "  " 
  
    def initialize
      literals
      keywords
      functions
      operators
    end
    
    def parse_block(&block)
      parse block.to_sexp(:strip_enclosure => true)
    end
    
    def parse(s_expression)
      return "" unless s_expression
      raise TypeError unless s_expression.class == Sexp
      self.method(s_expression.sexp_type).call(s_expression.sexp_body)
    end
  
    # More methods in the stupid second class definition below
    # TODO: move the back together when dev is finished
  end

  class ShySexpParser
  
    # S EXPRESSION METHODS
    # Corresponding to different "kinds" of S expression
  
    [:and, :or].map { |kw|
      define_method kw do |body|
        return body.map {|x| parse(x)}.join(SPACE + @keywords[kw] + SPACE)
      end
    }
  
    [:block, :scope].map { |sexp|
      define_method sexp do |body|
        return body.map { |x| parse(x) }.join(NL) if body
      end
    }
    [:lvar, :lit].map { |sexp|
      define_method sexp do |body|
        return body[0].to_s if body[0]
      end
    }
  
    def if(body)
      # Processes an if block. Indentation is broken if there are ifs within ifs.
      string = @keywords[:if] + "(" + SPACE + parse(body[0]) + SPACE + ") {" + NL
      if body[1] # if there's actually anything in the if statement
        string += INDENT + parse(body[1]) + NL
      end
      if body[2] # if there's an else block
        string += "}" + @keywords[:else] + "{" + NL
        string += INDENT + parse(body[2])
      end
      string += NL unless string[string.length-1] == "}" or string[string.length-1] == NL
      string += "}"
      return string
    end

    def arglist(body)
      # TODO - Sometimes this needs brackets e.g. eggs.find(5), but sometimes not eg 5 + 1 ie 5.+(1)
      # To solve it needs either to receive information about what preceded it, or refactoring elsewhere
      return "(" + SPACE + body.map { |a| parse(a) }.join(", ") + SPACE + ")" if body[0]
    end

     def args(body)
         return body.map { |a| a.to_s}.join(", ") if body
       end

    def array(body)
      string = ["[", map(body, ", "), "]"].join(SPACE)
    end

    def call(body)    
      subject, method_name, arglist = body
      standard_operator = @operators[method_name] ? true : false
      string = ""
      string += parse(subject)
      string += "." if subject unless standard_operator
      string += SPACE if standard_operator
      string += method_name.to_s
      if arglist.sexp_body.length > 0
        standard_operator ? string += SPACE : string += "("
        string += arglist.sexp_body.map { |a|
          parse(a)
        }.join(", ")
        string += ")" unless standard_operator
      end
      return string
    end
    
    def iter(body)
      body.map { |i| parse(i) }
    end

    def const(body)
      return body[0].to_s
    end

    def defn(body)
      ["function", "(", parse(body[1]), ")", "{", NL,
        INDENT, parse(body[2]), NL,
        "}"].join(SPACE)
    end

    def hash(body)
      string = "{" + NL
      body.each_slice(2) { |k,v| string += INDENT + parse(k) + ":" + SPACE + parse(v) + "," + NL }
      string += "}"
      return string
    end

    # def iter
    #   TODO
    # end

    def lasgn(body)
      [body[0].to_s, @literals[:lit], parse(body[1])].join(SPACE) if body[0] and body[1]
    end
  
    def not(body)
      return @keywords[:!] + map(body)
    end
  
    def return(body)
      return @keywords[:return] + SPACE + parse(body[0])
    end
  
    def str(body)
      return ["\"", body[0], "\""].join if body[0]
    end

    # other methods

    def map(body, join=nil)
      return body.map { |x| parse(x) }.join(join) if body
    end

    def literals
      @literals = {
        :true => "true",
        :false => "false",
        :lit => "=",
      }
    end
    def keywords
      @keywords = {
        :if => "if",
        :else => "else",
        :return => "return",
        :and => "&&",
        :or => "||",
        :! => "!",
      }
    end
    def functions
      @functions = {
        :puts => "alert", 
      }
    end
    def operators
      @operators = {
        :+ => "+",
        :- => "-",
        :>= => ">=",
        :> => ">",
        :<= => "<=",
        :< => "<",
        :* => "*",
        :/ => "/",
        :% => "%",
        :& => "&",
        :| => "|",
        :"^" => "^",
        :== => "==",
        :eql? => "===",
        :equal? => "===",
      }
    end

  end
end