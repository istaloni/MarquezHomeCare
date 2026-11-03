# Runs automatically after every render (post-render in _quarto.yml), including
# RStudio's Render button. Copies the rendered blog from _site/ into ../blog/
# so the website serves it at /blog/. ../blog/ is generated output: never edit it by hand.

src  <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_site")
dest <- file.path("..", "blog")
dir.create(dest, showWarnings = FALSE)

files <- list.files(src, recursive = TRUE, all.files = TRUE, no.. = TRUE)
for (f in files) {
  dir.create(dirname(file.path(dest, f)), recursive = TRUE, showWarnings = FALSE)
  file.copy(file.path(src, f), file.path(dest, f), overwrite = TRUE)
}

message("Blog copied to ", normalizePath(dest))
