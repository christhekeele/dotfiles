import IO.ANSI

Application.put_env(:elixir, :ansi_enabled, true)

defmodule My.IEx.Prompt do
  def iex(n), do: IEx.Helpers.v(n)
  def node(name) when is_atom(name), do: match?(:pong, Node.ping(name)) && name || :nonode@nohost
  def node(name), do: Kernel.node(name)
end

import Kernel, except: [node: 1]
import My.IEx.Prompt

# "iex(1); "
base_prompt = [
  "#{white()}#{italic()}#{light_black_background()}%prefix#{reset()}",
  "#{cyan()}#{italic()}(#{reset()}",
  "#{yellow()}#{italic()}%counter#{reset()}",
  "#{cyan()}#{italic()})#{reset()}",
  "#{white()}#{faint()};#{reset()}",
  " #{reset()}"
]

# "node(:"foo@manticore"); "
node_prompt = [
  "#{white()}#{italic()}#{light_black_background()}node#{reset()}",
  "#{cyan()}#{italic()}(#{reset()}",
  "#{magenta()}#{italic()}:\"%node\"#{reset()}",
  "#{cyan()}#{italic()})#{reset()}",
  "#{white()}#{faint()};#{reset()}",
  " #{reset()}"
]

IEx.configure(
  colors: [
    syntax_colors: [
      number: :light_yellow,
      atom: :magenta,
      string: :green,
      boolean: [:blue, :bright],
      nil: [:magenta, :bright]
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline]
  ],
  default_prompt:
    Enum.join(base_prompt) <> reset(),
  alive_prompt:
    Enum.join(node_prompt ++ base_prompt) <> reset(),
  history_size: 1_000_000,
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 120,
    charlists: :as_lists,
    custom_options: [sort_maps: true]
  ],
  width: 120
)
