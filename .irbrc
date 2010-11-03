require 'wirble'
require 'rubygems'
#require "hirb"
#require 'bond'
#extend Bond

#require 'bond/completion'

#Bond.start

#Hirb.enable
Wirble.init
Wirble.colorize
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200



if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true
 
  # Display the RAILS ENV in the prompt
  # ie : [Development]>>
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "#{ENV["RAILS_ENV"]} >> ",
   :PROMPT_I => "#{ENV["RAILS_ENV"]} >> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
  

  IRB.conf[:HISTORY_FILE] = "./tmp/irb_history"
end
