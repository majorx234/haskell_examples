# Info
- Algos on Trees in Haskell

# Examples
## find_largest_complete_subtree
- recursive algorithm to find a complete subtree in a noncomplete tree
- example tree: 
  ```
              0
           /     \
          1        8
        /   \     /  \
       2     5    9   10
     /  \   / \
    3   4   6  7
  ```
- here:
  ```
              0
           /     \
          1        8
        /   \     /  \
       2     5    9   10
  ```
- is a complete tree
### usage
- in ghci load: ```:load find_largest_complete_subtree.hs```
- add tree: ```mytree = (Branch 0 (Branch 1 (Branch 2 (Leaf 3) (Leaf 4)) (Branch 5 (Leaf 6) (Leaf 7))) (Branch 8 (Leaf 9) (Leaf 10)))```
- start search: ```find_largest_complete_subtree mytree ```
