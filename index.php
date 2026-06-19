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
    form {
        background: white;
        padding: 15px;
        border-radius: 8px;
        max-width: 400px;
        margin: 0 auto 20px;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    form input, form select, form textarea, form button {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-family: Arial, sans-serif;
    }
    form button {
      background: #2ecc71;
      color: white;
      border: none;
      cursor: pointer;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <h1>Catalogue Jeux Video</h1>

  <h2 style="text-align:center">Ajouter un jeu</h2>
  <form id="formulaireJeu">
    <input type="text" id="titre" placeholder="Titre du jeu" required/>
    <input type="number" id="prix" step="0.01" placeholder="Prix en euros" required/>
    <input type="date" id="date_sortie"/>
    <input type="number" id="note_moyenne" step="0.1" min="0" max="10" placeholder="Note sur 10"/>
    <textarea id="description" placeholder="Description du jeu"></textarea>
    <input type="text" id="image_url" placeholder="URL de l'image"/>
  
    <label>Developpeur :</label>
    <select id="id_dev"></select>
    
    <label>Genres :</label>
    <div id="zoneGenres"></div>
    
    <label>Plateformes :</label>
    <div id="zonePlateformes"></div>
  
    <button type="submit">Ajouter le jeu</button>
  </form>
  <div class="grille" id="grille"></div>

  <script>

    // récupération de la liste des developpeurs pour remplir un menu qui se deroule
    fetch('api/devs.php')
    .then(function(reponse) {
      return reponse.json();
    })
      
    .then(function(developpeurs) {
      const select = document.getElementById('id_dev');
      developpeurs.forEach(function(dev) {
        select.innerHTML += `<option value="${dev.id_dev}">${dev.nom}</option>`;
      });
    });

    // récupération de la liste des genres pour creer des cases a cocher
    fetch('api/genres.php')
      .then(function(reponse) {
        return reponse.json();
      })
      .then(function(genres) {
        const zone = document.getElementById('zoneGenres');
        genres.forEach(function(genre) {
          zone.innerHTML += `
            <label>
              <input type="checkbox" name="genre" value="${genre.id_genre}"/>
              ${genre.nom}
            </label>
          `;
        });
      });
    
    // récupération de la liste des plateformes pour creer des cases a cocher
    fetch('api/plateformes.php')
      .then(function(reponse) {
        return reponse.json();
      })
      .then(function(plateformes) {
        const zone = document.getElementById('zonePlateformes');
        plateformes.forEach(function(plateforme) {
          zone.innerHTML += `
            <label>
              <input type="checkbox" name="plateforme" value="${plateforme.id_plateforme}"/>
              ${plateforme.nom}
            </label>
          `;
        });
      });

    
    fetch('api/jeux.php')
      .then(function(reponse) {
        return reponse.json();
      })

      
      .then(function(jeux) {
        const grille = document.getElementById('grille');
        jeux.forEach(function(jeu) {
            grille.innerHTML += `
            <div class="carte">
            <img src="${jeu.image_url}" alt="${jeu.titre}"/>
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


    // On recupere le formulaire
  const formulaire = document.getElementById('formulaireJeu');
  
  // Quand on soumet le formulaire
  formulaire.addEventListener('submit', function(evenement) {
    // On empeche le rechargement de la page
    evenement.preventDefault();
  
    // récupération des valeurs du formulaire
    const nouveauJeu = {
      titre: document.getElementById('titre').value,
      prix: document.getElementById('prix').value,
      date_sortie: document.getElementById('date_sortie').value,
      note_moyenne: document.getElementById('note_moyenne').value,
      description: document.getElementById('description').value,
      image_url: document.getElementById('image_url').value,
      id_dev: document.getElementById('id_dev').value,
      genres: [],
      plateformes: []
    };
    
    // récupération des cases de genr cochees
    document.querySelectorAll('input[name="genre"]:checked').forEach(function(case_) {
      nouveauJeu.genres.push(case_.value);
    });
    
    // récupération des cases de plateforme cochees
    document.querySelectorAll('input[name="plateforme"]:checked').forEach(function(case_) {
      nouveauJeu.plateformes.push(case_.value);
    });
  
    // On envoie le jeu a l'API en POST
    fetch('api/jeux.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(nouveauJeu)
    })
    .then(function(reponse) {
      return reponse.json();
    })
    .then(function(resultat) {
      // On recharge la page pour voir le nouveau jeu
      alert('Jeu ajoute avec succes !');
      location.reload();
    });
  });
  </script>

</body>
</html>
