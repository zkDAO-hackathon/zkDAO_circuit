use dep::ecrecover;
use std::hash::poseidon;

fn main(
    _proposalId: pub Field,
    _secret: Field,
    _voter: Field,
    _weight: pub Field,

    _snapshot_merkle_tree: pub Field,
    _leaf: Field,
    _index: Field,
    _path: [Field; 2],

    _pub_key_x: [u8; 32],
    _pub_key_y: [u8; 32],
    _signature: [u8; 64],
    _hashed_message: [u8; 32],
) -> pub Field {
    let nullifier = poseidon::bn254::hash_2([_secret, _proposalId]);

    let hash = poseidon::bn254::hash_3([_voter, _weight, nullifier]);
    assert(hash == _leaf, "Mismatch hashes");

    assert(verify_merkle_tree(_snapshot_merkle_tree, _leaf, _index, _path));

    let address = ecrecover::ecrecover(_pub_key_x, _pub_key_y, _signature, _hashed_message);
    assert(address == _voter);

    nullifier
}

fn verify_merkle_tree(
    expected_root: Field,
    leaf: Field,
    index: Field,
    path: [Field; 2]
) -> bool {
    let root = std::merkle::compute_merkle_root(leaf, index, path);
    root == expected_root
}

/**
    // these values are for this example only
    fn compute_root_from_slice(leaf: Field, index: Field, path: [Field]) -> Field {
        let mut hash = leaf;
        let index_u32: u32 = index as u32;

        for index in 0..path.len() {
            let sibling = path[index];
            let index_u8: u8 = index as u8;

        if ((index_u32 >> index_u8) & 1) == 0 {
                hash = poseidon::bn254::hash_2([hash, sibling]);
            } else {
                hash = poseidon::bn254::hash_2([sibling, hash]);
            }
        }

        hash
}
*/

