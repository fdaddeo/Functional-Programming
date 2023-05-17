struct Ball {
    x: i32,
    y: i32,
    dx: i32,
    dy: i32,
}

fn move_ball(mut ball: Ball) -> Ball {
    ball.x += ball.dx;
    ball.y += ball.dy;

    ball
}

fn main() {
    let ball = Ball {
        x: 0,
        y: 0,
        dx: 5,
        dy: 5,
    };

    let ball_updated = move_ball(ball);
    println!("x: {} y: {}", ball_updated.x, ball_updated.y);
}