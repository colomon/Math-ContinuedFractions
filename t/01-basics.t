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

is ($three + 3.2345234).a, Math::ContinuedFraction.new(6.2345234).a, "3 + 3.2345234 == 6.2345234";
is (3.2345234 + $two).a, Math::ContinuedFraction.new(5.2345234).a, "3.2345234 + 2 == 5.2345234";

is ($three - $two).a, Math::ContinuedFraction.new(1).a, "3 - 2 == 1";
is $three.a, [3], "Didn't consume 3";
is $two.a, [2], "or 2";

is ($three - 3.2345234).a, Math::ContinuedFraction.new(-0.2345234).a, "3 - 3.2345234 == -0.2345234";
is (3.2345234 - $two).a, Math::ContinuedFraction.new(1.2345234).a, "3.2345234 - 2 == 1.2345234";

is ($three * $two).a, Math::ContinuedFraction.new(6).a, "3 * 2 == 6";
is $three.a, [3], "Didn't consume 3";
is $two.a, [2], "or 2";

is ($three * 3.2345234).a, Math::ContinuedFraction.new(3 * 3.2345234).a, "3 * 3.2345234 == whatever";
is (3.2345234 * $two).a, Math::ContinuedFraction.new(3.2345234 * 2).a, "3.2345234 * 2 == whatever";

is ($three / $two).a, Math::ContinuedFraction.new(3/2).a, "3 / 2 == 3/2";
is $three.a, [3], "Didn't consume 3";
is $two.a, [2], "or 2";

is ($three / 3.2345234).a, Math::ContinuedFraction.new(3 / 3.2345234).a, "3 / 3.2345234 == whatever";
is (3.2345234 / $two).a, Math::ContinuedFraction.new(3.2345234 / 2).a, "3.2345234 / 2 == whatever";

is Math::ContinuedFraction.new(-2.3241).abs.a, Math::ContinuedFraction.new(2.3241).a, '.abs works on negative number';
is Math::ContinuedFraction.new(2.3241).abs.a, Math::ContinuedFraction.new(2.3241).a, '.abs works on positive number';

is Math::ContinuedFraction.new(0).sign, 0, '0.sign is 0';
is Math::ContinuedFraction.new(0.0001).sign, 1, '0.0001.sign is 1';
is Math::ContinuedFraction.new(1).sign, 1, '1.sign is 1';
is Math::ContinuedFraction.new(1.2313).sign, 1, '1.2313.sign is 1';
is Math::ContinuedFraction.new(34).sign, 1, '45.sign is 1';
is Math::ContinuedFraction.new(403.1).sign, 1, '403.1.sign is 1';
is Math::ContinuedFraction.new(-0.0001).sign, -1, '-0.0001.sign is -1';
is Math::ContinuedFraction.new(-1).sign, -1, '-1.sign is -1';
is Math::ContinuedFraction.new(-1.2313).sign, -1, '-1.2313.sign is -1';
is Math::ContinuedFraction.new(-34).sign, -1, '-45.sign is -1';
is Math::ContinuedFraction.new(-403.1).sign, -1, '-403.1.sign is -1';

done;
