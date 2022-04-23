#!"C:\xampp\perl\bin\perl.exe"

my $title = "Couter";
print << "EOT";
Content-Type: text/html

<html>
<head><meta charset="UTF-8" />
<title>$title</title>
</head>
<body>
EOT
if (open(FH, "counter.txt")) {
  my $count = <FH>;
  close(FH);

  $count++;

  print "<div>あなたは$count人目の訪問者です。</div>\n";

  if (open(FH, ">counter.txt")) {
    print FH $count;
    close(FH);
  } else {
    print "<p>ファイルに書き込むことができません。</p>";
  }
} else {
  print "<p>ファイルを読み込めません。</p>";
}

print << "EOT";
</body>
</html>
EOT



