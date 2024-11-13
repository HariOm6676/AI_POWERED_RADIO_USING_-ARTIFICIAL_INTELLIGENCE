function handleAlanCommand(command) {

}

function _handleCommand(response) {
    console.log("Inside switch of handle command");

    switch (response.command) {
        case "play":
            _playMusic(_selectedRadio.url);
            break;
        case "play_music":
            var id = response.id;
            _audioplayer.pause();
            var newRadio = radios.find(function (element) {
                return element.id === id;
            });
            var index = radios.indexOf(newRadio);
            if (index !== -1) {
                radios.splice(index, 1);
                radios.unshift(newRadio);
            }
            _playMusic(newRadio.url);
            break;
        case "stop":
            _audioplayer.stop();
            break;
        case "next":
            var index = _selectedRadio.id;
            var newRadio;
            if (index + 1 > radios.length) {
                newRadio = radios.find(function (element) {
                    return element.id === 1;
                });
            } else {
                newRadio = radios.find(function (element) {
                    return element.id === index + 1;
                });
            }
            var newIndex = radios.indexOf(newRadio);
            if (newIndex !== -1) {
                radios.splice(newIndex, 1);
                radios.unshift(newRadio);
            }
            _playMusic(newRadio.url);
            break;
        case "prev":
            var index = _selectedRadio.id;
            var newRadio;
            if (index - 1 <= 0) {
                newRadio = radios.find(function (element) {
                    return element.id === 1;
                });
            } else {
                newRadio = radios.find(function (element) {
                    return element.id === index - 1;
                });
            }
            var newIndex = radios.indexOf(newRadio);
            if (newIndex !== -1) {
                radios.splice(newIndex, 1);
                radios.unshift(newRadio);
            }
            _playMusic(newRadio.url);
            break;
        default:
            console.log("Command was " + response.command);
            break;
    }
}
