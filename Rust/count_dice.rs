fn rand_int(nmin: i32, nmax: i32, seed: u32) -> (i32, u32) {
    let mut seed : u32 = seed;
    // From "Xorshift RNGs" by George Marsaglia
    seed ^= seed << 13;
    seed ^= seed >> 17;
    seed ^= seed << 5;
    let range = (nmax + 1 - nmin) as u32;
    let val = nmin + (seed % range) as i32;
    (val, seed)
}

fn time_seed() -> u32 {
    use std::time::SystemTime as st;
    let now = st::now().duration_since(st::UNIX_EPOCH).unwrap();
    now.as_millis() as u32
}
ßß
/// Launch two dices 1000 times and counts the occurences.
///
fn main() {
    let mut counter: [i32; 11] = [0; 11];
    let mut seed = time_seed();

    for _ in 0..1000 {
        let first_dice = rand_int(1, 6, seed);
        let second_dice = rand_int(1, 6, first_dice.1);
        
        seed += 1;

        let dice_sum = first_dice.0 + second_dice.0;
        counter[(dice_sum - 2) as usize] += 1;
    }

    for element in counter {
        println!("the value is: {}", element);
    }
}