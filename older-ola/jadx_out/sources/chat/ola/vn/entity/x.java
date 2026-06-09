package chat.ola.vn.entity;

/* JADX INFO: loaded from: classes.dex */
public class x implements Comparable<x> {
    public byte a;
    public String b;
    public String c;

    @Override // java.lang.Comparable
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compareTo(x xVar) {
        return a().compareToIgnoreCase(xVar.a());
    }

    public String a() {
        return this.c;
    }
}
