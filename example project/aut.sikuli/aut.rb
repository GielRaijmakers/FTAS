#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#generic functions for FTAS
#Giel Raijmakers
#Version 0.1
# https://github.com/GielRaijmakers/FTAS
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

#add path to the project
#addImagePath('../repository.sikuli')
#addImagePath('../aut.sikuli')

###############################################
# when a script needs to be executed
###############################################
def StripProjectDir(projectPath)
    puts "in strip dir " + projectPath 
    path = projectPath.split("/")
    projectPath.slice! path[path.length-1].to_s
    return projectPath.to_s
end


puts "path: " + File.dirname(__FILE__) 
path = StripProjectDir(File.dirname(__FILE__))
ImagePath.setBundlePath( path +"/repository.sikuli");
ImagePath.setBundlePath( path +"/generic.sikuli")
require path + "/generic.sikuli/generic.rb"
require path + "/repository.sikuli/repository.rb"


#require 'C:\jruby-9.0.0.0\lib\ruby\gems\shared\gems\sikulix-1.1.0.3\lib\sikulix.rb'

#include Sikulix
#ImagePath.add('D:\tests\Github\FTAS\FTAS\example project\calc.sikuli')
Settings.setShowActions(false)


def Numbers(list)
    begin      
puts  "in numbers" + list
      HandelTestStep(list)
      passed = true
    rescue 
        ErrorHandler("error", "Numbers")         
        passed = false
    ensure 
       WriteToLog("Numbers",passed)  
    end
end

def MathExpressions(list)
    begin       
      HandelTestStep(list)
      passed = true
    rescue
        ErrorHandler("error", "MathExpressions")         
        passed = false
    ensure 
       WriteToLog("MathExpressions",passed)  
    end

end

def SwitchCalculatorType(kind)
    begin  
        case kind
            when "standard"
                 keyDown(Key.ALT + "1")
            when "scientific" 
                 keyDown(Key.ALT + "2")    
            when "programmer"
                 keyDown(Key.ALT + "3")
            when "statistic"
                 keyDown(Key.ALT + "4")				 
        end
		passed = true
    rescue
        ErrorHandler("error", "SwitchCalculatorType")         
        passed = false
    ensure 
       WriteToLog("SwitchCalculatorType",passed)  
    end
end

def StartCalculator()
   begin 
    IO.popen 'C:\\windows\system32\\calc.exe'
    end
end


#StartCalculator()
#Numbers('1:<click>;2:<click>;')
#Numbers('1:<click>;')
#MathExpressions('plus:<click>;')
#Numbers('1:<click>;2:<click>;')
#MathExpressions('is:<click>;')
#SwitchCalculatorType("scientific")