#!"C:\xampp\perl\bin\perl.exe"
my $title = "form";
read(STDIN, $alldata, $ENV{'CONTENT_LENGTH'});

foreach $data (split(/&/,$alldata)){
 ($key, $value) = split(/=/,$data);
  $value =~ tr/+/ /;
 $value =~ s/%([0-9a-fA-F][0-9a-fA-F])/chr(hex($1))/eg;

 $put{$key} = $value;
}

print << "EOT";
Content-type: text/html\n
<head><meta http-equiv="content-Type" content="text/html; charset=UTF-8" />
<title>$title</title>
</head>
<body>
<p>$put{'name'}が</p>
<p>$put{'message'}を入力しました</p>
<p>$key,$value</p>
</body>
</html>
EOT

