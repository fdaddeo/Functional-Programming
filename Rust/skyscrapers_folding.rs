/// Counts how many times the maximum changes in a list.
///
fn main() {
    let array_iterator = [1, 2, 3, 6, 5, 4].iter();
    let (_max_val, changes) = array_iterator.fold((0, 0), |(max_val, count), x| if x > &max_val {(*x, count+1)} else {(max_val, count)});

    println!("The maximum changed {} times.", changes);
}