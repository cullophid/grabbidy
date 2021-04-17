component Header {
  property painting : Bool

  style title {

  }

  style header {
    display: grid;
    grid-template-columns: auto auto;
    justify-content: space-between;
    box-shadow: 0 1px 3px hsla(0, 0%, 0%, 0.3);
  }

  fun render : Html {
    <header::header>
      <h1::title>"Task Bear"</h1>

      if (painting) {
        "Painting"
      }
    </header>
  }
}
