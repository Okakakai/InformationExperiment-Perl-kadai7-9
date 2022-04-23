#!"C:\xampp\perl\bin\perl.exe"
#!/usr/bin/perl

use CGI;
$cgi = CGI -> new();

@l = $cgi->param();
$body = $body . "@l" . "<br>\n";
$body = $body. $cgi->param("message") . "を入力しました";


print << "EOT";
Content-Type: text/html

<html>
<head><meta charset="UTF-8" />
<title>$title</title>
</head>
<body>
<form method="POST" action="sample.cgi">
<input type="text" name="message">
<input type="submit" name="send" value="送信">
<input type="reset" name="reset" value="取消">
</form>
$body
</body>
</html>
EOT
