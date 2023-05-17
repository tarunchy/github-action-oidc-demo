document.getElementById('text-form').addEventListener('submit', function(event) {
    event.preventDefault();
    var textInput = document.getElementById('text-input').value;
    fetch('http://cs-hack-back-dev.azurewebsites.net/api/process', {  // Replace with your actual backend API URL
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({text: textInput}),
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('result').textContent = data.result;
    });
});
