#!"C:\xampp\perl\bin\perl.exe"
#!"/use/bin/perl"

$title = "昭和通りに新しいラーメン屋できたってさ";
read(STDIN, $alldata, $ENV{'CONTENT_LENGTH'});

foreach $data (split(/&/,$alldata)){
 ($key, $value) = split(/=/,$data);
  $value =~ tr/+/ /;
 $value =~ s/%([0-9a-fA-F][0-9a-fA-F])/chr(hex($1))/eg;
 $put{$key} = $value;
}
    $ENV{'TZ'} = "JST-9";
    ($sec, $min, $hour, $mday, $mon, $year) = localtime();
    $time = sprintf("%04d/%02d/%02d %02d:%02d:%02d",
        $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

if(!($put{'message'} eq '')){
    open(IN, "log.txt");
    @log = <IN>;
    close(IN);
    $message = $put{'message'};
    ($no) = split(/\t/, $log[0]);
    $no++;
    $name = $put{'name'};
    # ログ先頭に書き込み内容を格納
    unshift @log, "$no\t$name\t$message\t$time\n";
    open(OUT, "+< log.txt");
    print OUT @log;
    close(OUT);
    ## リロードによる二重投稿を防ぐ
    print "Location: http://localhost/kei.pl\n\n";
    exit(0);
}

print << "EOT";
Content-type: text/html

<head><meta http-equiv="content-Type" content="text/html; charset=UTF-8" />
<title>$title</title>
</head>
<body>
<div style="text-align:center; border:solid 1px; margin: 2em 2em; background: #cde4ff"><a style="text-align:center;">掲示板</a><br><a>$title</a></div>
<div style="margin-bottom:2em
padding: 2em;
">
<form method="post" action="kei.pl" 
style=
    width: 100%;
    border-radius: 4px;
    border: none;
    box-shadow: 0 0 0 1px #ccc inset;
    margin: 0,auto;
    position: relative;
    ">
        <p>
            <input type="text" id="fname" name="name" size="30"  value="unkown" 
            style="margin-bottom: 1em;"
            ><br>
            <input type="text" name="message" size="30" placeholder="コメント"
            style="margin-bottom: 1em;"
            >
        </p>
        <p><input type="button" onclick="submit()" value="送信する"></p>
    </form>
</div>
EOT


if (open(FH, "log.txt")) {
    @log = <FH>;
    close(FH);
    foreach $data (@log) {
        print "<div 
        style='background-color:#C0C0C0;
        padding: auto;
        margin-top: 0.1em;
        '>";
        chop $data;
        ($no, $name,$message, $time) = split(/\t/, $data); 
        print "No.$no&nbsp;&nbsp;$title";
        print "&nbsp;&nbsp;投稿者：";
        print $name;
        print "&nbsp;&nbsp;&nbsp;&nbsp;投稿時刻：$time";
        print "<br><br>\n";
        print "$message<br>\n";
        print "<hr>\n";
        print "</div>";
    }

}
print << "EOT";
</body>
</html>
EOT

