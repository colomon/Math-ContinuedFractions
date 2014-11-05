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
    my $cf2 = Math::ContinuedFraction.new($cf.a);
    isa_ok $cf2, Math::ContinuedFraction, "We created a Math::ContinuedFraction object by array";
    is $cf2.a, $cf-form, "Still with the correct value";
    my $cf3 = Math::ContinuedFraction.new($cf);
    isa_ok $cf3, Math::ContinuedFraction, "We copied Math::ContinuedFraction object using .new";
    is $cf3.a, $cf-form, "Still has the correct value";
}

my $three = Math::ContinuedFraction.new(3);
my $two = Math::ContinuedFraction.new(2);
is ($three + $two).a, Math::ContinuedFraction.new(5).a, "3 + 2 == 5";
is $three.a, [3], "Didn't consume 3";
is $two.a, [2], "or 2";



done;
