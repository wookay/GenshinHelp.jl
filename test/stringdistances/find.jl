module test_stringdistances_find

using Test
using StringDistances

(nearest, idx) = findnearest("message", ["msg", "hello"], Levenshtein())
@test (nearest, idx) == ("msg", 1)

end # module test_stringdistances_find
