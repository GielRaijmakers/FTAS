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

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#


#add path to the project
addImagePath('../generic.sikuli')
addImagePath('../repository.sikuli')
