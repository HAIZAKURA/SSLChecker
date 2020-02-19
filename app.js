const bodyParser = require("body-parser");
const express = require('express')
const fs = require('fs')
const child_process = require('child_process')
const path = require('path')

const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

// app.get('/', (req, res) => {
//     res.send('Yo!')
// })

app.use(express.static(path.join(__dirname, 'public')))

app.get('/check/:url', (req, res) => {
    let cmd = './runcheck.sh ' + req.params.url
    child_process.exec(cmd, (error, stdout, stderr) => {
        if (error) {
            res.json({
                status:"fail",
                error:error
            })
        }
        let file = 'results/' + req.params.url + '.json'
        res.send(JSON.parse(fs.readFileSync(file)))
    })
})

// Server Start
const port = 4000

app.listen(port, () => {
    console.log(`The App is listening on port ${port}.`)
})
