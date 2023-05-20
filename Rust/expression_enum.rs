pub enum Expression {
    Literal(f32),
    Product(Box<Expression>, Box<Expression>),
    Sum(Box<Expression>, Box<Expression>),
}

impl Expression {
    pub fn eval(& self) -> f32 {
        match self {
            Expression::Literal(val) => *val,
            Expression::Product(expr1, expr2) => expr1.eval() * expr2.eval(),
            Expression::Sum(expr1, expr2) => expr1.eval() + expr2.eval(),
        }
    }
}

fn main() {
    let prod1 = Expression::Product(Box::new(Expression::Literal(3.0)), Box::new(Expression::Literal(2.0)));
    println!("Prod1: {}", prod1.eval());
    let sum1 = Expression::Sum(Box::new(Expression::Literal(4.0)), Box::new(prod1));
    println!("Sum1: {}", sum1.eval());
    let prod2 = Expression::Product(Box::new(sum1), Box::new(Expression::Literal(5.0)));
    println!("Prod2: {}", prod2.eval());
}