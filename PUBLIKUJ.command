#!/bin/bash
# Publikacja metaunit.io — kliknij dwukrotnie, żeby wysłać zmiany na domenę.
cd "$(dirname "$0")"

echo "=============================="
echo "  PUBLIKACJA metaunit.io"
echo "=============================="
echo

echo "Czeka do wysłania:"
git log --oneline origin/HEAD..HEAD 2>/dev/null || git log --oneline -3
echo

read -p "Wysłać na metaunit.io? [t/N] " ODP
if [[ "$ODP" != "t" && "$ODP" != "T" ]]; then
  echo "Anulowane. Nic nie zostało wysłane."
  read -p "Enter zamyka okno..."
  exit 0
fi

echo
# Inne sesje (podstrony boardów: toty-casting, erste-the-bird…) też wysyłają na ten sam repo.
# Najpierw dociągamy ich zmiany, potem wysyłamy nasze.
git pull --rebase origin main || {
  echo
  echo "Nie udało się połączyć ze zmianami z GitHuba — nic nie zostało wysłane."
  read -p "Enter zamyka okno..."
  exit 1
}
echo
git push && {
  echo
  echo "OK — wysłane. Strona odświeży się na metaunit.io w ciągu 1-2 minut."
} || {
  echo
  echo "Push się nie udał — patrz komunikat powyżej."
}

echo
read -p "Enter zamyka okno..."
