# TeXIEDP8

Ce projet est un modèle de document LaTeX utilisable pour les devoirs de
l'IED de l'Université Paris 8.

## Avertissements

Tous les professeurs n'ont pas les mêmes exigences de présentation. Vérifiez
bien la correspondance du rendu avec ce qui est attendu avant d'envoyer le
devoir.

Le document pdf final est `build/main.pdf`. Le document `main.pdf` situé dans le
dossier racine du projet n'est qu'un lien symbolique vers ce fichier.

## Prérequis

Les packages prérequis et leurs options sont listés dans le fichier
`src/requirements.tex`. Le moteur utilisé est xelatex, et biber pour la
bibliographie.

Pour une installation simple des prérequis, sur une distribution GNU/Linux basée
Debian (comme Ubuntu), installez les packages `texlive-full` et `biber`:

```
sudo apt install texlive-full biber
```

## Installation

Pour commencer un devoir, clonez le projet (changez `devoir` dans le nom qui
vous conviendra):

```
git clone https://github.com/amartos/TeXIEDP8 devoir
```

Vous pouvez directement tester la mise en forme en utilisant la commande `make
full`, qui générera le pdf dans le dossier `build` (un lien symbolique vers
`main.pdf` est dans le dossier racine du projet).

## Utilisation

### Les métadonnées

Adaptez le contenu de `metadata.tex` au devoir que vous rédigez:

```latex
\title{Architecture des Ordinateurs} % Matière

\newcommand{\name}{John Doe} % Prénom Nom
\newcommand{\studentid}{123456789} % n° étudiant
\newcommand{\subtitle}{Chapitre 1 - Généralités sur les Ordinateurs} % Titre du devoir

% la commande section donne maintenant: 
% \section{À rendre} => Exercice 1.2 À rendre
% à commenter pour remettre les titres de sections habituels
\titleformat{\section}{\bfseries \large}{Exercice \thesection}{1em}{}

% Définition du style principal des codes sources
% styles définis dans src/codeblocks.tex
\lstdefinestyle{CodeBox}{
    style=tab4, % la largeur de tabulation vaut 4 espaces
    style=linesnb5, % numéro de lignes, toutes les 5 lignes
    style=box, % enferme les codes sources dans des boites colorées
    style=ttstyle, % police type typewriter
    style=syntaxcol, % coloration syntaxique
}
```

### Le contenu

Le contenu de votre devoir doit se trouver dans un ou plusieurs fichiers `.tex`
dans le dossier `document`. Ce dossier est scanné automatiquement lors de la
compilation avec le `Makefile`. Attention, l'ordre d'ajout est basé sur le nom
du fichier; il est recommandé de s'assurer de l'ordre correct en ajoutant un
identifiant au début du nom, exemple: `01_chapitre_1.tex`. N'utilisez pas
d'espaces dans les noms de fichiers, préférez les tirets bas.

Un exemple de contenu est disponible dans le fichier `document/00_template.tex`.

Les images à ajouter via les commandes personnalisées (voir section suivante)
sont à placer dans le dossier `images`, et les codes sources dans `code`. La
bibliographie doit être au format biblatex dans le fichier `biblio.bib`. Un
excellent gestionnaire de bibliographie est [Zotero](https://www.zotero.org/).

Pour activer la page d'annexes, décommentez la première ligne du fichier
`annexes.tex`.

### La compilation

Pour compiler entièrement votre document (incluant TDM et bibliographie),
utilisez `make full`. Une compilation simple est possible avec la commande
`make`.

Si vous ne souhaitez pas utiliser le `Makefile`, modifiez le fichier
`src/content.tex` en incluant les fichiers de votre document (voir le fichier
pour un exemple), et lancez les commandes:

```
mkdir -p build
xelatex -output-directory=build --jobname="main" main.tex
biber build/main
xelatex -output-directory=build --jobname="main" main.tex
xelatex -output-directory=build --jobname="main" main.tex
```

## Documentation des commandes

```latex
% sourcecodeinline - affiche le code source d'un fichier dans le dossier code/
% param 1 : options de listings, ex. caption="titre"
% param 2 : chemin du fichier source
% exemple :
\sourcecodeinline{language=python,caption=script.py}{script.py}

% sourcecode - affiche le code source d'un fichier dans code/ et l'ajoute à la TDM
% param 1 : options supplémentaires de listings
% param 2 : chemin du fichier source
% param 3 : un label pour les réferences
% exemple :
\sourcecode{language=python,caption=source.c}{source.c}{sourcec}

% simplefig - ajoute une figure
% param 1 : légende
% param 2 : la figure
% param 3 : un label pour les réferences
% exemple :
\simplefig{Légende de la figure}{
   \includegraphics[scale=0.5]{path/to/image/image.png}
   }{fig:myimage}

% image - ajoute une image depuis le dossiers "images/" dans le document et la TDM
% note : n'utilise pas l'environnement "figure" car les flottants ne peuvent
%     être placés dans des minipages. Cette commande est celle à utiliser pour les
%     images à placer dans l'environnement graybox.
% param 1 : légende affichée dans la TDM
% param 2 : échelle de l'image
% param 3 : chemin de l'image dans le dossier images/
% param 4 : un label pour les réferences
% exemple :
\image{Légende de l'image}{0.5}{image.png}{fig:myimage}

% screenshot - ajoute une capture d'écran depuis le dossier "images/" dans le
%      document et la table des matières.
% note : Cette commande place la capture en mode paysage pour une meilleure
%     lisibilité.
% avertissement : ne pas utiliser dans des minipages, excluant donc l'environnement graybox.
% param 1 : légende affichée dans le TDM
% param 2 : échelle de l'image (défaut à 0.57)
% param 3 : chemin du fichier dans le dossier images/
% param 4 : un label pour les réferences
% exemples :
\screenshot{Légende de la capture}{}{screenshot.png}{fig:myscreenshot}
\screenshot{Légende de la capture}{0.8}{screenshot.png}{fig:myscreenshot}

% screenshotsm - ajoute jusqu'à deux captures d'écran de téléphone portable côte à côte, 
%     depuis le dossier "images/" dans le document et la table des matières.
% avertissement : ne pas utiliser dans des minipages, excluant donc l'environnement graybox.
% param 1 : légende affichée dans le TDM
% param 2 : échelle de l'image (défaut à 0.2)
% param 3 : chemin du fichier dans le dossier images/
% param 4 : (optionnel) chemin du second fichier dans le dossier images/
% param 5 : un label pour les réferences
% exemples :
\screenshotsm{Légende de la capture}{}{screenshot1.png}{}{fig:myscreenshot}
\screenshotsm{Légende de la capture}{0.8}{screenshot1.png}{screenshot2.png}{fig:myscreenshots}

% starchapter - ajoute un chapitre non numéroté dans le texte et la TDM
% param 1 : le nom du chapitre
% exemple :
\starchapter{Généralités sur les Ordinateurs}

% starchapter - ajoute une section non numérotée dans le texte et la TDM
% param 1 : le nom de la section
% exemple :
\starsection{Titre de la section}

% starchapter - ajoute une sous-section non numérotée dans le texte et la TDM
% param 1 : le nom de la sous-section
% exemple :
\starsubsection{Titre de la section}

% addbookmark - ajoute un bookmark (un hyperlien accessible via le menu
%     bookmark du document pdf
% param 1 : type (toc, titlepage, etc)
% param 2 : niveau (chapter, section, etc)
% param 3 : texte à afficher
% exemple :
\addbookmark{toc}{section}{My section name}

% graybox - environnement ajoutant un fond gris au texte.
% note : utilise minipage
% exemple :
\begin{graybox}
    Texte noir sur fond gris.
\end{graybox}
```

## Licence

Ce projet est sous licence GPL v3. Pour les détails, voir le fichier
[LICENCE.md](LICENCE.md)
