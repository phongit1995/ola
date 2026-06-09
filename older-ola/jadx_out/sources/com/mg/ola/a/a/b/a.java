package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
public abstract class a implements Cloneable {
    ArrayList<InterfaceC0079a> a = null;

    /* JADX INFO: renamed from: com.mg.ola.a.a.b.a$a, reason: collision with other inner class name */
    public interface InterfaceC0079a {
        void a(a aVar);

        void b(a aVar);

        void c(a aVar);

        void d(a aVar);
    }

    public abstract a a(long j);

    public void a() {
    }

    public abstract void a(Interpolator interpolator);

    public void a(InterfaceC0079a interfaceC0079a) {
        if (this.a == null) {
            this.a = new ArrayList<>();
        }
        this.a.add(interfaceC0079a);
    }

    public void b() {
    }

    public void b(InterfaceC0079a interfaceC0079a) {
        if (this.a == null) {
            return;
        }
        this.a.remove(interfaceC0079a);
        if (this.a.size() == 0) {
            this.a = null;
        }
    }

    public void c() {
    }

    public abstract boolean d();

    public boolean e() {
        return d();
    }

    public ArrayList<InterfaceC0079a> f() {
        return this.a;
    }

    @Override // 
    /* JADX INFO: renamed from: g, reason: merged with bridge method [inline-methods] */
    public a clone() {
        try {
            a aVar = (a) super.clone();
            if (this.a != null) {
                ArrayList<InterfaceC0079a> arrayList = this.a;
                aVar.a = new ArrayList<>();
                int size = arrayList.size();
                for (int i = 0; i < size; i++) {
                    aVar.a.add(arrayList.get(i));
                }
            }
            return aVar;
        } catch (CloneNotSupportedException unused) {
            throw new AssertionError();
        }
    }
}
