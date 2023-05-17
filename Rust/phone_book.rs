fn get_phone_number(name: String, phone_book: [(String, i32); 3]) -> Result<i32, String> {

    let iterator = phone_book.iter();
    
    iterator.fold(Err(String::from("errore")), |acc, (k, v)| if *k == name {Ok(*v)} else {acc})
}

fn main() {
    let phone_book: [(String, i32); 3] = [(String::from("Pippo"), 123456), (String::from("Minnie"), 987654), (String::from("Pluto"), 456789)];
    let result = get_phone_number(String::from("Pippo"), phone_book);

    if result.is_ok() {
        println!("{}", result.unwrap())
    }
    else {
        println!("Not found");
    }
}