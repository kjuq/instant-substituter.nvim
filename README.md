# Instant-Substituter.nvim

Substitute string with one shortcut.

# Advantages

- **Dot repeat is supported**
- Replace multiple lines simultaneously in VISUAL mode
- Easy configuration

# Demo

# Installation

Using [Lazy.nvim](https://github.com/folke/lazy.nvim)
```
{ "kjuq/instant-substituter.nvim" }

```

# Configuration

Example

```
{
    "kjuq/instant-substituter.nvim",
    opts = {
        keys = {
            ["gz"] = { [[']], [["]] },
            ["<C-l>"] = { [[-]], [[+]] },
            ["<leader>o"] = { "var", "let" },
        },
    },
}
```

`[<A>] = { "<B>", "<C>"}`

Put the key to activate a substitution in <A>. It replace a string <B> with <C>.

# Usage

Focus the line and hit the key, then replace ALL of the texts you specified in the configuration.
