const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send('Estamos en la ruta por default');
});

module.exports = router;
