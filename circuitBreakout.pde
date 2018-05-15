final int num = 100;

int gen = 0;
ArrayList<Particle> p;

void setup() {
    //size(640, 320);
    fullScreen();
    colorMode(HSB);
    noStroke();

    p = new ArrayList<Particle>();

    breakout(num, null);
}

void draw() {
    background(25);

    for (int i = p.size() - 1; i >= 0; i--) {
        Particle t = p.get(i);

        ArrayList<Particle> o = (ArrayList<Particle>)p.clone();
        o.remove(t);

        if (t.update(o) == true) {
            breakout(int(num / 8), t.v.copy());
        }

        if (t.dead) {
            p.remove(i);
            continue;
        }

        t.draw();
    }

    if (p.size() < num) {
        breakout(num, null);
    }
}

void breakout(int num, PVector pos) {
    if (p.size() < num * num) {
        if (pos == null) {
            pos = new PVector(width / 2, height / 2);
        }

        color c = int(color(random(255), 200, 200));

        int g = gen + 1;

        for (int i = 0; i < num; i++) {
            float a = int(random(8)) * PI / 4;

            p.add(new Particle(pos.copy(), a, c, g));
        }

        gen += 1;
    }
}
