use v6;
use Test;
use Math::ContinuedFraction;

my @rationals = 3 => [3],
                0 => [0],
                -42 => [-42],
                3.245 => [3, 4, 12, 4],
                -4.2 => [-5, 1, 4];
                
for @rationals>>.kv -> $rational, $cf-form {
    my $cf = Math::ContinuedFraction.new($rational);
    isa_ok $cf, Math::ContinuedFraction, "We made a Math::ContinuedFraction object for $rational";
    is $cf.a, $cf-form, "With the correct value";
}





done;
