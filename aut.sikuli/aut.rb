#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#AUT functions for FTAS
#(appication under test)
#Giel Raijmakers
#Version 0.1
# https://github.com/GielRaijmakers/FTAS

#example of def
#def ExampleDef(list)
#    begin
#      wait('image.png',5)  
#      HandelTestStep(list)
#      passed = true
#    rescue
#        ErrorHandler("error", "ExampleDef")         
#        passed = false
#    ensure 
#       WriteToLog("ExampleDef",passed)  
#    end
#end
#example of script line
# ExampleDef("birthdate:22-6-1979;search:<click>;")
#here the function ExampleDef is called, object "birthdate" is filled with the date, and object "seach" is clicked.
#the arguments are being handled by the generic function "HandleTestStep".
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#


#add path to the project
ImagePath.setBundlePath( File.dirname(__FILE__) +"/repository.sikuli")
ImagePath.setBundlePath( File.dirname(__FILE__) +"/generic.sikuli");
require File.dirname(__FILE__) + "/generic.sikuli/generic.rb'"
require File.dirname(__FILE__) + "/repository.sikuli/repository.rb'"