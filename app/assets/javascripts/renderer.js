const getSkinContext = () => {
	let canvas = document.getElementById('skin-grid');
	return canvas.getContext('2d');
}

const renderGrid = (context, grid) => {
	context.clearRect(0, 0, context.canvas.width, context.canvas.height);

	let unit_height = context.canvas.height / grid.length;
	for (let y = 0; y < grid.length; y++) {
		let unit_width = context.canvas.width / grid[y].length;

		for (let x = 0; x < grid[y].length; x++) {
			let value = grid[y][x];
			renderGridCell(context, x, y, value, unit_height, unit_width);
		}
	}
}

const renderGridCell = (context, x, y, value, unit_width, unit_height) => {
	let x_start = x * unit_width;
	let y_start = y * unit_height

	context.beginPath();
	context.rect(x_start, y_start, unit_width, unit_height);

	context.fillStyle = getFillStyle(value);
	context.fill();
}

const getFillStyle = (value) => {
	return value == 1 ? "black" : "white";
}
