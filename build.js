var run = require('child_process').execSync

run('docker build -t zvonimir/that-bus-backend backend')
run('docker push zvonimir/that-bus-backend')