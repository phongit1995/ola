package chat.ola.vn.entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ad {
    protected List<ad> a;
    protected String b;
    protected String c;
    protected String d;
    protected String[] e;
    protected String f;
    protected String g;
    protected String h;
    protected String i;
    protected String j;
    protected long k;
    protected int n;
    protected int o;
    protected short q;
    protected short r;
    private List<String> u;
    protected long l = 0;
    protected long m = 0;
    protected int p = 0;
    protected int s = 0;
    protected int t = 0;

    public long A() {
        return this.m;
    }

    public List<ad> B() {
        return this.a;
    }

    public void a(short s) {
        this.r = s;
    }

    public void a(String[] strArr) {
        this.e = strArr;
    }

    public void b(int i) {
        this.n = i;
    }

    public void b(short s) {
        this.q = s;
    }

    public void c(int i) {
        this.o = i;
    }

    public void c(long j) {
        this.k = j;
    }

    public void c(String str) {
        this.g = str;
    }

    public String d(int i) {
        if (this.u == null) {
            if (this.f == null) {
                return null;
            }
            this.u = new ArrayList(Arrays.asList(this.f.split(";")));
        }
        if (i < 0 || i >= this.u.size()) {
            return null;
        }
        return this.u.get(i);
    }

    public void d(long j) {
        this.l = j;
    }

    public void d(String str) {
        this.h = str;
    }

    public void d(List<ad> list) {
        this.a = list;
    }

    public void e(int i) {
        this.p = i;
    }

    public void e(long j) {
        this.m = j;
    }

    public void e(String str) {
        this.d = str;
    }

    public void f(int i) {
        this.s = i;
    }

    public void f(String str) {
        this.c = str;
    }

    public void g(int i) {
        this.t = i;
    }

    public void g(String str) {
        this.f = str;
    }

    public String h() {
        return this.h;
    }

    public void h(String str) {
        this.i = str;
    }

    public void i(String str) {
        this.j = str;
    }

    public void j(String str) {
        this.b = str;
    }

    public short m() {
        return this.r;
    }

    public String n() {
        return this.g;
    }

    public String o() {
        return this.d;
    }

    public String p() {
        return this.c;
    }

    public String[] q() {
        return this.e;
    }

    public long r() {
        return this.k;
    }

    public int s() {
        return this.n;
    }

    public int t() {
        return this.o;
    }

    public String u() {
        return this.f;
    }

    public short v() {
        return this.q;
    }

    public String w() {
        return this.i;
    }

    public String x() {
        return this.j;
    }

    public long y() {
        return this.l;
    }

    public int z() {
        return this.p;
    }
}
