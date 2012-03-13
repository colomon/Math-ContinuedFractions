use Test;

plan 7;

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

sub z($a is copy, $b is copy, $c is copy, $d is copy, @x) {
    gather loop {
        # say "abcd: $a $b $c $d";
        my $a-div-c = $c ?? $a div $c !! Inf;
        my $b-div-d = $d ?? $b div $d !! Inf;
        # say "a/c b/d: $a-div-c $b-div-d";
        last if $a-div-c == Inf && $b-div-d == Inf;
        if $a-div-c == $b-div-d {
            my $n = $a-div-c;
            ($a, $b, $c, $d) = ($c, $d, $a - $c * $n, $b - $d * $n);
            take $n;
            # say "took $n";
        } else {
            if @x {
                my $p = @x.shift;
                ($a, $b, $c, $d) = ($b, $a + $b * $p, $d, $c + $d * $p);
                # say "hey, $p";
            } else {
                ($a, $b, $c, $d) = ($b, $b, $d, $d); # WHY????
                # say "hey, Inf";
            }
        }
    }
}

is z(1, 2, 2, 0, [1, 5, 2]), [1, 1, 2, 7], "mjd's example works";
is z(1, 0, 1, 0, [1, 2, 3, 4]), [1], "z handles case where it is 0 times x";
is z(1, 0, 1, 0, [0]), [1], "z handles another case where it is 0 times x";
