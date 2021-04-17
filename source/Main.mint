record Vector {
  x : Number,
  y : Number
}

record Particle {
  position : Vector,
  velocity : Vector,
  color : String
}

component Main {
  state particles : Array(Particle) = []
  state isMouseDown = false

  state mousePos : Vector =
    {
      x = 0,
      y = 0
    }

  fun createParticle (position : Vector) : Particle {
    {
      position = position,
      velocity =
        {
          x = 0,
          y = 0
        },
      color =
        "hsl(#{Math.random() * 255
        |> Math.round}, 50%, 60%)"
    }
  }

  fun onClick (event : Html.Event) {
    next
      {
        particles =
          Array.push(
            createParticle(
              {
                x = event.pageX,
                y = event.pageY
              }),
            particles)
      }
  }

  fun particleTick (particle : Particle) : Particle {
    { particle |
      velocity =
        {
          x = particle.velocity.x + Math.clamp(-10, 10, (mousePos.x - particle.position.x) / 1000),
          y = particle.velocity.y + Math.clamp(-10, 10, (mousePos.y - particle.position.y) / 1000)
        },
      position =
        {
          x = particle.position.x + particle.velocity.x,
          y = particle.position.y + particle.velocity.y
        }
    }
  }

  fun mouseMove (event : Html.Event) {
    next
      {
        mousePos =
          {
            x = event.pageX,
            y = event.pageY
          }
      }
  }

  use Provider.AnimationFrame {
    frames =
      () {
        next
          {
            particles =
              Array.map(
                particleTick,
                particles)
          }
      }
  }

  style canvas {
    height: 100%;
    background: black;
  }

  style particle (particle : Particle) {
    width: 20px;
    height: 20px;
    border-radius: 20px;
    position: absolute;
    transform: translate(#{particle.position.x}px, #{particle.position.y}px);
    background: #{particle.color};
    left: 0;
    top: 0;
  }

  style mousedown {
    if (isMouseDown) {
      display: block;
    } else {
      display: none;
    }
  }

  fun render : Html {
    <div::canvas
      onClick={onClick}
      onMouseMove={mouseMove}>

      <div::mousedown>"Mouse down"</div>

      for (particle of particles) {
        <div::particle(particle)/>
      }

    </div>
  }
}
