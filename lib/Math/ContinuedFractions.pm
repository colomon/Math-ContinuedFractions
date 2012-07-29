module Math::ContinuedFractions;
sub make-continued-fraction (Real $x is copy) is export {
    gather loop {
        my $a = $x.floor;
        take $a;
        $x = $x - $a;
        last if $x == 0;
        $x = 1 / $x;
    }
} 
