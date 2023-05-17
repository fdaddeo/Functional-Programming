struct Ball {
    x: i32,
    y: i32,
    dx: i32,
    dy: i32,
}

fn move_ball(ball: &mut Ball) {
    ball.x += ball.dx;
    ball.y += ball.dy;
}

fn main() {
    let mut ball = Ball {
        x: 0,
        y: 0,
        dx: 5,
        dy: 5,
    };

    move_ball(&mut ball);

    println!("x: {} y: {}", ball.x, ball.y);
}