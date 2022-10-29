import Bintree

{-
Old wrong function , just as bad example
-}
wrong_largest_complete_subtree :: Tree -> Int
wrong_largest_complete_subtree (Leaf x) = 1
wrong_largest_complete_subtree (Branch x lt rt) = 2 * min_branches + 1
                                               where min_branches = min (wrong_largest_complete_subtree lt) (wrong_largest_complete_subtree rt)

prune_tree :: Tree -> Int -> Tree
prune_tree (Leaf x) _ = (Leaf x)
prune_tree (Branch x lt rt) 0 = (Leaf x)
prune_tree (Branch x lt rt) 1 = (Leaf x)
prune_tree (Branch x lt rt) d = Branch x (prune_tree lt (div d 2)) (prune_tree rt (div d 2))

{- wrapper for the auxiliry function  -}
find_largest_complete_subtree :: Tree -> (Tree, Int)
find_largest_complete_subtree (Leaf x) = (Leaf x, 1)
find_largest_complete_subtree (Branch x lt rt) =
  let ((current_tree, size_min_branch), (new_biggest_tree_left, size_left),(new_biggest_tree_right, size_right)) = find_largest_complete_subtree_aux  (Branch x lt rt)
  in if size_min_branch < size_left then if size_left < size_right then (new_biggest_tree_right, size_right)
                                                                   else (new_biggest_tree_left, size_left)
                                    else if size_min_branch < size_right then (new_biggest_tree_right, size_right)
                                                                         else (current_tree, size_min_branch)

{- auxiliary function, calcualtes more then needed -}
find_largest_complete_subtree_aux :: Tree -> ((Tree,Int) , (Tree,Int),(Tree,Int))
find_largest_complete_subtree_aux (Leaf x) = (((Leaf x), 1), ((Leaf x),0), ((Leaf x),0))
find_largest_complete_subtree_aux (Branch x lt rt) =
  let ((biggest_tree_left, last_biggest_size_left), (biggest_tree_left_left, size_left_left),(biggest_tree_left_right, size_left_right)) = (find_largest_complete_subtree_aux lt)
      ((biggest_tree_right, last_biggest_size_right), (biggest_tree_right_left, size_right_left),(biggest_tree_right_right, size_right_right)) = (find_largest_complete_subtree_aux rt)
  in  let min_branch = (min last_biggest_size_left last_biggest_size_right)  
      in  let current_tree = (Branch x (prune_tree biggest_tree_left min_branch) (prune_tree biggest_tree_right min_branch))
              size_min_branch = 2 * min_branch + 1
              (new_biggest_tree_left_side, size_left_side) = if size_left_left > size_left_right then (biggest_tree_left_left, size_left_left) else  (biggest_tree_left_right, size_left_right)
              (new_biggest_tree_right_side, size_right_side) = if size_right_left > size_right_right then (biggest_tree_right_left, size_right_left) else  (biggest_tree_right_right, size_right_right)
          in  let (new_biggest_tree_left, size_left) = if last_biggest_size_left > size_left_side then (biggest_tree_left, last_biggest_size_left) else (new_biggest_tree_left_side, size_left_side)
                  (new_biggest_tree_right, size_right) = if last_biggest_size_right > size_right_side then (biggest_tree_right, last_biggest_size_right) else (new_biggest_tree_right_side, size_right_side)
              in ((current_tree, size_min_branch), (new_biggest_tree_left, size_left), (new_biggest_tree_right, size_right))



