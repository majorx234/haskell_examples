import Bintree2

bin_tree_insert :: BTree -> Int -> BTree
bin_tree_insert Empty z = BBranch z Empty Empty
bin_tree_insert (BBranch x streel streer) z | z < x = (BBranch x (bin_tree_insert streel z) streer)
                                             | otherwise = BBranch x streel (bin_tree_insert  streer z)

pos_xl_node :: BTree -> Float
pos_xl_node Empty = 0
pos_xl_node (BBranch _ streel streer) = (pos_xl_node streel) + (pos_xr_node streel) + 1

pos_xr_node :: BTree -> Float
pos_xr_node Empty = 0
pos_xr_node (BBranch _ streel streer) = (pos_xl_node streer) + (pos_xr_node streer) + 1
