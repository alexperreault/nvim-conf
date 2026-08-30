# Troubleshooting

## macOS: fzf-lua fails to load (`serverstart(): invalid argument`)

macOS leaves `XDG_RUNTIME_DIR` unset, so Neovim builds sockets under `TMPDIR`
(`/var/folders/.../T/`) and the path overruns the 104-byte limit. Add to `.zshrc`:

```sh
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/run-$UID}"; mkdir -p -m 700 "$XDG_RUNTIME_DIR"
```
