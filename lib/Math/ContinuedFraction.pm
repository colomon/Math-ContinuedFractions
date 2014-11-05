use v6;

sub make-continued-fraction (Real $x is copy) {
    gather loop {
        my $a = $x.floor;
        take $a;
        $x = $x - $a;
        last if $x == 0;
        $x = 1 / $x;
    }
}

class Math::ContinuedFraction {
    has Int @.a;

    multi method new(@a) {
        self.bless(:@a);
    }

    multi method new(Real $x) {
        self.bless(:a(make-continued-fraction($x)));
    }
}

