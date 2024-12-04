const express = require ('express')
const app = express()

app.get ('/', (req, res) => res.send('Hello World! Test for update'))
app.listen (3000, () => console.log('Server Ready'))