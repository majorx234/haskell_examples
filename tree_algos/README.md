# Info
- Algos on Trees in Haskell

# Examples
## find_largest_complete_subtree
- recursive algorithm to find a complete subtree in a noncomplete tree
- 1st example tree:
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
- is the largest complete tree of size 7
- 2nd example tree:
  ```
              0
            /   \
          1      10
        /   \
       2     3
            / \
           4   5
          / \ / \
         6  7 8  9
  ```
- here:
  ```
      3
     / \
    4   5
   / \ / \
  6  7 8  9
  ```
- is the largest complete subtree of size 7
- (thx to Nikl174 for this example)

### usage
- in ghci load: ```:load find_largest_complete_subtree.hs```
- add tree: ```mytree = (Branch 0 (Branch 1 (Branch 2 (Leaf 3) (Leaf 4)) (Branch 5 (Leaf 6) (Leaf 7))) (Branch 8 (Leaf 9) (Leaf 10)))```
- start search: ```find_largest_complete_subtree mytree ```
- resulr: ```(Branch 0 (Branch 1 (Leaf 2) (Leaf 5)) (Branch 8 (Leaf 9) (Leaf 10)),7)```
- or
- add tree: ```nictree = (Branch 0 (Branch 1 (Leaf 2) (Branch 3 (Branch 4 (Leaf 6) (Leaf 7)) (Branch 5 (Leaf 8) (Leaf 9)))) (Leaf 10))```
- start search: ```find_largest_complete_subtree mytree ```
- result: ```(Branch 3 (Branch 4 (Leaf 6) (Leaf 7)) (Branch 5 (Leaf 8) (Leaf 9)),7)```
