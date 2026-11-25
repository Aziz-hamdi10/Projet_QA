const app = require('./app');
const mongoose = require('mongoose');
const port = process.env.PORT || 3000;
mongoose.connect(process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/BridgeWear')
  .then(() => app.listen(port, () => console.log(`Server is running on http://localhost:${port}`)))
  .catch(error => { console.error(error); process.exitCode = 1; });
