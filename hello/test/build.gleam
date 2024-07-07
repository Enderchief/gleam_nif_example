//// build.gleam

import gleam/build as b

pub fn main() {
  let assert Ok(_) =
    b.new(name: "add_nif")
    |> b.add_source("c_src/add_nif.c")
    |> b.add_header("c_src/add.h")
    // |> b.add_library("libwobble")
    |> b.build()
}
