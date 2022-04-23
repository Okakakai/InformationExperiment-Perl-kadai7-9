#!"C:\xampp\perl\bin\perl.exe"
#!"/use/bin/perl"

$title = "form";
read(STDIN, $alldata, $ENV{'CONTENT_LENGTH'});

foreach $data (split(/&/,$alldata)){
 ($key, $value) = split(/=/,$data);
  $value =~ tr/+/ /;
#  $value = ~s/\+/ /;
 $value =~ s/%([0-9a-fA-F][0-9a-fA-F])/chr(hex($1))/eg;
 $put{$key} = $value;
}

print << "EOT";
Content-type: text/html\n
<head><meta http-equiv="content-Type" content="text/html; charset=UTF-8" />
<title>$title</title>
</head>
<body>
<form method="post" action="reform.pl">
        <p>
            メッセージ<br>
            <input type="text" name="name" size="30"><br>
            <input type="text" name="message" size="30">
        </p>
        <p><input type="submit" value="送信する"></p>
    </form>
<p>$put{'name'}が</p>
<p>$put{'message'}を入力しました</p>
</body>
</html>
EOT

