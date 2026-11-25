const app = require('../../app');
const {connectDB, closeDB} = require('../../tests/setup/database');
const Size = require('../../models/size');
const Color = require('../../models/color');
let server;
async function main(){
  await connectDB();
  await Size.insertMany(['XS','S','M','L','XL','XXL'].map(name=>({name})));
  await Color.insertMany(Array.from({length:20},(_,i)=>({name:'Test color '+i,hexCode:'#'+(i*10000).toString(16).padStart(6,'0')})));
  await new Promise((resolve,reject)=>{server=app.listen(3001,'127.0.0.1',resolve);server.once('error',reject);});
  console.log('Performance API ready: http://127.0.0.1:3001 (6 sizes, 20 colors)');
}
async function stop(){try{if(server) await new Promise(resolve=>server.close(resolve));}finally{await closeDB();}}
for(const sig of ['SIGINT','SIGTERM']) process.once(sig,()=>stop().catch(console.error));
main().catch(async e=>{console.error(e);await stop();process.exitCode=1;});
