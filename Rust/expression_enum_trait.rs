pub trait Expression {
    fn eval(&self) -> f32;
}

pub struct Literal {
    val : f32
}
impl Expression for Literal {
    fn eval(&self) -> f32 {
        self.val
    }
}

pub struct Product {
    expr1: Box<dyn Expression>,
    expr2: Box<dyn Expression>
}
impl Expression for Product {
    fn eval(&self) -> f32 {
        self.expr1.eval() * self.expr2.eval()
    }
}

pub struct Sum {
    expr1: Box<dyn Expression>,
    expr2: Box<dyn Expression>
}
impl Expression for Sum {
    fn eval(&self) -> f32 {
        self.expr1.eval() + self.expr2.eval()
    }
}

fn main() {
    let prod1 = Product{expr1: Box::new(Literal{val: 3.0}), expr2: Box::new(Literal{val: 2.0})};
    println!("Prod1: {}", prod1.eval());
    let sum1 = Sum{expr1: Box::new(Literal{val:4.0}), expr2: Box::new(prod1)};
    println!("Sum1: {}", sum1.eval());
    let prod2 = Product{expr1: Box::new(sum1), expr2: Box::new(Literal{val: 5.0})};
    println!("Prod2: {}", prod2.eval());
}
