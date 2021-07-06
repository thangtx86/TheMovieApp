class MovieType<D> {
  Type type;
  D data;

  MovieType(this.type, this.data);
}

enum Type { CATEGORY, DISCOVER, GENRE }
