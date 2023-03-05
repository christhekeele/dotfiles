function webp
  python -m pip install --user --upgrade Pillow
  for input in *.webp
    set -l output (string replace webp gif $input)
    echo Converting $input to $output
    python -c "from PIL import Image; Image.open('$input').save('$output', 'gif', save_all=True, optimize=True, background=0)"
  end
end
