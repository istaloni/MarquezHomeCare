# Runs automatically after `quarto render` (post-render in _quarto.yml).
# Copies the rendered blog from _site/ into ../blog/ so the website serves it at /blog/.
# Skipped during `quarto preview` and single-file renders, which only touch _site/.

if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL"))) quit(save = "no")

src  <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_site")
dest <- file.path("..", "blog")

# ../blog/ is generated output only. Never edit files there by hand.
unlink(dest, recursive = TRUE)
dir.create(dest, showWarnings = FALSE)

files <- list.files(src, recursive = TRUE, all.files = TRUE, no.. = TRUE)
for (f in files) {
  dir.create(dirname(file.path(dest, f)), recursive = TRUE, showWarnings = FALSE)
  file.copy(file.path(src, f), file.path(dest, f), overwrite = TRUE)
}

message("Blog copied to ", normalizePath(dest))
