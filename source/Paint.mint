record Point {
  x : Number,
  y : Number
}

component Paint {
  state mouseDown = false
  state line : Array(Point) = []

  style app {
    display: grid;
    grid-template-rows: auto 1fr;
    height: 100vh;
    width: 100vw;

    font-family: Open Sans;
    font-weight: bold;
  }

  style canvas {
    flex: 1;
    background: lightgray;
    width: 500px;
    height: 500px;
  }

  style path {
    fill: none;
    stroke: black;
  }

  style point {
    position: absolute;
    left: 0;
    top: 0;
    width: 10px;
    height: 10px;
    background: red;
  }

  fun onMouseMove (e : Html.Event) : void {
    if (mouseDown) {
      next
        {
          line =
            Array.push(
              {
                x = e.pageX,
                y = e.pageY
              },
              line)
        }
    } else {
      Promise.never()
    }
  }

  fun onMouseDown (e : Html.Event) {
    next { mouseDown = true }
  }

  fun onMouseUp (e : Html.Event) {
    next { mouseDown = false }
  }

  get linePath : string {
    case (line) {
      [head, ...tail] =>
        Array.reduce("M#{head.x} #{head.y}", (acc : String, point : Point) : string { acc + " L#{point.x} #{point.y}" }, tail)

      => ""
    }
  }

  fun render : Html {
    <div::app>
      <svg::canvas
        width="500"
        height="500"
        onMouseMove={onMouseMove}
        onMouseDown={onMouseDown}
        onMouseUp={onMouseUp}>

        <path::path d={linePath}/>

      </svg>
    </div>
  }
}
