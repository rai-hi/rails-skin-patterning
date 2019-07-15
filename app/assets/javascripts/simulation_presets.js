
const simulationPresets = {
	default: {
		activator_strength: -0.4,
		inhibitor_strength: -0.2,
		striped_direction: 'none',
		name: 'Default'
	},
	vertical: {
		activator_strength: -0.8,
		inhibitor_strength: -0.8,
		striped_direction: 'vertical',
		name: 'Vertical'
	},
	horizontal: {
		activator_strength: -0.8,
		inhibitor_strength: -0.8,
		striped_direction: 'horizontal',
		name: 'Horizontal'
	},
	sparse: {
		activator_strength: -0.4,
		inhibitor_strength: -0.4,
		striped_direction: 'none',
		name: 'Sparse'
	},
	dense: {
		activator_strength: -0.4,
		inhibitor_strength: -0.1,
		striped_direction: 'none',
		name: 'Dense'
	},
}

const setPreset = (name) => {
	let preset = simulationPresets[name || 'default'];
	let fieldNames = [
		'activator_strength', 'inhibitor_strength', 'striped_direction'
	]
	fieldNames.forEach((fieldName) => {
		document.querySelector(`[name=${fieldName}]`).value = preset[fieldName]
	});
}

document.addEventListener('turbolinks:load', (event) => {
	let presetSelector = document.querySelector('[name=presets]')

	for (var key in simulationPresets) {
		let option = document.createElement('option');
		option.value = key;
		option.text = simulationPresets[key].name;
		presetSelector.add(option);
	}

	presetSelector
		.addEventListener('change', (event) => {
			let presetName = event.target.value;
			setPreset(presetName);
		});
});

