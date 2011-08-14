require 'irb'
require_relative '../lib/ShyRubyJS.rb'

  $parser = ShyRubyJS::ShySexpParser.new
  $sexps = []
def parse_block(&block)
  sexp = block.to_sexp(:strip_enclosure => true)
  $sexps << {"kind"=>sexp[0], "sexp"=>sexp}
  puts $parser.parse($sexps.last["sexp"])
  puts "\n"
rescue TypeError, NameError => e
  $e = e
  puts e.class
  puts e.message
  puts e.backtrace
rescue NameError => e
end

def view(&block)
  sexp = block.to_sexp(:strip_enclosure => true)
  $sexps << {"kind"=>sexp[0], "sexp"=>sexp}
  puts $parser.parse($sexps.last["sexp"])
  puts "\n"
rescue TypeError, NameError => e
  $e = e
  puts e.class
  puts e.message
  puts e.backtrace
rescue NameError => e
end

def dump
  # Spits out all the S expressions
  puts $sexps.map { |s| s["sexp"].inspect}.join("\n\n")
end

# blocks for testing

parse_block { 
  if x == "yep"
    y = "butt"
  elsif x == "do"
      x = "boot"
  end
}
 
parse_block {
  eggs(5)
}

parse_block {
  eggs(5 + 1)
}

 # parse_block {
 #   begin
 #     puts 1
 #   end while true
 # }
 
 # parse_block {
 #   while true
 #     puts 1
 #   end
 # }
 
# parse_block {
#   x = {"1"=>"2", "3"=>"4"}
# }
 
parse_block {
  x = [1,2,[3,3],4,5,6]
}

parse_block {
  x = []
}

parse_block {
  eggs(5 + 1)
}

parse_block {
  x = 1
  x = 2
}

parse_block {
  def function(doc)
    x = 1
  end
}

parse_block {
  return 1 + 8
}

parse_block {
  x = 1
  y = 2
  if x and y
    puts "1"
  end
}

parse_block {
  if x or y
    puts "1"
  end
}

# # Actual map functions:
parse_block {
 def function(doc)
   if doc.age and doc.name
     emit(doc.age, doc.name)
   end
 end
}
parse_block {
  if !x
    y = 1
  end
}

parse_block {
  hash = {"butt"=>"leg",
    "boot"=>[1,2],
    "bott"=>apples,
    "buggs"=>{"head"=>"leg"}
  }
}

view {
  def function(doc)
    if doc.kind == "post" and !doc.hidden
      emit(doc)
    end
  end
}

IRB.start