# Bridgewear — performance k6
Extract at backend root. Requires existing app.js, tests/setup/database.js, mongodb-memory-server and k6 installed. Stop the previous Postman server on port 3001 first. From backend root run:

Terminal 1: `node quality/performance/start-test-server.js`

Terminal 2 (Windows CMD):
```
if not exist quality\reports mkdir quality\reports
npm pkg set "scripts.test:smoke=k6 run quality/performance/smoke-test.js"
npm pkg set "scripts.test:load=k6 run quality/performance/load-test.js"
npm pkg set "scripts.test:stress=k6 run quality/performance/stress-test.js"
npm run test:smoke
npm run test:load
npm run test:stress
```
Keep terminal 1 running. Stop with Ctrl+C after tests. JSON summaries in quality/reports. Only localhost port 3001 is targeted. Both endpoints return nonempty arrays from seeded temporary MongoDB. Each virtual user reads sizes and colors sequentially, then pauses one second. Load: 20 VUs plateau 60s, 120s total; stress: up to 100 VUs, 150s total. Thresholds apply to aggregate requests (including setup checks HTTP traffic). This is a small local read-only benchmark, not production capacity or write-concurrency verification. Record hardware, versions, dataset and actual metrics. No results provided until execution. If smoke fails, troubleshoot before load/stress.
