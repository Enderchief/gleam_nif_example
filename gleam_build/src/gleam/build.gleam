pub opaque type Builder {
  Builder(
    name: String,
    sources: List(String),
    headers: List(String),
    libraries: List(String),
  )
}

pub fn new(name name: String) {
  Builder(name, [], [], [])
}

pub fn add_source(builder: Builder, path: String) {
  let sources = [path, ..builder.sources]
  Builder(..builder, sources: sources)
}

pub fn add_header(builder: Builder, path: String) {
  let headers = [path, ..builder.headers]
  Builder(..builder, headers: headers)
}

pub fn add_library(builder: Builder, path: String) {
  let libraries = [path, ..builder.libraries]
  Builder(..builder, libraries: libraries)
}

pub fn build(builder: Builder) {
  let command =
    getenv(to_list("CC"), <<"gcc":utf8>>)
    <> " -o \"./priv/"
    <> builder.name
    <> ".so\" -fpic -shared"
    <> join(builder.sources, " ")
    <> join(builder.headers, " ")
    <> " -I /usr/lib/erlang/usr/include"
  print(command <> "\n\n")
  let out =
    to_list(command)
    |> exec
  print(out)
  Ok(out)
}

@external(erlang, "unicode", "characters_to_list")
pub fn to_list(string: String) -> List(String)

@external(erlang, "unicode", "characters_to_binary")
fn concat(strings: List(String)) -> String

fn join(strings: List(String), separator: String) -> String {
  strings
  |> intersperse(separator, [])
  |> concat
}

fn intersperse(list: List(a), separator: a, acc: List(a)) -> List(a) {
  case list {
    [] -> do_reverse(acc, [])
    [x, ..rest] -> intersperse(rest, separator, [x, separator, ..acc])
  }
}

fn do_reverse(remaining, accumulator) {
  case remaining {
    [] -> accumulator
    [item, ..rest] -> do_reverse(rest, [item, ..accumulator])
  }
}

@external(erlang, "io", "put_chars")
fn print(string: String) -> Nil

@external(erlang, "os", "getenv")
fn getenv(varname: List(String), default: BitArray) -> String

@external(erlang, "os", "cmd")
fn exec(command: List(String)) -> String
