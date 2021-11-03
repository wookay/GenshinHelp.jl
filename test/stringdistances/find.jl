module test_stringdistances_find

using Test
using StringDistances

targets = ["The Abyss", "BOSS", "Mystical Beasts"]
lowercased_targets = lowercase.(targets)

for D in (Levenshtein(),)
    (nearest, idx) = findnearest("boss", lowercased_targets, D)
    @test targets[idx] == "BOSS"
end

end # module test_stringdistances_find
