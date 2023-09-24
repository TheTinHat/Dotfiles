return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "black",
            "isort",
            "ruff",
            "ruff-lsp",
            "yamlfmt",
            "tflint",
            "terraform-ls",
            "prettier",
            "prettierd",
            "dockerfile-language-server",
            "docker-compose-language-service",
        },
    },
}
