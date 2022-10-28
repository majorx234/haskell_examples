import Bintree

find_largest_complete_subtree :: Tree -> Int  
find_largest_complete_subtree (Leaf x) = 1
find_largest_complete_subtree (Branch x lt rt) = 2 * min_branches + 1
                                               where min_branches = min (find_largest_complete_subtree lt) (find_largest_complete_subtree rt)



