#NoTrayIcon
#RequireAdmin
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <String.au3>
#include "MetroGUI-UDF\MetroGUI_UDF.au3"
#include <ComboConstants.au3>
#include <GUIListBox.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <NoMadMemory.au3>

If @compiled Then
	If $cmdline[0] = 0 Then
		Run(@ScriptFullPath & " /ErrorStdOut /restarted")
		Exit
	EndIf
EndIf

HotKeySet("{INS}", "_OnTop")
Global $OnTop = 0
Global $Config = "settings.cfg"
Global $GlowList = "Terrorist|Defuser|Weapon|HE Grenade|Thrown HE Grenade|Flashbang|Thrown Flashbang|Smoke Grenade|Thrown Smoke Grenade|Decoy|Thrown Decoy|Molotov|Thrown Molotov"
Global $Client = 0, $Engine = 0

$Exename = ""
Dim $aSpace[3]
For $i = 1 To 25
	$aSpace[0] = Chr(Random(65, 90, 1)) ;A-Z
	$aSpace[1] = Chr(Random(97, 122, 1)) ;a-z
	$aSpace[2] = Chr(Random(48, 57, 1)) ;0-9
	$Exename &= $aSpace[Random(0, 2, 1)]
Next

_SetTheme()
_Metro_EnableHighDPIScaling()

Global $GUI = _Metro_CreateGUI($Exename, 700, 400, -1, -1, True)

_Metro_SetGUIOption($GUI, True, False)
$Control_Buttons = _Metro_AddControlButtons(True, False, False, False, False)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]

_Metro_SetGUIOption($GUI, True, False)

GUICtrlCreateLabel("Advanced Glow v1.4 by Flo", 32, 12, 250, 21)
GUICtrlSetFont(-1, 14, 800, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateGroup("General", 32, 52, 200, 300)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFFFFFF)

Global $GlowCheckbox = _Metro_CreateCheckbox("Glow", 56, 84, 70, 24)
Global $EnemyOnlyCheckbox = _Metro_CreateCheckbox("Enemy Only", 56, 126, 116, 24)
Global $HealthGlowCheckbox = _Metro_CreateCheckbox("Health Glow", 56, 168, 120, 24)
Global $DefuseGlowCheckbox = _Metro_CreateCheckbox("Defuse Glow", 56, 208, 120, 24)
Global $WeaponGlowCheckbox = _Metro_CreateCheckbox("Weapon Glow", 56, 250, 130, 24)
Global $NadeGlowCheckbox = _Metro_CreateCheckbox("Nade Glow", 56, 292, 110, 24)

GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("Color", 237, 52, 430, 300)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", 0, "wstr", 0)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateLabel("Entity:", 261, 84, 70, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$EntityCombo = GUICtrlCreateCombo("Counter-Terrorist", 325, 84, 145, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))
GUICtrlSetData(-1, $GlowList)

GUICtrlCreateLabel("Red:", 261, 126, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$RedSlider = GUICtrlCreateSlider(320, 124, 255, 25)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetBkColor(-1, 0x212121)
$RedOut = GUICtrlCreateLabel("0", 590, 126, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateLabel("Green:", 261, 168, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$GreenSlider = GUICtrlCreateSlider(320, 166, 255, 25)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetBkColor(-1, 0x212121)
$GreenOut = GUICtrlCreateLabel("0", 590, 168, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateLabel("Blue:", 261, 208, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$BlueSlider = GUICtrlCreateSlider(320, 206, 255, 25)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetBkColor(-1, 0x212121)
GUICtrlSetData(-1, 255)
$BlueOut = GUICtrlCreateLabel("0", 590, 208, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateLabel("Alpha:", 261, 250, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$AlphaSlider = GUICtrlCreateSlider(320, 248, 255, 25)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetBkColor(-1, 0x212121)
GUICtrlSetData(-1, 255)
$AlphaOut = GUICtrlCreateLabel("0", 590, 250, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateLabel("Color:", 261, 292, 50, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
$ColorOutput = GUICtrlCreateLabel("", 330, 292, 240, 21)
GUICtrlSetFont(-1, 12, 400, 0, "Calibri")

GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlSetData($RedSlider, IniRead($Config, "Counter-Terrorist", "Red", "0"))
GUICtrlSetData($RedOut, IniRead($Config, "Counter-Terrorist", "Red", "0"))
GUICtrlSetData($GreenSlider, IniRead($Config, "Counter-Terrorist", "Green", "0"))
GUICtrlSetData($GreenOut, IniRead($Config, "Counter-Terrorist", "Green", "0"))
GUICtrlSetData($BlueSlider, IniRead($Config, "Counter-Terrorist", "Blue", "0"))
GUICtrlSetData($BlueOut, IniRead($Config, "Counter-Terrorist", "Blue", "0"))
GUICtrlSetData($AlphaSlider, IniRead($Config, "Counter-Terrorist", "Alpha", "210"))
GUICtrlSetData($AlphaOut, IniRead($Config, "Counter-Terrorist", "Alpha", "210"))
GUICtrlSetBkColor($ColorOutput, "0x" & Hex(GUICtrlRead($RedSlider), 2) & Hex(GUICtrlRead($GreenSlider), 2) & Hex(GUICtrlRead($BlueSlider), 2))

_LoadConfig()

GUISetState(@SW_SHOW)

While 1
	If ControlGetFocus($GUI) Then
		_Metro_HoverCheck_Loop($GUI)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
				If ProcessExists("csgo.exe") Then
					$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
					$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
					If $IsConnected = 6 Then
						_MemoryWrite($EngineBase + $nForceFullUpdate, $Process, -1, "int")
					EndIf
					_MemoryWrite($Client + $UpdateSpecGlow, $Process, 0x74, "byte")
				EndIf
				_Metro_GUIDelete($GUI)
				Exit
			Case $EntityCombo
				$SelectedEntity = GUICtrlRead($EntityCombo)
				GUICtrlSetData($RedSlider, IniRead($Config, $SelectedEntity, "Red", "0"))
				GUICtrlSetData($RedOut, IniRead($Config, $SelectedEntity, "Red", "0"))
				GUICtrlSetData($GreenSlider, IniRead($Config, $SelectedEntity, "Green", "0"))
				GUICtrlSetData($GreenOut, IniRead($Config, $SelectedEntity, "Green", "0"))
				GUICtrlSetData($BlueSlider, IniRead($Config, $SelectedEntity, "Blue", "0"))
				GUICtrlSetData($BlueOut, IniRead($Config, $SelectedEntity, "Blue", "0"))
				GUICtrlSetData($AlphaSlider, IniRead($Config, $SelectedEntity, "Alpha", "210"))
				GUICtrlSetData($AlphaOut, IniRead($Config, $SelectedEntity, "Alpha", "210"))
				GUICtrlSetBkColor($ColorOutput, "0x" & Hex(GUICtrlRead($RedSlider), 2) & Hex(GUICtrlRead($GreenSlider), 2) & Hex(GUICtrlRead($BlueSlider), 2))

			Case $GlowCheckbox
				If _Metro_CheckboxIsChecked($GlowCheckbox) Then
					_Metro_CheckboxUnCheck($GlowCheckbox)
					IniWrite($Config, "Glow", "Glow", "0")
					Global $Glow = 0
					If ProcessExists("csgo.exe") Then
						$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
						$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
						If $IsConnected = 6 Then
							_MemoryWrite($EngineBase + $nForceFullUpdate, $Process, -1, "int")
						EndIf
					EndIf
				Else
					_Metro_CheckboxCheck($GlowCheckbox)
					IniWrite($Config, "Glow", "Glow", "1")
					Global $Glow = 1
				EndIf

			Case $EnemyOnlyCheckbox
				If _Metro_CheckboxIsChecked($EnemyOnlyCheckbox) Then
					_Metro_CheckboxUnCheck($EnemyOnlyCheckbox)
					IniWrite($Config, "Glow", "Enemy Only", "0")
					Global $EnemyOnly = 0
				Else
					_Metro_CheckboxCheck($EnemyOnlyCheckbox)
					IniWrite($Config, "Glow", "Enemy Only", "1")
					Global $EnemyOnly = 1
				EndIf

			Case $HealthGlowCheckbox
				If _Metro_CheckboxIsChecked($HealthGlowCheckbox) Then
					_Metro_CheckboxUnCheck($HealthGlowCheckbox)
					IniWrite($Config, "Glow", "Health Glow", "0")
					Global $HealthGlow = 0
				Else
					_Metro_CheckboxCheck($HealthGlowCheckbox)
					IniWrite($Config, "Glow", "Health Glow", "1")
					Global $HealthGlow = 1
				EndIf

			Case $DefuseGlowCheckbox
				If _Metro_CheckboxIsChecked($DefuseGlowCheckbox) Then
					_Metro_CheckboxUnCheck($DefuseGlowCheckbox)
					IniWrite($Config, "Glow", "Defuse Glow", "0")
					Global $DefuseGlow = 0
					If ProcessExists("csgo.exe") Then
						$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
						$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
						If $IsConnected = 6 Then
							_MemoryWrite($EngineBase + $nForceFullUpdate, $Process, -1, "int")
						EndIf
					EndIf
				Else
					_Metro_CheckboxCheck($DefuseGlowCheckbox)
					IniWrite($Config, "Glow", "Defuse Glow", "1")
					Global $DefuseGlow = 1
				EndIf

			Case $WeaponGlowCheckbox
				If _Metro_CheckboxIsChecked($WeaponGlowCheckbox) Then
					_Metro_CheckboxUnCheck($WeaponGlowCheckbox)
					IniWrite($Config, "Glow", "Weapon Glow", "0")
					Global $WeaponGlow = 0
					If ProcessExists("csgo.exe") Then
						$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
						$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
						If $IsConnected = 6 Then
							_MemoryWrite($EngineBase + $nForceFullUpdate, $Process, -1, "int")
						EndIf
					EndIf
				Else
					_Metro_CheckboxCheck($WeaponGlowCheckbox)
					IniWrite($Config, "Glow", "Weapon Glow", "1")
					Global $WeaponGlow = 1
				EndIf

			Case $NadeGlowCheckbox
				If _Metro_CheckboxIsChecked($NadeGlowCheckbox) Then
					_Metro_CheckboxUnCheck($NadeGlowCheckbox)
					IniWrite($Config, "Glow", "Nade Glow", "0")
					Global $NadeGlow = 0
					If ProcessExists("csgo.exe") Then
						$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
						$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
						If $IsConnected = 6 Then
							_MemoryWrite($EngineBase + $nForceFullUpdate, $Process, -1, "int")
						EndIf
					EndIf
				Else
					_Metro_CheckboxCheck($NadeGlowCheckbox)
					IniWrite($Config, "Glow", "Nade Glow", "1")
					Global $NadeGlow = 1
				EndIf
		EndSwitch

		If _IsPressed(01) And _WinAPI_GetDlgCtrlID(ControlGetHandle($GUI, "", ControlGetFocus($GUI))) = $RedSlider Or _WinAPI_GetDlgCtrlID(ControlGetHandle($GUI, "", ControlGetFocus($GUI))) = $GreenSlider Or _WinAPI_GetDlgCtrlID(ControlGetHandle($GUI, "", ControlGetFocus($GUI))) = $BlueSlider Or _WinAPI_GetDlgCtrlID(ControlGetHandle($GUI, "", ControlGetFocus($GUI))) = $AlphaSlider Then
			$SelectedEntity = GUICtrlRead($EntityCombo)
			IniWrite($Config, $SelectedEntity, "Red", GUICtrlRead($RedSlider))
			IniWrite($Config, $SelectedEntity, "Green", GUICtrlRead($GreenSlider))
			IniWrite($Config, $SelectedEntity, "Blue", GUICtrlRead($BlueSlider))
			IniWrite($Config, $SelectedEntity, "Alpha", GUICtrlRead($AlphaSlider))
			GUICtrlSetData($RedOut, GUICtrlRead($RedSlider))
			GUICtrlSetData($GreenOut, GUICtrlRead($GreenSlider))
			GUICtrlSetData($BlueOut, GUICtrlRead($BlueSlider))
			GUICtrlSetData($AlphaOut, GUICtrlRead($AlphaSlider))
			GUICtrlSetBkColor($ColorOutput, "0x" & Hex(GUICtrlRead($RedSlider), 2) & Hex(GUICtrlRead($GreenSlider), 2) & Hex(GUICtrlRead($BlueSlider), 2))
			Global $CTRed = IniRead($Config, "Counter-Terrorist", "Red", "0")
			Global $CTGreen = IniRead($Config, "Counter-Terrorist", "Green", "0")
			Global $CTBlue = IniRead($Config, "Counter-Terrorist", "Blue", "0")
			Global $CTAlpha = IniRead($Config, "Counter-Terrorist", "Alpha", "0")

			Global $TRed = IniRead($Config, "Terrorist", "Red", "0")
			Global $TGreen = IniRead($Config, "Terrorist", "Green", "0")
			Global $TBlue = IniRead($Config, "Terrorist", "Blue", "0")
			Global $TAlpha = IniRead($Config, "Terrorist", "Alpha", "0")

			Global $DefuserRed = IniRead($Config, "Defuser", "Red", "0")
			Global $DefuserGreen = IniRead($Config, "Defuser", "Green", "0")
			Global $DefuserBlue = IniRead($Config, "Defuser", "Blue", "0")
			Global $DefuserAlpha = IniRead($Config, "Defuser", "Alpha", "0")

			Global $WeaponRed = IniRead($Config, "Weapon", "Red", "0")
			Global $WeaponGreen = IniRead($Config, "Weapon", "Green", "0")
			Global $WeaponBlue = IniRead($Config, "Weapon", "Blue", "0")
			Global $WeaponAlpha = IniRead($Config, "Weapon", "Alpha", "0")

			Global $HERed = IniRead($Config, "HE Grenade", "Red", "0")
			Global $HEGreen = IniRead($Config, "HE Grenade", "Green", "0")
			Global $HEBlue = IniRead($Config, "HE Grenade", "Blue", "0")
			Global $HEAlpha = IniRead($Config, "HE Grenade", "Alpha", "0")

			Global $ThrownHERed = IniRead($Config, "Thrown HE Grenade", "Red", "0")
			Global $ThrownHEGreen = IniRead($Config, "Thrown HE Grenade", "Green", "0")
			Global $ThrownHEBlue = IniRead($Config, "Thrown HE Grenade", "Blue", "0")
			Global $ThrownHEAlpha = IniRead($Config, "Thrown HE Grenade", "Alpha", "0")

			Global $FlashbangRed = IniRead($Config, "Flashbang", "Red", "0")
			Global $FlashbangGreen = IniRead($Config, "Flashbang", "Green", "0")
			Global $FlashbangBlue = IniRead($Config, "Flashbang", "Blue", "0")
			Global $FlashbangAlpha = IniRead($Config, "Flashbang", "Alpha", "0")

			Global $ThrownFlashbangRed = IniRead($Config, "Thrown Flashbang", "Red", "0")
			Global $ThrownFlashbangGreen = IniRead($Config, "Thrown Flashbang", "Green", "0")
			Global $ThrownFlashbangBlue = IniRead($Config, "Thrown Flashbang", "Blue", "0")
			Global $ThrownFlashbangAlpha = IniRead($Config, "Thrown Flashbang", "Alpha", "0")

			Global $SmokeRed = IniRead($Config, "Smoke Grenade", "Red", "0")
			Global $SmokeGreen = IniRead($Config, "Smoke Grenade", "Green", "0")
			Global $SmokeBlue = IniRead($Config, "Smoke Grenade", "Blue", "0")
			Global $SmokeAlpha = IniRead($Config, "Smoke Grenade", "Alpha", "0")

			Global $ThrownSmokeRed = IniRead($Config, "Thrown Smoke Grenade", "Red", "0")
			Global $ThrownSmokeGreen = IniRead($Config, "Thrown Smoke Grenade", "Green", "0")
			Global $ThrownSmokeBlue = IniRead($Config, "Thrown Smoke Grenade", "Blue", "0")
			Global $ThrownSmokeAlpha = IniRead($Config, "Thrown Smoke Grenade", "Alpha", "0")

			Global $DecoyRed = IniRead($Config, "Decoy", "Red", "0")
			Global $DecoyGreen = IniRead($Config, "Decoy", "Green", "0")
			Global $DecoyBlue = IniRead($Config, "Decoy", "Blue", "0")
			Global $DecoyAlpha = IniRead($Config, "Decoy", "Alpha", "0")

			Global $ThrownDecoyRed = IniRead($Config, "Thrown Decoy", "Red", "0")
			Global $ThrownDecoyGreen = IniRead($Config, "Thrown Decoy", "Green", "0")
			Global $ThrownDecoyBlue = IniRead($Config, "Thrown Decoy", "Blue", "0")
			Global $ThrownDecoyAlpha = IniRead($Config, "Thrown Decoy", "Alpha", "0")

			Global $MolotovRed = IniRead($Config, "Molotov", "Red", "0")
			Global $MolotovGreen = IniRead($Config, "Molotov", "Green", "0")
			Global $MolotovBlue = IniRead($Config, "Molotov", "Blue", "0")
			Global $MolotovAlpha = IniRead($Config, "Molotov", "Alpha", "0")

			Global $ThrownMolotovRed = IniRead($Config, "Thrown Molotov", "Red", "0")
			Global $ThrownMolotovGreen = IniRead($Config, "Thrown Molotov", "Green", "0")
			Global $ThrownMolotovBlue = IniRead($Config, "Thrown Molotov", "Blue", "0")
			Global $ThrownMolotovAlpha = IniRead($Config, "Thrown Molotov", "Alpha", "0")
			Sleep(50)
		EndIf
	EndIf

	If ProcessExists("csgo.exe") Then
		If $Client = 0 Or $Engine = 0 Then
			_Scan()
		EndIf
		$EngineBase = _MemoryRead($Engine + $EnginePointer, $Process, "dword")
		$IsConnected = _MemoryRead($EngineBase + $IsIngame, $Process, "dword")
		If $IsConnected = 6 Then
			$Localbase = _MemoryRead($Client + $Localplayer, $Process, "dword")
			If $Localbase Then
				$GlowPtr = _MemoryRead($Client + $GlowObjectBase, $Process, "dword")
				$objectCount = _MemoryRead($Client + $GlowObjectBase + 0xC, $Process, "int")
				$Localteam = _MemoryRead($Localbase + $m_iTeamNum, $Process, "int")
				If $Glow = 1 Or $DefuseGlow = 1 Then
					_MemoryWrite($Client + $UpdateSpecGlow, $Process, 0xEB, "byte")
				Else
					_MemoryWrite($Client + $UpdateSpecGlow, $Process, 0x74, "byte")
				EndIf
				For $i = 1 To $objectCount
					$Entity = _MemoryRead($GlowPtr + 0x38 * $i, $Process, "int")
					$Buffer = _MemoryRead($Entity + 0x8, $Process, "int")
					$Buffer = _MemoryRead($Buffer + 0x8, $Process, "int")
					$Buffer = _MemoryRead($Buffer + 0x1, $Process, "int")
					$ClassID = _MemoryRead($Buffer + 0x14, $Process, "int")
					Switch $ClassID
						Case 40 ;Player
							If $Glow = 1 Or $DefuseGlow = 1 Then
								$Dormant = _MemoryRead($Entity + $m_bDormant, $Process, "dword")
								If $Dormant = 1 Then
									ContinueLoop
								EndIf

								$Health = _MemoryRead($Entity + $m_iHealth, $Process, "dword")
								$EntityTeam = _MemoryRead($Entity + $m_iTeamNum, $Process, "dword")
								$IsDefusing = _MemoryRead($Entity + $m_bIsDefusing, $Process, "dword")

								$Red = 0
								$Green = 0
								$Blue = 0
								$Alpha = 0

								If $Glow = 1 Then
									If $EntityTeam = 2 Then
										$Red = $TRed
										$Green = $TGreen
										$Blue = $TBlue
										$Alpha = $TAlpha
									EndIf
									If $EntityTeam = 3 Then
										$Red = $CTRed
										$Green = $CTGreen
										$Blue = $CTBlue
										$Alpha = $CTAlpha
									EndIf
									If $HealthGlow = 1 Then
										If $Health > 100 Then
											$Health = 100
										EndIf
										$Red = (255 * (100 - $Health) / 100) + 90
										If $Red > 255 Then $Red = 255
										$Green = (255 * $Health) / 100
										If $Green > 255 Then $Green = 255
										$Blue = 0
									EndIf
								EndIf

								If $DefuseGlow = 1 Then
									If $IsDefusing = 1 Then
										$Red = $DefuserRed
										$Green = $DefuserGreen
										$Blue = $DefuserBlue
										$Alpha = $DefuserAlpha
									EndIf
								EndIf

								If $EnemyOnly = 1 Then
									If $Localteam <> $EntityTeam Then
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $Red / 255, "float") ;Red
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $Green / 255, "float") ;Green
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $Blue / 255, "float") ;Blue
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $Alpha / 255, "float") ;Alpha
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
										_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
									EndIf
								Else
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $Red / 255, "float") ;Red
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $Green / 255, "float") ;Green
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $Blue / 255, "float") ;Blue
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $Alpha / 255, "float") ;Alpha
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
								EndIf
							EndIf
						Case 9 ;nade
							If $NadeGlow = 1 Then
								$model_t = _MemoryRead($Entity + 0x6C, $Process, "dword")
								$Modelname = _MemoryRead($model_t + 0x4, $Process, "char[64]")
								If StringInStr($Modelname, "fraggrenade_dropped.mdl") Then
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownHERed / 255, "float") ;Red
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownHEGreen / 255, "float") ;Green
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownHEBlue / 255, "float") ;Blue
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownHEAlpha / 255, "float") ;Alpha
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
								ElseIf StringInStr($Modelname, "flashbang_dropped.mdl") Then
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownFlashbangRed / 255, "float") ;Red
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownFlashbangGreen / 255, "float") ;Green
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownFlashbangBlue / 255, "float") ;Blue
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownFlashbangAlpha / 255, "float") ;Alpha
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
								EndIf
							EndIf

						Case 107 ;Knife
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 108 ;KnifeGG
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 155 ;smoke
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $SmokeRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $SmokeGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $SmokeBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $SmokeAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 156 ;smoke air
							If $NadeGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownSmokeRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownSmokeGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownSmokeBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownSmokeAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 1 ;AK
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render

							EndIf
						Case 128 ;planted c4
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 34 ;c4
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 260 ;scar
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 231 ;aug
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 232 ;awp
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 234 ;bizon
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 238 ;elite
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 239 ;famas
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 240 ;fiveseven
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 241 ;G3SG1
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 242 ;galil
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 244 ;glock
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 245 ;p2000
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 246 ;m249
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 248 ;m4a1
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 271 ;usp
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 249 ;mac10
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 250 ;mag7
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 252 ;mp7
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 253 ;mp9
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 254 ;negev
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 255 ;nova
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 257 ;p250
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 258 ;p90
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 259 ;sawdoff
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 266 ;scout
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 264 ;sg556
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 268 ;tec9
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 267 ;Tazer
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 270 ;ump
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 272 ;XM1014
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 46 ;deagle
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $WeaponRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $WeaponGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $WeaponBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $WeaponAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 77 ;flashbang
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $FlashbangRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $FlashbangGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $FlashbangBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $FlashbangAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 96 ;he
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $HERed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $HEGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $HEBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $HEAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 112 ;molotov
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $MolotovRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $MolotovGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $MolotovBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $MolotovAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 113 ;molotov air
							If $NadeGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownMolotovRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownMolotovGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownMolotovBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownMolotovAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 99 ;incendiary
							If $NadeGlow = 1 Then
								$model_t = _MemoryRead($Entity + 0x6C, $Process, "dword")
								$Modelname = _MemoryRead($model_t + 0x4, $Process, "char[64]")
								If StringInStr($Modelname, "dropped") Then
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $MolotovRed / 255, "float") ;Red
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $MolotovGreen / 255, "float") ;Green
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $MolotovBlue / 255, "float") ;Blue
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $MolotovAlpha / 255, "float") ;Alpha
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
								Else
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownMolotovRed / 255, "float") ;Red
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownMolotovGreen / 255, "float") ;Green
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownMolotovBlue / 255, "float") ;Blue
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownMolotovAlpha / 255, "float") ;Alpha
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
									_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
								EndIf
							EndIf
						Case 47 ;decoy
							If $WeaponGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $DecoyRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $DecoyGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $DecoyBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $DecoyAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
						Case 48 ;decoy air
							If $NadeGlow = 1 Then
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x4), $Process, $ThrownDecoyRed / 255, "float") ;Red
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x8), $Process, $ThrownDecoyGreen / 255, "float") ;Green
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0xC), $Process, $ThrownDecoyBlue / 255, "float") ;Blue
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x10), $Process, $ThrownDecoyAlpha / 255, "float") ;Alpha
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x24), $Process, True, "bool") ;Render
								_MemoryWrite($GlowPtr + ((0x38 * $i) + 0x25), $Process, False, "bool") ;Render
							EndIf
					EndSwitch
				Next
			EndIf
		EndIf
	Else
		Global $Client = 0
		Global $Engine = 0
	EndIf
WEnd

Func _LoadConfig()
	If IniRead($Config, "Glow", "Glow", "0") = 1 Then
		_Metro_CheckboxCheck($GlowCheckbox)
		Global $Glow = 1
	Else
		_Metro_CheckboxUnCheck($GlowCheckbox)
		Global $Glow = 0
	EndIf
	If IniRead($Config, "Glow", "Enemy Only", "0") = 1 Then
		_Metro_CheckboxCheck($EnemyOnlyCheckbox)
		Global $EnemyOnly = 1
	Else
		_Metro_CheckboxUnCheck($EnemyOnlyCheckbox)
		Global $EnemyOnly = 0
	EndIf
	If IniRead($Config, "Glow", "Health Glow", "0") = 1 Then
		_Metro_CheckboxCheck($HealthGlowCheckbox)
		Global $HealthGlow = 1
	Else
		_Metro_CheckboxUnCheck($HealthGlowCheckbox)
		Global $HealthGlow = 0
	EndIf
	If IniRead($Config, "Glow", "Defuse Glow", "0") = 1 Then
		_Metro_CheckboxCheck($DefuseGlowCheckbox)
		Global $DefuseGlow = 1
	Else
		_Metro_CheckboxUnCheck($DefuseGlowCheckbox)
		Global $DefuseGlow = 0
	EndIf
	If IniRead($Config, "Glow", "Weapon Glow", "0") = 1 Then
		_Metro_CheckboxCheck($WeaponGlowCheckbox)
		Global $WeaponGlow = 1
	Else
		_Metro_CheckboxUnCheck($WeaponGlowCheckbox)
		Global $WeaponGlow = 0
	EndIf
	If IniRead($Config, "Glow", "Nade Glow", "0") = 1 Then
		_Metro_CheckboxCheck($NadeGlowCheckbox)
		Global $NadeGlow = 1
	Else
		_Metro_CheckboxUnCheck($NadeGlowCheckbox)
		Global $NadeGlow = 0
	EndIf

	Global $CTRed = IniRead($Config, "Counter-Terrorist", "Red", "0")
	Global $CTGreen = IniRead($Config, "Counter-Terrorist", "Green", "0")
	Global $CTBlue = IniRead($Config, "Counter-Terrorist", "Blue", "0")
	Global $CTAlpha = IniRead($Config, "Counter-Terrorist", "Alpha", "0")

	Global $TRed = IniRead($Config, "Terrorist", "Red", "0")
	Global $TGreen = IniRead($Config, "Terrorist", "Green", "0")
	Global $TBlue = IniRead($Config, "Terrorist", "Blue", "0")
	Global $TAlpha = IniRead($Config, "Terrorist", "Alpha", "0")

	Global $DefuserRed = IniRead($Config, "Defuser", "Red", "0")
	Global $DefuserGreen = IniRead($Config, "Defuser", "Green", "0")
	Global $DefuserBlue = IniRead($Config, "Defuser", "Blue", "0")
	Global $DefuserAlpha = IniRead($Config, "Defuser", "Alpha", "0")

	Global $WeaponRed = IniRead($Config, "Weapon", "Red", "0")
	Global $WeaponGreen = IniRead($Config, "Weapon", "Green", "0")
	Global $WeaponBlue = IniRead($Config, "Weapon", "Blue", "0")
	Global $WeaponAlpha = IniRead($Config, "Weapon", "Alpha", "0")

	Global $HERed = IniRead($Config, "HE Grenade", "Red", "0")
	Global $HEGreen = IniRead($Config, "HE Grenade", "Green", "0")
	Global $HEBlue = IniRead($Config, "HE Grenade", "Blue", "0")
	Global $HEAlpha = IniRead($Config, "HE Grenade", "Alpha", "0")

	Global $ThrownHERed = IniRead($Config, "Thrown HE Grenade", "Red", "0")
	Global $ThrownHEGreen = IniRead($Config, "Thrown HE Grenade", "Green", "0")
	Global $ThrownHEBlue = IniRead($Config, "Thrown HE Grenade", "Blue", "0")
	Global $ThrownHEAlpha = IniRead($Config, "Thrown HE Grenade", "Alpha", "0")

	Global $FlashbangRed = IniRead($Config, "Flashbang", "Red", "0")
	Global $FlashbangGreen = IniRead($Config, "Flashbang", "Green", "0")
	Global $FlashbangBlue = IniRead($Config, "Flashbang", "Blue", "0")
	Global $FlashbangAlpha = IniRead($Config, "Flashbang", "Alpha", "0")

	Global $ThrownFlashbangRed = IniRead($Config, "Thrown Flashbang", "Red", "0")
	Global $ThrownFlashbangGreen = IniRead($Config, "Thrown Flashbang", "Green", "0")
	Global $ThrownFlashbangBlue = IniRead($Config, "Thrown Flashbang", "Blue", "0")
	Global $ThrownFlashbangAlpha = IniRead($Config, "Thrown Flashbang", "Alpha", "0")

	Global $SmokeRed = IniRead($Config, "Smoke Grenade", "Red", "0")
	Global $SmokeGreen = IniRead($Config, "Smoke Grenade", "Green", "0")
	Global $SmokeBlue = IniRead($Config, "Smoke Grenade", "Blue", "0")
	Global $SmokeAlpha = IniRead($Config, "Smoke Grenade", "Alpha", "0")

	Global $ThrownSmokeRed = IniRead($Config, "Thrown Smoke Grenade", "Red", "0")
	Global $ThrownSmokeGreen = IniRead($Config, "Thrown Smoke Grenade", "Green", "0")
	Global $ThrownSmokeBlue = IniRead($Config, "Thrown Smoke Grenade", "Blue", "0")
	Global $ThrownSmokeAlpha = IniRead($Config, "Thrown Smoke Grenade", "Alpha", "0")

	Global $DecoyRed = IniRead($Config, "Decoy", "Red", "0")
	Global $DecoyGreen = IniRead($Config, "Decoy", "Green", "0")
	Global $DecoyBlue = IniRead($Config, "Decoy", "Blue", "0")
	Global $DecoyAlpha = IniRead($Config, "Decoy", "Alpha", "0")

	Global $ThrownDecoyRed = IniRead($Config, "Thrown Decoy", "Red", "0")
	Global $ThrownDecoyGreen = IniRead($Config, "Thrown Decoy", "Green", "0")
	Global $ThrownDecoyBlue = IniRead($Config, "Thrown Decoy", "Blue", "0")
	Global $ThrownDecoyAlpha = IniRead($Config, "Thrown Decoy", "Alpha", "0")

	Global $MolotovRed = IniRead($Config, "Molotov", "Red", "0")
	Global $MolotovGreen = IniRead($Config, "Molotov", "Green", "0")
	Global $MolotovBlue = IniRead($Config, "Molotov", "Blue", "0")
	Global $MolotovAlpha = IniRead($Config, "Molotov", "Alpha", "0")

	Global $ThrownMolotovRed = IniRead($Config, "Thrown Molotov", "Red", "0")
	Global $ThrownMolotovGreen = IniRead($Config, "Thrown Molotov", "Green", "0")
	Global $ThrownMolotovBlue = IniRead($Config, "Thrown Molotov", "Blue", "0")
	Global $ThrownMolotovAlpha = IniRead($Config, "Thrown Molotov", "Alpha", "0")
EndFunc   ;==>_LoadConfig

Func _OnTop()
	If $OnTop = 0 Then
		WinActivate($GUI)
		WinSetOnTop($GUI, "", 1)
		Global $OnTop = 1
	Else
		WinSetOnTop($GUI, "", 0)
		WinActivate("Counter-Strike: Global Offensive")
		Global $OnTop = 0
	EndIf
EndFunc   ;==>_OnTop

Func _Scan()
	$Localplayer_Pattern = "\x8D\x34\x85\x00\x00\x00\x00\x89\x15\x00\x00\x00\x00\x8B\x41\x08\x8B\x48\x04\x83\xF9\xFF"
	$Localplayer_Mask = "xxx????xx????xxxxxxxxx"
	$Glow_Pattern = "\x0F\x11\x05\x00\x00\x00\x00\x83\xC8\x01\xC7\x05\x00\x00\x00\x00\x00\x00\x00\x00"
	$Glow_Mask = "xxx????xxxxx????xxxx"
	$Engine_Pattern = "\xA1\x00\x00\x00\x00\x8B\x88\x00\x00\x00\x00\x85\xC9\x74\x15"
	$Engine_Mask = "x????xx????xxxx"
	$GlowUpdate_Pattern = "\x74\x07\x8B\xCB\xE8\x00\x00\x00\x00\x83\xC7\x10"
	$GlowUpdate_Mask = "xxxxx????xxx"
	$modelAmbientMin_Pattern = "\xF3\x00\x00\x00\x00\x00\x00\x00\xF3\x0F\x11\x4C\x24\x20\x8B\x44\x24\x20\x35\x00\x00\x00\x00\x89\x44\x24\x0C"
	$modelAmbientMin_Mask = "x???????xxxxxxxxxxx????xxxx"

	$WorkingDir = _GetProcessPath(ProcessExists("csgo.exe"))
	$ClientPath = StringReplace($WorkingDir, ".exe", "\bin\client.dll")
	$ClientPanoramaPath = StringReplace($WorkingDir, ".exe", "\bin\client_panorama.dll")
	$EnginePath = StringReplace($WorkingDir, "csgo.exe", "bin\engine.dll")
	$ClientSize = FileGetSize($ClientPath)
	$ClientPanoramaSize = FileGetSize($ClientPanoramaPath)
	$EngineSize = FileGetSize($EnginePath)

	Do
		Global $Client = _MemoryModuleGetBaseAddress(ProcessExists("csgo.exe"), "client.dll")
		Global $ClientPanorama = _MemoryModuleGetBaseAddress(ProcessExists("csgo.exe"), "client_panorama.dll")
		Global $Engine = _MemoryModuleGetBaseAddress(ProcessExists("csgo.exe"), "engine.dll")
	Until $Client <> 0 Or $ClientPanorama <> 0 And $Engine <> 0

	If $ClientPanorama <> 0 Then
		Global $Client = $ClientPanorama
		Global $ClientEnd = $Client + "0x" & Hex($ClientPanoramaSize, 6)
	Else
		Global $ClientEnd = $Client + "0x" & Hex($ClientSize, 6)
	EndIf

	Global $EngineEnd = $Engine + "0x" & Hex($EngineSize, 6)
	Global $Process = _MemoryOpen(ProcessExists("csgo.exe"))

	$Localplayer_Scan = (_MemoryScanEx($Process, $Localplayer_Pattern, $Localplayer_Mask, False, $Client, $ClientEnd) + 3)
	Global $Localplayer = "0x" & StringFormat("%X", _MemoryRead($Localplayer_Scan, $Process, "dword") + 4 - $Client)

	$Glow_Scan = _MemoryScanEx($Process, $Glow_Pattern, $Glow_Mask, False, $Client, $ClientEnd)
	Global $GlowObjectBase = "0x" & StringFormat("%X", _MemoryRead($Glow_Scan + 0x3, $Process, "dword") - $Client)

	$Enginepointer_Scan = _MemoryScanEx($Process, $Engine_Pattern, $Engine_Mask, False, $Engine, $EngineEnd)
	Global $EnginePointer = "0x" & StringFormat("%X", _MemoryRead($Enginepointer_Scan + 0x1, $Process, "dword") - $Engine)

	Global $UpdateSpecGlow = "0x" & StringFormat("%X", (_MemoryScanEx($Process, $GlowUpdate_Pattern, $GlowUpdate_Mask, False, $Client, $ClientEnd)) - $Client)

	$modelAmbientMin_Scan = _MemoryScanEx($Process, $modelAmbientMin_Pattern, $modelAmbientMin_Mask, False, $Engine, $EngineEnd)
	Global $modelAmbientMin = "0x" & StringFormat("%X", _MemoryRead($modelAmbientMin_Scan + 4, $Process, "dword") - $Engine)

	Global $m_iTeamNum = 0xF4
	Global $m_iHealth = 0x100
	Global $m_bDormant = 0xED
	Global $IsIngame = 0x108
	Global $m_bIsDefusing = 0x3918
	Global $nForceFullUpdate = 0x174
EndFunc   ;==>_Scan

Func _GetProcessPath($GPPpid)
	$colItems = ""
	$strComputer = "localhost"
	$objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
	$colItems = $objWMIService.ExecQuery('SELECT * FROM Win32_Process WHERE processid = ' & $GPPpid, "WQL", 0x10 + 0x20)
	If IsObj($colItems) Then
		For $objItem In $colItems
			Return $objItem.ExecutablePath
		Next
	Else
		Return ""
	EndIf
EndFunc   ;==>_GetProcessPath