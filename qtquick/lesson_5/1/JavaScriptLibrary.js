function paintFigure(typeFig, ctx) {
    var stepX = width/10;
    var stepY = height/10;
    switch(typeFig){
        case 0: // отрисовка звезды
            ctx.moveTo(0, 4 * stepY);
            ctx.lineTo(3 * stepX, -4 * stepY);
            ctx.lineTo(-4 * stepX, 1 * stepY);
            ctx.lineTo(4 * stepX, 1 * stepY);
            ctx.lineTo(-3 * stepX, -4 * stepY);
            break;
        case 1: // отрисовка кольца
            ctx.arc(0, 0, 4 * stepX, 0, 360)
            ctx.closePath();
            ctx.stroke();
            ctx.beginPath();
            ctx.arc(0, 0, 4 * stepX - 20, 0, 360)
            break;
        case 2: // отрисовка домика
            ctx.moveTo(-4 * stepX, 1 * stepY);
            ctx.lineTo(0 * stepX, 4 * stepY);
            ctx.lineTo(4 * stepX, 1 * stepY);
            ctx.lineTo(-4 * stepX, 1 * stepY);
            ctx.moveTo(-3 * stepX, 1 * stepY);
            ctx.lineTo(-3 * stepX, -4 * stepY);
            ctx.lineTo(3 * stepX, -4 * stepY);
            ctx.lineTo(3 * stepX, 1 * stepY);
            ctx.closePath();
            ctx.stroke();
            ctx.beginPath();
            ctx.moveTo(-1 * stepX, 0 * stepY);
            ctx.lineTo(-1 * stepX, -2 * stepY);
            ctx.lineTo(1 * stepX, -2 * stepY);
            ctx.lineTo(1 * stepX, 0 * stepY);
            break;
        case 3: // отрисовка песочных часов
            ctx.moveTo(0, 0);
            ctx.bezierCurveTo(2 * stepX, 0 * stepY, 3 * stepX, 2.5 * stepY, 3 * stepX, 4 * stepY);
            ctx.lineTo(-3 * stepX, 4 * stepY);
            ctx.bezierCurveTo(-3 * stepX, 2.5 * stepY, -2 * stepX, 0 * stepY, 0, 0);
            ctx.bezierCurveTo(2 * stepX, 0 * stepY, 3 * stepX, -2.5 * stepY, 3 * stepX, -4 * stepY);
            ctx.lineTo(-3 * stepX, -4 * stepY);
            ctx.bezierCurveTo(-3 * stepX, -2.5 * stepY, -3 * stepX, 0 * stepY, 0, 0);
            break;
        default: // по дефолту рисуется звезда, но сюда мы не попадем.
            ctx.moveTo(0, 4 * stepY);
            ctx.lineTo(3 * stepX, -4 * stepY);
            ctx.lineTo(-4 * stepX, 1 * stepY);
            ctx.lineTo(4 * stepX, 1 * stepY);
            ctx.lineTo(-3 * stepX, -4 * stepY);
    }
}
