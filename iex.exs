import IO.ANSI

Application.put_env(:elixir, :ansi_enabled, true)

timestamp = fn ->
  {_date, {hour, minute, _second}} = :calendar.local_time()

  [hour, minute]
  |> Enum.map(&String.pad_leading(Integer.to_string(&1), 2, "0"))
  |> Enum.join(":")
end

workdir = fn ->
  {path, [cwd]} = File.cwd!()
  |> String.replace_leading(System.get_env("HOME"), "~")
  |> Path.split()
  |> Enum.split(-1)

  path
  |> Enum.map(&String.first/1)
  |> Kernel.++([cwd])
  |> Path.join()
end

IEx.configure(
  colors: [
    syntax_colors: [
      number: :light_yellow,
      atom: :light_red,
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
    Enum.join(
      [
        "#{white()}#{faint()}#{light_black_background()}#",
        "#{magenta()}#{}%prefix:%counter",
        "#{cyan()}#{italic()}#{light_black_background()}#{workdir.()}",
        "#{magenta()}#{faint()}❯❯❯"
      ],
      "#{reset()} "
    ) <> reset(),
  alive_prompt:
    Enum.join(
      [
        "#{white()}#{faint()}#{light_black_background()}#",
        "(#{red()}%node#{reset()})",
        "#{magenta()}#{}%prefix:%counter",
        "#{cyan()}#{italic()}#{light_black_background()}#{workdir.()}",
        "#{magenta()}#{faint()}❯❯❯"
      ],
      "#{reset()} "
    ) <> reset(),
  history_size: 1_000,
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 120,
    charlists: :as_lists,
    custom_options: [sort_maps: true]
  ],
  width: 120
)
