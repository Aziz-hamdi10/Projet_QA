Start from backend root: node quality/postman/start-test-server.js
Run in second terminal: npx newman run quality/postman/collection.json -e quality/postman/environment.json -r cli,json,htmlextra --reporter-json-export quality/reports/api-results.json --reporter-htmlextra-export quality/reports/api-report.html
Stop test server with Ctrl+C. Restart before a fresh campaign. Do not target production.
