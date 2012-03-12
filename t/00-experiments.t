use Test;

plan 4;

sub make-continued-fraction (Real $x is copy) {
    gather loop {
        my $a = $x.floor;
        take $a;
        $x = $x - $a;
        last if $x == 0;
        $x = 1 / $x;
    }
}

is make-continued-fraction(3), [3], "Sanity test";
is make-continued-fraction(-42), [-42], "Sanity test";
is make-continued-fraction(3.245), [3, 4, 12, 4], "Wikipedia example works";
is make-continued-fraction(-4.2), [-5, 1, 4], "Wikipedia example works";
