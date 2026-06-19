<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Catalogue Jeux Video</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f0f0;
      margin: 0;
      padding: 20px;
    }
    h1 {
      text-align: center;
      color: #333;
    }
    .grille {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }
    .carte img {
      width: 100%;
      height: 160px;
      object-fit: cover;
      border-radius: 6px;
      margin-bottom: 10px;
    }

    .carte h2 { font-size: 1.1rem; margin: 0 0 5px; }
    .carte p { font-size: 0.85rem; color: #666; margin: 3px 0; }
    .prix { font-size: 1rem; color: #2ecc71; font-weight: bold; }
  </style>
</head>
<body>

  <h1>Catalogue Jeux Video</h1>
  <div class="grille" id="grille"></div>

  <script>
    fetch('api/jeux.php')
      .then(function(reponse) {
        return reponse.json();
      })
      .then(function(jeux) {
        const grille = document.getElementById('grille');
        jeux.forEach(function(jeu) {
          grille.innerHTML += `
            <div class="carte">
              <h2>${jeu.titre}</h2>
              <p><strong>Developpeur :</strong> ${jeu.developpeur}</p>
              <p><strong>Genres :</strong> ${jeu.genres ?? 'Non renseigne'}</p>
              <p><strong>Plateformes :</strong> ${jeu.plateformes ?? 'Non renseigne'}</p>
              <p><strong>Date :</strong> ${jeu.date_sortie ?? 'Inconnue'}</p>
              <p><strong>Note :</strong> ${jeu.note_moyenne ?? '-'} / 10</p>
              <p class="prix">${jeu.prix} EUR</p>
            </div>
          `;
        });
      });
  </script>

</body>
</html>
