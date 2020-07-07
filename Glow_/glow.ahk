#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DllName = client_panorama.dll
Process, Exist, csgo.exe
If (ErrorLevel = 0)
{
msgbox, Run "Counter-Strike: Global Offensive" then start the cheat =P BTW this is coded by INTENSECOW on the UC forms that is the safe download
ExitApp
}
Process, Exist, csgo.exe
PID = %ErrorLevel%
Client := GetDllBase(DllName, PID)
while (!Client){
Process, Exist, csgo.exe
PID = %ErrorLevel%
Client := GetDllBase(DllName, PID)
msgbox Error could not find CLIENT.DLL %Client%
}
xxy = csgo.exe
ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
z := 1
xc := 0
r := 1
b := 1
g := 1
a := 1
bToggle := 1
bhoptoggle := 0
fovvalue := 90
glowtoggle := 0
radar := 0
IniRead, bToggle, Settings.INI, Settings, bToggle, 0
IniRead, a, Settings.INI, Settings, a, 0.8
IniRead, r, Settings.INI, Settings, r, 1
IniRead, b, Settings.INI, Settings, b, 0
IniRead, g, Settings.INI, Settings, g, 1
IniRead, bhoptoggle, Settings.INI, Settings, bhoptoggle, 0
IniRead, fovvalue, Settings.INI, Settings, fovvalue, 90
IniRead, glowtoggle, Settings.INI, Settings, glowtoggle, 0
IniRead, radar, Settings.INI, Settings, radar, 0
IniRead, LocalPlayer, Settings.INI, Offsets, LocalPlayer, 0xCBD6B4
IniRead, glowobjectmanger, Settings.INI, Offsets, glowobjectmanger, 0x520DAD8
IniRead, entitylist, Settings.INI, Offsets, entitylist, 0x4CCDCBC
IniRead, glowindexz, Settings.INI, Offsets, glowindexz, 0xA3F8
IniRead, spotted, Settings.INI, Offsets, spotted, 0x93D
IniRead, health, Settings.INI, Offsets, health, 0x100
IniRead, team, Settings.INI, Offsets, team, 0xF4
IniRead, fov, Settings.INI, Offsets, fov, 0x31E4
IniRead, flags, Settings.INI, Offsets, flags, 0x104
IniWrite, %LocalPlayer%, Settings.INI, Offsets, LocalPlayer
IniWrite, %glowobjectmanger%, Settings.INI, Offsets, glowobjectmanger
IniWrite, %entitylist%, Settings.INI, Offsets, entitylist
IniWrite, %glowindexz%, Settings.INI, Offsets, glowindexz
IniWrite, %fov%, Settings.INI, Offsets, fov
IniWrite, %spotted%, Settings.INI, Offsets, spotted
IniWrite, %health%, Settings.INI, Offsets, health
IniWrite, %team%, Settings.INI, Offsets, team
IniWrite, %flags%, Settings.INI, Offsets, flags
sleep 50
Gui, Color, 030003,
Gui, -caption +toolwindow +AlwaysOnTop
gui, font, s15 w800 Q3, Stika Banner
gui, Margin, 9, -0.42
Gui, add, text, Xtv CB100B1 vText8 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText7 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText6 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText5 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText4 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText3 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText2 TransColor,   This cheat was made by Intensecow on UC forms
Gui, add, text, Xtv CB100B1 vText1 TransColor,   This cheat was made by Intensecow on UC forms
Gui, Show, % "x" A_ScreenWidth-1910 " y" A_ScreenHeight-400 ,xex
WinSet, TransColor, 030003 160, xex
loop
{
winget, proc, ProcessName, A
if (proc != xxy){
continue
}
if (z = 64){
z:= 1
}
if(xc = 30000){
DllCall("Sleep",UInt,1)
}
localadress :=ReadMemory( Client + LocalPlayer ,PID,ProcessHandle)
Ent :=ReadMemory(Client+entitylist + (z * 0x10 ),PID,ProcessHandle)
if (!localadress){
sleep 20
continue
}
glowobj :=ReadMemory(client+glowobjectmanger,PID,ProcessHandle)
WriteMemoryUChar( localadress + fov, fovvalue, PID)
if (bhoptoggle){
if (GetKeyState("Space", "P") ){
player_flags:=ReadMemory(localadress + flags ,PID,ProcessHandle)
if (player_flags = 0x101 || player_flags = 0x107){
send, {Space}
}
}
}
if (Ent <> localadress){
ent_spotted :=ReadMemory(Ent + spotted ,PID,ProcessHandle)
ent_health:=ReadMemory(Ent + health ,PID,ProcessHandle)
entTeam :=ReadMemory(Ent + team,PID,ProcessHandle)
Myteam :=ReadMemory(localadress + team,PID,ProcessHandle)
if (glowobj && ent_health > 0 && entTeam<>Myteam){
if (glowtoggle){
glowindex :=ReadMemory(Ent+glowindexz,PID,ProcessHandle)
WriteMemoryfloat(r,glowobj + ((glowindex*0x38)+0x4),PID)
WriteMemoryfloat(g,glowobj + ((glowindex*0x38)+0x8),PID)
WriteMemoryfloat(b,glowobj + ((glowindex*0x38)+0xC) ,PID)
WriteMemoryfloat(a,glowobj + ((glowindex*0x38)+0x10) ,PID)
WriteMemoryUChar( glowobj + ((glowindex*0x38)+0x24), 1, PID)
WriteMemoryUChar( glowobj + ((glowindex*0x38)+0x25), 0, PID)
WriteMemoryUChar( glowobj + ((glowindex*0x38)+0x2C), bToggle, PID)
}
}
}
xc := xc + 1
z := z + 1
}
NumpadClear::
GuiControl, % (toggle8 := !toggle8 ) ? "Hide" : "Show", Text8
GuiControl, % (toggle7 := !toggle7 ) ? "Hide" : "Show", Text7
GuiControl, % (toggle6 := !toggle6 ) ? "Hide" : "Show", Text6
GuiControl, % (toggle5 := !toggle5 ) ? "Hide" : "Show", Text1
GuiControl, % (toggle1 := !toggle1 ) ? "Hide" : "Show", Text2
GuiControl, % (toggle2 := !toggle2 ) ? "Hide" : "Show", Text3
GuiControl, % (toggle3 := !toggle3 ) ? "Hide" : "Show", Text4
GuiControl, % (toggle4 := !toggle4 ) ? "Hide" : "Show", Text5
return
NumpadUp::
if(page > 7){
page := 7
}else{
page := page + 1
}
if(page = 9)
{
page:= 8
}
if (page = 1 ){
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,<Glow Red is %r%>
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 2 )
{
if (bhoptoggle){
GuiControl,,Text2,<bhop is on>
}else{
GuiControl,,Text2,<bhop is off>
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 3 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,<Fov Value is %fovvalue%>
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 4 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,<Glow is on>
}else{
GuiControl,,Text4,<Glow is off>
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 5 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,<Glow Green is %g%>
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 6 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,<Glow Blue is %b%>
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 7 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,<Wall glow>
}else if (bToggle = 1){
GuiControl,,Text7,<Model glow>
}else if (bToggle = 2){
GuiControl,,Text7,<Static Outline>
}else{
GuiControl,,Text7,<Blinking Outline>
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 8 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,<Glow Alpha is %a%>
}
return
NumpadDown::
if(page < 1){
page := 1
}
else{
page := page - 1
}
if(page = 0){
page:= 1
}
if (page = 1 ){
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,<Glow Red is %r%>
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 2 )
{
if (bhoptoggle){
GuiControl,,Text2,<bhop is on>
}else{
GuiControl,,Text2,<bhop is off>
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 3 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,<Fov Value is %fovvalue%>
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 4 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,<Glow is on>
}else{
GuiControl,,Text4,<Glow is off>
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 5 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,<Glow Green is %g%>
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 6 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,<Glow Blue is %b%>
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 7 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,<Wall glow>
}else if (bToggle = 1){
GuiControl,,Text7,<Model glow>
}else if (bToggle = 2){
GuiControl,,Text7,<Static Outline>
}else{
GuiControl,,Text7,<Blinking Outline>
}
GuiControl,,Text8,Glow Alpha is %a%
}
else if (page = 8 )
{
if (bhoptoggle){
GuiControl,,Text2,bhop is on
}else{
GuiControl,,Text2,bhop is off
}
GuiControl,,Text3,Fov Value is %fovvalue%
if (glowtoggle){
GuiControl,,Text4,Glow is on
}else{
GuiControl,,Text4,Glow is off
}
GuiControl,,Text1,Glow Red is %r%
GuiControl,,Text5,Glow Green is %g%
GuiControl,,Text6,Glow Blue is %b%
if(bToggle = 0){
GuiControl,,Text7,Wall glow
}else if (bToggle = 1){
GuiControl,,Text7,Model glow
}else if (bToggle = 2){
GuiControl,,Text7,Static Outline
}else{
GuiControl,,Text7,Blinking Outline
}
GuiControl,,Text8,<Glow Alpha is %a%>
}
return
NumpadRight::
if(page = 1 ){
r := r + 0.05
if(r > 1)
{r:= 1
}
GuiControl,,Text1,<Glow Red is %r%>
IniWrite, %r%, Settings.INI, Settings, r
return
}else if (page = 2)
{
bhoptoggle := 1
GuiControl,,Text2,<bhop is on>
IniWrite, %bhoptoggle%, Settings.INI, Settings, bhoptoggle
return
}else if (page = 3)
{
fovvalue := fovvalue + 1
GuiControl,,Text3,<Fov Value is %fovvalue%>
IniWrite, %fovvalue%, Settings.INI, Settings, fovvalue
return
}else if (page = 4)
{
glowtoggle := 1
GuiControl,,Text4,<Glow is on>
IniWrite, %glowtoggle%, Settings.INI, Settings, glowtoggle
return
}
else if(page = 5 ){
g := g + 0.05
if(g > 1)
{g:= 1
}
GuiControl,,Text5,<Glow Red is %g%>
IniWrite, %g%, Settings.INI, Settings, g
return
} else if(page = 6 ){
b := b + 0.05
if(b > 1)
{b:= 1
}
GuiControl,,Text6,<Glow Red is %b%>
IniWrite, %b%, Settings.INI, Settings, b
return
}
else if(page = 7 ){
bToggle:= bToggle + 1
if (bToggle > 3){
bToggle = 3
}
if(bToggle = 0){
GuiControl,,Text7,<Wall glow>
}else if (bToggle = 1){
GuiControl,,Text7,<Model glow>
}else if (bToggle = 2){
GuiControl,,Text7,<Static Outline>
}else{
GuiControl,,Text7,<Blinking Outline>
}
IniWrite, %bToggle%, Settings.INI, Settings, bToggle
return
}
else if(page = 8 )
{
a := a + 0.05
if(a > 1)
{a:= 1
}
GuiControl,,Text8,<Glow Red is %a%>
IniWrite, %a%, Settings.INI, Settings, a
return
}
return
NumpadLeft::
if(page = 1 ){
r := r - 0.05
if(r < 0)
{r:= 0
}
GuiControl,,Text1,<Glow Red is %r%>
IniWrite, %r%, Settings.INI, Settings, r
return
}else if (page = 2)
{
bhoptoggle := 0
GuiControl,,Text2,<bhop is off>
IniWrite, %bhoptoggle%, Settings.INI, Settings, bhoptoggle
return
}else if (page = 3)
{
fovvalue := fovvalue - 1
GuiControl,,Text3,<Fov Value is %fovvalue%>
IniWrite, %fovvalue%, Settings.INI, Settings, fovvalue
return
}else if (page = 4)
{
glowtoggle := 0
GuiControl,,Text4,<Glow is off>
IniWrite, %glowtoggle%, Settings.INI, Settings, glowtoggle
return
}
else if(page = 5 ){
g := g - 0.05
if(g < 0)
{g:= 0
}
GuiControl,,Text5,<Glow Red is %g%>
IniWrite, %g%, Settings.INI, Settings, g
return
} else if(page = 6 ){
b := b - 0.05
if(b < 0)
{b:= 0
}
GuiControl,,Text6,<Glow Red is %b%>
IniWrite, %b%, Settings.INI, Settings, b
return
}
else if(page = 7 ){
bToggle:= bToggle - 1
if (bToggle < 0){
bToggle = 0
}
if(bToggle = 0){
GuiControl,,Text7,<Wall glow>
}else if (bToggle = 1){
GuiControl,,Text7,<Model glow>
}else if (bToggle = 2){
GuiControl,,Text7,<Static Outline>
}else{
GuiControl,,Text7,<Blinking Outline>
}
IniWrite, %bToggle%, Settings.INI, Settings, bToggle
return
}
else if(page = 8 )
{
a := a - 0.05
if(a < 0)
{a:= 0
}
GuiControl,,Text8,<Glow Red is %a%>
IniWrite, %a%, Settings.INI, Settings, a
return
}
return
GetDllBase(DllName, PID = 0)
{
SetFormat, Integer, Hex
TH32CS_SNAPMODULE := 0x00000008
INVALID_HANDLE_VALUE = -1
VarSetCapacity(me32, 548, 0)
NumPut(548, me32)
snapMod := DllCall("CreateToolhelp32Snapshot", "Uint", TH32CS_SNAPMODULE
, "Uint", PID)
If (snapMod = INVALID_HANDLE_VALUE) {
SetFormat, Integer, D
Return 0
}
If (DllCall("Module32First", "Uint", snapMod, "Uint", &me32)){
while(DllCall("Module32Next", "Uint", snapMod, "UInt", &me32)) {
If !DllCall("lstrcmpi", "Str", DllName, "UInt", &me32 + 32) {
DllCall("CloseHandle", "UInt", snapMod)
SetFormat, Integer, D
Return NumGet(&me32 + 20)
}
}
}
DllCall("CloseHandle", "Uint", snapMod)
SetFormat, Integer, D
Return 0
}
WriteMemoryUChar( adress, value, PID = 0){
ProcessHandle := DllCall("OpenProcess", "UInt", 2035711, "char", 0, "UInt", PID, "Ptr")
DllCall("WriteProcessMemory", "Ptr", ProcessHandle, "Ptr", adress, "UChar*", value, "Ptr", 1, "Ptr", 0)
DllCall("CloseHandle", "Ptr", ProcessHandle)
return
}
ReadMemory(MADDRESS,PID = 0, ProcessHandle = -1)
{
VarSetCapacity(MVALUE,4,0)
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)
Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
SetFormat, Integer, D
return, result
}
WriteMemoryfloat(value, adress, PID = 0){
ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", adress, "float*", value, "Uint", 8, "Uint *", 0)
DllCall("CloseHandle", "int", ProcessHandle)
return
}
~*End::ExitApp
return
~*Home::Reload
return
~*Del::ExitApp
return
