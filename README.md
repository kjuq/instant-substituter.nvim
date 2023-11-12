# Instant-substituter.nvim

**Substitute string with one shortcut.**

In my daily coding, I repeatedly replace ' with ". For that, I used `:s/'/"/g` or `r"`. However, that's annoying to type them again and again.

So, I made this plugin. This makes it possible to configure substitute shortcuts easily. For example, focusing on the line you want to execute substitution then pressing `gz` replaces ' with " whole of the focused line.

# Advantages

- **Dot-repeat is supported**
- Replace multiple lines simultaneously in VISUAL mode
- Easy configuration

# Demo

https://github.com/kjuq/instant-substituter.nvim/assets/44694396/ec8810b9-aede-4ce5-b7ed-d0abbbe606fd

# Installation

Using [Lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "kjuq/instant-substituter.nvim" }
```

# Configuration

Example

```lua
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

```lua
[<A>] = { "<B>", "<C>"}
```

Put the key to activate a substitution in `<A>`. It replaces a string `<B>` with `<C>`.

# Usage

Focus the line and hit the key, then replace ALL of the texts you specified in the configuration.
