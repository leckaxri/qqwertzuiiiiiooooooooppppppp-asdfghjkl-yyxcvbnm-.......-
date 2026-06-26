<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xbox Freestyle Snake</title>
    <style>
        body {
            background-color: #111;
            color: #0f0;
            font-family: 'Courier New', Courier, monospace;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        h1 {
            color: #107c10; /* Xbox Grün */
            margin-bottom: 10px;
        }
        canvas {
            border: 4px solid #107c10;
            background-color: #000;
        }
        .score {
            font-size: 24px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <h1>XBOX FREESTYLE SNAKE</h1>
    <canvas id="gameCanvas" width="400" height="400"></canvas>
    <div class="score">Punkte: <span id="scoreVal">0</span></div>

    <script>
        const canvas = document.getElementById("gameCanvas");
        const ctx = canvas.getContext("2d");

        const gridSize = 20;
        const tileCount = canvas.width / gridSize;

        let snake = [{x: 10, y: 10}];
        let food = {x: 15, y: 15};
        let dx = 1;
        let dy = 0;
        let score = 0;

        function drawGame() {
            // Schlange bewegen
            const head = {x: snake[0].x + dx, y: snake[0].y + dy};
            
            // Wand-Kollision (Teleport auf die andere Seite)
            if (head.x < 0) head.x = tileCount - 1;
            if (head.x >= tileCount) head.x = 0;
            if (head.y < 0) head.y = tileCount - 1;
            if (head.y >= tileCount) head.y = 0;

            // Selbst-Kollision prüfen
            for (let i = 0; i < snake.length; i++) {
                if (snake[i].x === head.x && snake[i].y === head.y) {
                    // Game Over -> Reset
                    snake = [{x: 10, y: 10}];
                    dx = 1; dy = 0;
                    score = 0;
                    document.getElementById("scoreVal").innerText = score;
                    return;
                }
            }

            snake.unshift(head);

            // Essen gefressen?
            if (head.x === food.x && head.y === food.y) {
                score += 10;
                document.getElementById("scoreVal").innerText = score;
                generateFood();
            } else {
                snake.pop();
            }

            // Hintergrund zeichnen
            ctx.fillStyle = "#000";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            // Essen zeichnen (Rot)
            ctx.fillStyle = "#ff0000";
            ctx.fillRect(food.x * gridSize, food.y * gridSize, gridSize - 2, gridSize - 2);

            // Schlange zeichnen (Xbox Grün)
            ctx.fillStyle = "#107c10";
            for (let i = 0; i < snake.length; i++) {
                ctx.fillRect(snake[i].x * gridSize, snake[i].y * gridSize, gridSize - 2, gridSize - 2);
            }
        }

        function generateFood() {
            food.x = Math.floor(Math.random() * tileCount);
            food.y = Math.floor(Math.random() * tileCount);
        }

        // Steuerung über die Tastatur (Pfeiltasten oder WASD)
        window.addEventListener("keydown", e => {
            switch(e.key) {
                case "ArrowUp": case "w": if (dy === 0) { dx = 0; dy = -1; } break;
                case "ArrowDown": case "s": if (dy === 0) { dx = 0; dy = 1; } break;
                case "ArrowLeft": case "a": if (dx === 0) { dx = -1; dy = 0; } break;
                case "ArrowRight": case "d": if (dx === 0) { dx = 1; dy = 0; } break;
            }
        });

        setInterval(drawGame, 100);
    </script>
</body>
</html>
