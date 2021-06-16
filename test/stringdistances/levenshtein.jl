module test_stringdistances_levenshtein

using Test
using StringDistances

l = Levenshtein()
@test evaluate(l, "hello", "Hello") == 1
@test evaluate(l, "hello", "helloo") == 1
@test evaluate(l, "hello", "Hallo") == 2
@test evaluate(l, "hello", "halo") == 2
@test evaluate(l, "hello", "Halo") == 3
@test evaluate(l, "hello", "world") == 4

end # module test_stringdistances_levenshtein
