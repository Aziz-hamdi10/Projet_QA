# Tests unitaires — Express / Mongoose

## Installation
Extraire ce ZIP à la racine du backend existant (fusionner les dossiers). Il contient seulement les ajouts de test et package.json mis à jour; le code métier, package-lock.json et les fichiers de configuration originaux restent inchangés.

```powershell
npm ci
npm run test:unit
npm run test:report
Start-Process coverage/lcov-report/index.html
```

Les tests n'utilisent ni MongoDB réel, ni serveur HTTP démarré. Les méthodes Mongoose et JWT des tests de routes sont simulées; les validations de schémas sont réelles. Les tests de handlers utilisent la structure des routeurs Express 4.

## Traçabilité initiale
| Suite | Vérifications |
|---|---|
| schemas.test.js | Champs obligatoires, types et valeurs par défaut des modèles existants |
| veriftoken.test.js | Token absent, rejeté, accepté par le vérificateur simulé |
| frais.test.js | Création, consultation du dernier frais, absence et erreur |
| subscription.test.js | Statut d'abonnement et erreur |

## Preuves
`quality/reports/unit-results.json`, `coverage/coverage-summary.json`, `coverage/lcov-report/index.html` après exécution. Aucun résultat Jest n'est fourni: l'environnement Linux de préparation ne dispose pas du binaire natif Jest/unrs-resolver approprié (node_modules fourni pour Windows). La syntaxe des fichiers a été vérifiée et 31 validations de schéma ont été contrôlées séparément via Node; ce n'est pas un résultat Jest.

## Limites / points à traiter
Les modèles user et Product n'imposent pas de champs obligatoires dans le schéma actuel; les tests ne prétendent pas démontrer ces contraintes. Les contraintes unique nécessitent MongoDB réel et des index. La vérification JWT comporte une clé codée en dur dans le code source original, à externaliser et remplacer. Les tests ne démontrent pas l'autorisation par rôle ni la conformité ISO complète. Les tests d'intégration, API, performance et sécurité restent à réaliser. Ne pas publier les fichiers de secrets ni les données sensibles.
