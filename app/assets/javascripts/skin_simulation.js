async function getFrames() {
	response = await fetch('<%= skin_simulation_path %>')
	return response.json();
}

const playFrames = () => {
	for (let i = 0; i < window.simulation_frames.length; i++) {
		let frame = window.simulation_frames[i];
		(function (i) {
			setTimeout(function () {
				renderGrid(getSkinContext(), frame)
			}, 1000 * i);
		})(i);
	}
}

async function runSimulation() {
	let form = document.querySelector('form');
	Rails.fire(form, 'submit');
}
