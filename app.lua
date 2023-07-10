-- Written by https://github.com/acoatoitgs
-- WriteIt version 1.0

local monitor = peripheral.find("monitor")
local monitorSize = monitor.getSize()
local currentString = ""
local scale = 1
local monitorTextColor = 0

--#region Utils
function RoundNumber(n)
    return math.floor(n + 0.5)
end

function ResetTerminal()
    term.clear()
    term.setCursorPos(1, 1)
end

function WriteString(s)
    monitor.clear()
    monitorSize = monitor.getSize()
    local lines = require "cc.strings".wrap(s, monitorSize)

    for i = 1, #lines do
        monitor.setCursorPos(1, i)
        monitor.write(lines[i])
    end

    currentString = s
end

function ChooseColor()
    print("Choose your color: ")

    print("1 - Red")
    print("2 - Green")
    print("3 - Blue")

    print("4 - Yellow")
    print("5 - Cyan")
    print("6 - Magenta")

    print("7 - White")
    print("8 - Black")

    local input = io.read("*l")

    if input == "1" then return colors.red end
    if input == "2" then return colors.green end
    if input == "3" then return colors.blue end

    if input == "4" then return colors.yellow end
    if input == "5" then return colors.cyan end
    if input == "6" then return colors.magenta end

    if input == "7" then return colors.white end
    if input == "8" then return colors.black end



    return false
end

function WriteCredit()
    term.setCursorPos(1, 17)
    print("WriteIt version 1.0")
    term.setCursorPos(1, 19)
end

--#endregion

function WaitForInput()
    ResetTerminal()
    term.setTextColor(colors.green)
    print("What do you want to do?")
    print()
    term.setTextColor(colors.white)

    print("1: Write message on monitor")
    print("2: Clear monitor")
    print()
    print("3: Change font size")
    print("4: Change text color")
    print("5: Change background color")

    print()
    print()
    term.setTextColor(colors.red)
    print("To quit hold CTRL-T for 1 second...")
    term.setTextColor(colors.white)

    WriteCredit()


    local input = io.read("*l")

    if (input == "1") then
        WriteMonitor()
    elseif (input == "2") then
        ClearMonitor()
    elseif (input == "3") then
        EditFontSize()
    elseif (input == "4") then
        EditTextColor()
    elseif (input == "5") then
        EditBackgroundColor()
    else
        print("Invalid input")
        WaitForInput()
    end
end

--#region Functions
function WriteMonitor()
    ResetTerminal()

    print("Type your string: ")

    local s = io.read("*l")

    WriteString(s)

    print()
    print("Message written succesfully")
    sleep(2)
    WaitForInput()
end

function ClearMonitor()
    ResetTerminal()

    monitor.clear()
    monitor.setCursorPos(1, 1)

    currentString = ""

    print("Monitor cleared succesfully")
    sleep(2)
    WaitForInput()
end

function EditFontSize()
    ResetTerminal()
    print("Insert the font size ( 0.5 - 5 ): ")

    local input = tonumber(io.read("*l"))

    if input then
        scale = input
        scale = RoundNumber(scale * 2) / 2 -- Round to 0.5 steps

        monitor.setTextScale(scale)

        WriteString(currentString)

        print("Font size changed succesfully")
    else
        print("Invalid number")
    end

    sleep(2)
    WaitForInput()
end

function EditTextColor()
    ResetTerminal()

    local color = ChooseColor()

    if not color then
        print("Invalid color")
        sleep(2)
        WaitForInput()
    end

    monitor.setTextColor(color)

    WriteString(currentString)

    print("Color changed succesfully")
    sleep(2)
    WaitForInput()
end

function EditBackgroundColor()
    ResetTerminal()

    local color = ChooseColor()

    if not color then
        print("Invalid color")
        sleep(2)
        WaitForInput()
    end

    monitor.setBackgroundColor(color)

    WriteString(currentString)

    print("Color changed succesfully")
    sleep(2)
    WaitForInput()
end

--#endregion


WaitForInput()
