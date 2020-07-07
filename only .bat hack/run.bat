@echo off
cd /d %temp%
echo|set /P ="import Accessibility; import System; import System.Drawing; import System.Windows.Forms; import System.Runtime.InteropServices; import System.Reflection; import System.Reflection.Emit; import System.Runtime; import System.Text; import System.Diagnostics; import System.Threading; import System.Memory; import System.Buffers.Binary; import System.Buffers.Binary.BinaryPrimitives;" > TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var dwEntityList : int = 0x4D4B104; var dwLocalPlayer : int = 0xD36B94;  var m_flDetectedByEnemySensorTime : int = 0x3964; var m_iTeamNum : int = 0xF4; var m_iHealth : int = 0x100; var m_bSpotted : int = 0x93D;" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public class Form1 extends Form " >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var pHandle : IntPtr; var process : Process; var clientModule : ProcessModule; var engineModule : ProcessModule;  var cheat_loaded : boolean = false;  var label1 : System.Windows.Forms.Label; var checkBox1 : System.Windows.Forms.CheckBox; var checkBox2 : System.Windows.Forms.CheckBox; var button1 : System.Windows.Forms.Button; var button2 : System.Windows.Forms.Button; var components : System.ComponentModel.Container; var timer1 : System.Windows.Forms.Timer;" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="static function InvokeWin32(dllName:String, returnType:Type, methodName:String, parameterTypes:Type[], parameters:Object[])" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="// Begin to build the dynamic assembly var domain = AppDomain.CurrentDomain; var name = new System.Reflection.AssemblyName('PInvokeAssembly'); var assembly = domain.DefineDynamicAssembly(name, AssemblyBuilderAccess.Run); var module = assembly.DefineDynamicModule('PInvokeModule'); var type = module.DefineType('PInvokeType',TypeAttributes.Public + TypeAttributes.BeforeFieldInit);  // Define the actual P/Invoke method var method = type.DefineMethod(methodName, MethodAttributes.Public + MethodAttributes.HideBySig + MethodAttributes.Static + MethodAttributes.PinvokeImpl, returnType, parameterTypes);  // Apply the P/Invoke constructor var ctor = System.Runtime.InteropServices.DllImportAttribute.GetConstructor([Type.GetType("System.String")]); var attr = new System.Reflection.Emit.CustomAttributeBuilder(ctor, [dllName]); method.SetCustomAttribute(attr);  // Create the temporary type, and invoke the method. var realType = type.CreateType(); return realType.InvokeMember(methodName, BindingFlags.Public + BindingFlags.Static + BindingFlags.InvokeMethod, null, null, parameters);" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="static function OpenProcess( dwDesiredAccess:UInt32, bInheritHandle : boolean,  dwProcessId:UInt32)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var parameterTypes:Type[] = [Type.GetType("System.UInt32"), Type.GetType("System.Boolean"), Type.GetType("System.UInt32")]; var parameters:Object[] = [dwDesiredAccess, bInheritHandle, dwProcessId];  return InvokeWin32("kernel32.dll", Type.GetType("System.IntPtr"), "OpenProcess", parameterTypes,  parameters );" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="static function ReadProcessMemory(hProcess:IntPtr,lpBaseAddress:IntPtr ,lpBuffer:byte[],dwSize:int, lpNumberOfBytesRead:int)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var parameterTypes:Type[] = [Type.GetType("System.IntPtr"), Type.GetType("System.IntPtr"), Type.GetType("System.Byte[]"),Type.GetType("System.Int32"), Type.GetType("System.Int32")]; var parameters:Object[] = [hProcess, lpBaseAddress, lpBuffer,dwSize,lpNumberOfBytesRead];  return InvokeWin32("kernel32.dll", Type.GetType("System.IntPtr"), "ReadProcessMemory", parameterTypes,  parameters );" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="static function WriteProcessMemory(hProcess:IntPtr,lpBaseAddress:IntPtr ,lpBuffer:byte[],dwSize:int, lpNumberOfBytesRead:int)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var parameterTypes:Type[] = [Type.GetType("System.IntPtr"), Type.GetType("System.IntPtr"), Type.GetType("System.Byte[]"),Type.GetType("System.Int32"), Type.GetType("System.Int32")]; var parameters:Object[] = [hProcess, lpBaseAddress, lpBuffer,dwSize,lpNumberOfBytesRead];  return InvokeWin32("kernel32.dll", Type.GetType("System.IntPtr"), "WriteProcessMemory", parameterTypes,  parameters );" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="function SetProcessWorkingSetSize(hProcess:IntPtr,dwMinimumWorkingSetSize:UInt32,dwMaximumWorkingSetSize:UInt32)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var parameterTypes:Type[] = [Type.GetType("System.IntPtr"), Type.GetType("System.UInt32"), Type.GetType("System.UInt32")]; var parameters:Object[] = [hProcess, dwMinimumWorkingSetSize, dwMaximumWorkingSetSize];  return InvokeWin32("kernel32.dll", Type.GetType("System.IntPtr"), "SetProcessWorkingSetSize", parameterTypes,  parameters );" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="function ReadInt(lpBaseAddress: int) : int { var readed : int = 0; var read_int_byte : byte[] = new byte[4]; var addr_intptr = new IntPtr(lpBaseAddress); ReadProcessMemory(pHandle, addr_intptr, read_int_byte, read_int_byte.Length, readed); var read_int : int = BitConverter.ToInt32(read_int_byte, 0); return read_int; }	  function ReadBoolean(lpBaseAddress: int) : boolean { var readed : int = 0; var read_byte : byte[] = new byte[1]; var addr_intptr = new IntPtr(lpBaseAddress); ReadProcessMemory(pHandle, addr_intptr, read_byte, read_byte.Length, readed); return read_byte[0] != 0; }  function ReadFloat(lpBaseAddress: int) : float { var readed : int = 0; var read_float_byte : byte[] = new byte[4]; var addr_intptr = new IntPtr(lpBaseAddress); ReadProcessMemory(pHandle, addr_intptr, read_float_byte, read_float_byte.Length, readed); var read_float : float = BitConverter.ToSingle(read_float_byte, 0); return read_float; }  function WriteInt(lpBaseAddress: int, Val : int) { var readed : int = 0; var write_int_byte : byte[] = BitConverter.GetBytes(Val); var addr_intptr = new IntPtr(lpBaseAddress); WriteProcessMemory(pHandle, addr_intptr, write_int_byte, write_int_byte.Length, readed); }	  function WriteBoolean(lpBaseAddress: int, Val : boolean) { var readed : int = 0; var write_bool_byte : byte[] = BitConverter.GetBytes(Val); var addr_intptr = new IntPtr(lpBaseAddress); WriteProcessMemory(pHandle, addr_intptr, write_bool_byte, write_bool_byte.Length, readed); }  function WriteFloat(lpBaseAddress: int, Val : float) { var readed : int = 0; var write_float_byte : byte[] = BitConverter.GetBytes(Val); var addr_intptr = new IntPtr(lpBaseAddress); WriteProcessMemory(pHandle, addr_intptr, write_float_byte, write_float_byte.Length, readed); }" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public function Form1_FormClosing(sender: Object, e : FormClosingEventArgs)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="if(this.cheat_loaded) { for(var i = 0; i < 64; i++) {				 var player_adr : int = ReadInt(int.Parse(clientModule.BaseAddress) + dwEntityList + (i * 0x10));  if(player_adr > 0) { 	WriteFloat(player_adr + m_flDetectedByEnemySensorTime, 0.0); } } }" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="var LocalPlayer : int = 0; var local_team : int = 0; var player_adr : int = 0; var player_is_dormant : boolean = true; var player_health : int = 0; var player_team : int = 0; var is_dormant : int = 0;" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public function MainLoop(sender : Object, e : System.EventArgs)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{	" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="LocalPlayer = ReadInt(int.Parse(clientModule.BaseAddress) + dwLocalPlayer);  if(LocalPlayer >= 0)	 { local_team = ReadInt(LocalPlayer + m_iTeamNum);  for(var i = 1; i < 65; i++) { player_adr = ReadInt(int.Parse(clientModule.BaseAddress) + dwEntityList + (i * 0x10));  if(player_adr > 0) { 	player_team = ReadInt(player_adr + m_iTeamNum); 	 	if(local_team == player_team) 		continue; 	 	player_health = ReadInt(player_adr + m_iHealth); 	 	if(player_health <= 0) 		continue;  	if(this.checkBox1.Checked) 		WriteInt(player_adr + m_bSpotted, 1); 	 	if(this.checkBox2.Checked) 		WriteFloat(player_adr + m_flDetectedByEnemySensorTime, 86400.0); } } }  SetProcessWorkingSetSize(Process.GetCurrentProcess().Handle, UInt32(-1), UInt32(-1));" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public function button2_Click(sender : Object, e : System.EventArgs)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="this.label1.Text = "Cheat not loaded"; this.timer1.Stop();  if(this.cheat_loaded) { for(var i = 0; i < 64; i++) { var player_adr : int = ReadInt(int.Parse(clientModule.BaseAddress) + dwEntityList + (i * 0x10));  if(player_adr > 0) { 	WriteFloat(player_adr + m_flDetectedByEnemySensorTime, 0.0); } } }  this.cheat_loaded = false;" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public function button1_Click(sender : Object, e : System.EventArgs)" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="if(Process.GetProcessesByName("csgo").Length > 0) {  process = Process.GetProcessesByName("csgo")[0]; pHandle = OpenProcess(0x1F0FFF, false, UInt32(process.Id));  var modules : ProcessModuleCollection  = process.Modules;  for(var i = 0; i < modules.Count; i++) { if(modules.Item[i].FileName.Contains("bin\\client.dll")) { 	clientModule = modules.Item[i]; }  if(modules.Item[i].FileName.Contains("engine.dll")) { 	engineModule = modules.Item[i]; } }  if(clientModule != null || engineModule != null) { this.label1.Text = "Cheat loaded."; this.cheat_loaded = true; this.timer1.Start(); } else { MessageBox.Show(this, "csgo.exe not found.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); } } else { MessageBox.Show(this, "csgo.exe not found.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); }" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="private function InitializeComponent() : void " >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="this.components = new System.ComponentModel.Container(); this.label1 = new System.Windows.Forms.Label(); this.checkBox1 = new System.Windows.Forms.CheckBox(); this.checkBox2 = new System.Windows.Forms.CheckBox(); this.button1 = new System.Windows.Forms.Button(); this.button2 = new System.Windows.Forms.Button(); this.timer1 = new System.Windows.Forms.Timer(this.components); this.SuspendLayout();  this.Text = "CS:GO Cheat"; this.Height = 170; this.Width = 300; this.WindowState = FormWindowState.Normal; this.StartPosition = FormStartPosition.CenterScreen; this.MaximumSize = new System.Drawing.Size(300, 170); this.MinimumSize = new System.Drawing.Size(300, 170); this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow; this.add_FormClosing(this.Form1_FormClosing);  this.label1.AutoSize = true; this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.25, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0); this.label1.Location = new System.Drawing.Point(12, 9); this.label1.Name = "label1"; this.label1.Size = new System.Drawing.Size(60, 24); this.label1.TabIndex = 2; this.label1.Text = "Cheat not loaded.";  this.button1.Location = new System.Drawing.Point(12, 38); this.button1.Name = "button1"; this.button1.Size = new System.Drawing.Size(270, 45); this.button1.TabIndex = 0; this.button1.Text = "Start"; this.button1.UseVisualStyleBackColor = true; this.button1.add_Click(this.button1_Click);  this.button2.Location = new System.Drawing.Point(12, 83); this.button2.Name = "button2"; this.button2.Size = new System.Drawing.Size(270, 45); this.button2.TabIndex = 1; this.button2.Text = "Stop"; this.button2.UseVisualStyleBackColor = true; this.button2.add_Click(this.button2_Click);" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="this.checkBox1.Location = new System.Drawing.Point(150, 2); this.checkBox1.Name = "checkBox1"; this.checkBox1.Size = new System.Drawing.Size(150, 18); this.checkBox1.TabIndex = 1; this.checkBox1.Text = "Toggle radar"; this.checkBox1.UseVisualStyleBackColor = true;  this.checkBox2.Location = new System.Drawing.Point(150, 20); this.checkBox2.Name = "checkBox2"; this.checkBox2.Size = new System.Drawing.Size(150, 18); this.checkBox2.TabIndex = 1; this.checkBox2.Text = "Toggle glow"; this.checkBox2.UseVisualStyleBackColor = true; this.checkBox2.Checked = true;  this.timer1.Interval = 100; this.timer1.add_Tick(this.MainLoop);  this.Controls.Add(this.label1); this.Controls.Add(this.button2); this.Controls.Add(this.button1); this.Controls.Add(this.checkBox1); this.Controls.Add(this.checkBox2);  this.ResumeLayout(false);" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public function Form1()" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="InitializeComponent();" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="public STAThreadAttribute() static function Main(Args:String[]) : void " >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="{" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="Application.Run(new Form1());" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="}" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="" >> TEMPTXT.txt
echo. >> TEMPTXT.txt
echo|set /P ="Form1.Main(Environment.GetCommandLineArgs());" >> TEMPTXT.txt
C:\Windows\Microsoft.NET\Framework\v4.0.30319\jsc.exe /fast /platform:x86 /t:winexe TEMPTXT.txt >nul 2>&1
TEMPTXT.exe
del TEMPTXT.txt
del TEMPTXT.exe