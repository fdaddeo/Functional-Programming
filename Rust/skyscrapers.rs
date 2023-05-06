// #![crate_name = "doc"]

/// Returns the number of times the maximum changes, from left to right, in a list.
/// 
/// # Arguments
/// 
/// * `array` - The array in which count the number times the maximum changes.
/// 
fn maximum_changes(array: [i32; 6]) -> i32 {
    let mut maximum = 0;
    let mut changes = 0;
    
    for element in array {
        if element > maximum {
            maximum = element;
            changes += 1
        }
    }
    
    changes
}


/// Counts how many times the maximum changes in a list.
///
fn main() {
    let array = [1, 2, 3, 6, 5, 4];
    let changes = maximum_changes(array);

    println!("The maximum changed {} times.", changes);
}