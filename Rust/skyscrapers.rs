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

fn main() {
    let array = [1, 2, 3, 6, 5, 4];
    let changes = maximum_changes(array);

    println!("The maximum changed {} times.", changes);
}