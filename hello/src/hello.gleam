import gleam/int.{to_string as str}
import gleam/io

@external(erlang, "add", "add")
fn add(x: Int, y: Int) -> Int

pub fn main() {
  io.println("Hello from hello!")
  let a = 5
  let b = 4

  io.println(str(a) <> " + " <> str(b) <> " = " <> str(add(a, b)))
}
