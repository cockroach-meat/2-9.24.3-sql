# Этот скрипт был изначально написан в одну строку и исполнялся через "perl -e"
# Здесь он приведён в *чуть* более удобочитаемом виде :3

sub extract_data {
    sub split_line {
        grep { s/\n+//g; length $_ } split "\t", $_[0], -1;
    };
    
    my @lines = `mysql exam_gzgzyan -e "select * from $_[0];" -B`;
    my @fields = split_line shift @lines;
    
    print "INSERT INTO $_[0] (" . join(",", @fields) . ") VALUES " . join(",", map { "(\"" . join("\",\"", split_line($_)) . "\")" } @lines) . ";\n";
};

extract_data $_ for `mysql exam_gzgzyan -e "show tables" -B | tail +2`
