class Particle {
    ArrayList<PVector> tail;

    PVector v;
    color c;

    float a, spd = 5;
    int sz = 5, len = 50, ext = 2500;

    boolean dead;
    int birth;

    int gen;

    Particle(PVector v, float a, color c, int g) {
        this.v = v;
        this.a = a;
        this.c = c;

        this.gen = g;

        birth = millis();
        tail = new ArrayList<PVector>();
        dead = false;
    }

    boolean update(ArrayList<Particle> others) {
        if (random(1) < 0.05) {
            if (random(1) < 0.5) {
                a += PI / 4;
            } else {
                a -= PI / 4;
            }
        }

        tail.add(v.copy());
        if (tail.size() > len) {
            tail.remove(0);
        }

        v.x += cos(a) * spd;
        v.y += sin(a) * spd;

        boolean ret = false;
        if (millis() - birth > ext) {
            for (Particle o : others) {
                if (gen != o.gen && millis() - o.birth > o.ext && o.v.dist(v) < sz) {
                    ret = true;
                    dead = true;
                    o.dead = true;
                    break;
                }
            }
        }

        PVector o = tail.get(0);
        if (
            o.x < 0 || o.x > width ||
            o.y < 0 || o.y > height
        ) {
            dead = true;
        }

        return ret;
    }

    void draw() {
        fill(c);
        ellipse(v.x, v.y, sz, sz);

        int size = tail.size();
        if (size > 1) {
            int  i = 0;

            for (PVector t : tail) {
                fill(c, map(i, 0, size - 1, 0, 255));
                ellipse(t.x, t.y, sz, sz);

                i += 1;
            }
        }
    }
}
