const app = require('../../app');
const { connectDB, closeDB } = require('../../tests/setup/database');
let server;
async function shutdown() {
  try { if (server) await new Promise(resolve => server.close(resolve)); }
  finally { await closeDB(); }
}
async function main() {
  await connectDB();
  await new Promise((resolve, reject) => {
    server = app.listen(3001, '127.0.0.1', resolve);
    server.once('error', reject);
  });
  console.log('Isolated API ready: http://127.0.0.1:3001');
}
for (const signal of ['SIGINT','SIGTERM']) process.once(signal, () => shutdown().catch(console.error));
main().catch(async error => { console.error(error); await shutdown(); process.exitCode = 1; });
