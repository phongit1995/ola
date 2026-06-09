package com.mg.ola.a.a.b;

import android.view.animation.Interpolator;
import com.mg.ola.a.a.b.a;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
public final class c extends com.mg.ola.a.a.b.a {
    private ArrayList<com.mg.ola.a.a.b.a> c = new ArrayList<>();
    private HashMap<com.mg.ola.a.a.b.a, e> d = new HashMap<>();
    private ArrayList<e> e = new ArrayList<>();
    private ArrayList<e> f = new ArrayList<>();
    private boolean g = true;
    private a h = null;
    boolean b = false;
    private boolean i = false;
    private long j = 0;
    private n k = null;
    private long l = -1;

    private class a implements a.InterfaceC0079a {
        private c b;

        a(c cVar) {
            this.b = cVar;
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void a(com.mg.ola.a.a.b.a aVar) {
            aVar.b(this);
            c.this.c.remove(aVar);
            boolean z = true;
            ((e) this.b.d.get(aVar)).f = true;
            if (c.this.b) {
                return;
            }
            ArrayList arrayList = this.b.f;
            int size = arrayList.size();
            int i = 0;
            while (true) {
                if (i >= size) {
                    break;
                }
                if (!((e) arrayList.get(i)).f) {
                    z = false;
                    break;
                }
                i++;
            }
            if (z) {
                if (c.this.a != null) {
                    ArrayList arrayList2 = (ArrayList) c.this.a.clone();
                    int size2 = arrayList2.size();
                    for (int i2 = 0; i2 < size2; i2++) {
                        ((a.InterfaceC0079a) arrayList2.get(i2)).a(this.b);
                    }
                }
                this.b.i = false;
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void b(com.mg.ola.a.a.b.a aVar) {
            if (c.this.b || c.this.c.size() != 0 || c.this.a == null) {
                return;
            }
            int size = c.this.a.size();
            for (int i = 0; i < size; i++) {
                c.this.a.get(i).b(this.b);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void c(com.mg.ola.a.a.b.a aVar) {
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void d(com.mg.ola.a.a.b.a aVar) {
        }
    }

    public class b {
        private e b;

        b(com.mg.ola.a.a.b.a aVar) {
            this.b = (e) c.this.d.get(aVar);
            if (this.b == null) {
                this.b = new e(aVar);
                c.this.d.put(aVar, this.b);
                c.this.e.add(this.b);
            }
        }

        public b a(com.mg.ola.a.a.b.a aVar) {
            e eVar = (e) c.this.d.get(aVar);
            if (eVar == null) {
                eVar = new e(aVar);
                c.this.d.put(aVar, eVar);
                c.this.e.add(eVar);
            }
            eVar.a(new C0080c(this.b, 0));
            return this;
        }
    }

    /* JADX INFO: renamed from: com.mg.ola.a.a.b.c$c, reason: collision with other inner class name */
    private static class C0080c {
        public e a;
        public int b;

        public C0080c(e eVar, int i) {
            this.a = eVar;
            this.b = i;
        }
    }

    private static class d implements a.InterfaceC0079a {
        private c a;
        private e b;
        private int c;

        public d(c cVar, e eVar, int i) {
            this.a = cVar;
            this.b = eVar;
            this.c = i;
        }

        private void e(com.mg.ola.a.a.b.a aVar) {
            if (this.a.b) {
                return;
            }
            C0080c c0080c = null;
            int size = this.b.c.size();
            int i = 0;
            while (true) {
                if (i >= size) {
                    break;
                }
                C0080c c0080c2 = this.b.c.get(i);
                if (c0080c2.b == this.c && c0080c2.a.a == aVar) {
                    aVar.b(this);
                    c0080c = c0080c2;
                    break;
                }
                i++;
            }
            this.b.c.remove(c0080c);
            if (this.b.c.size() == 0) {
                this.b.a.a();
                this.a.c.add(this.b.a);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void a(com.mg.ola.a.a.b.a aVar) {
            if (this.c == 1) {
                e(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void b(com.mg.ola.a.a.b.a aVar) {
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void c(com.mg.ola.a.a.b.a aVar) {
            if (this.c == 0) {
                e(aVar);
            }
        }

        @Override // com.mg.ola.a.a.b.a.InterfaceC0079a
        public void d(com.mg.ola.a.a.b.a aVar) {
        }
    }

    private static class e implements Cloneable {
        public com.mg.ola.a.a.b.a a;
        public ArrayList<C0080c> b = null;
        public ArrayList<C0080c> c = null;
        public ArrayList<e> d = null;
        public ArrayList<e> e = null;
        public boolean f = false;

        public e(com.mg.ola.a.a.b.a aVar) {
            this.a = aVar;
        }

        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public e clone() {
            try {
                e eVar = (e) super.clone();
                eVar.a = this.a.clone();
                return eVar;
            } catch (CloneNotSupportedException unused) {
                throw new AssertionError();
            }
        }

        public void a(C0080c c0080c) {
            if (this.b == null) {
                this.b = new ArrayList<>();
                this.d = new ArrayList<>();
            }
            this.b.add(c0080c);
            if (!this.d.contains(c0080c.a)) {
                this.d.add(c0080c.a);
            }
            e eVar = c0080c.a;
            if (eVar.e == null) {
                eVar.e = new ArrayList<>();
            }
            eVar.e.add(this);
        }
    }

    private void i() {
        if (!this.g) {
            int size = this.e.size();
            for (int i = 0; i < size; i++) {
                e eVar = this.e.get(i);
                if (eVar.b != null && eVar.b.size() > 0) {
                    int size2 = eVar.b.size();
                    for (int i2 = 0; i2 < size2; i2++) {
                        C0080c c0080c = eVar.b.get(i2);
                        if (eVar.d == null) {
                            eVar.d = new ArrayList<>();
                        }
                        if (!eVar.d.contains(c0080c.a)) {
                            eVar.d.add(c0080c.a);
                        }
                    }
                }
                eVar.f = false;
            }
            return;
        }
        this.f.clear();
        ArrayList arrayList = new ArrayList();
        int size3 = this.e.size();
        for (int i3 = 0; i3 < size3; i3++) {
            e eVar2 = this.e.get(i3);
            if (eVar2.b == null || eVar2.b.size() == 0) {
                arrayList.add(eVar2);
            }
        }
        ArrayList arrayList2 = new ArrayList();
        while (arrayList.size() > 0) {
            int size4 = arrayList.size();
            for (int i4 = 0; i4 < size4; i4++) {
                e eVar3 = (e) arrayList.get(i4);
                this.f.add(eVar3);
                if (eVar3.e != null) {
                    int size5 = eVar3.e.size();
                    for (int i5 = 0; i5 < size5; i5++) {
                        e eVar4 = eVar3.e.get(i5);
                        eVar4.d.remove(eVar3);
                        if (eVar4.d.size() == 0) {
                            arrayList2.add(eVar4);
                        }
                    }
                }
            }
            arrayList.clear();
            arrayList.addAll(arrayList2);
            arrayList2.clear();
        }
        this.g = false;
        if (this.f.size() != this.e.size()) {
            throw new IllegalStateException("Circular dependencies cannot exist in AnimatorSet");
        }
    }

    public b a(com.mg.ola.a.a.b.a aVar) {
        if (aVar == null) {
            return null;
        }
        this.g = true;
        return new b(aVar);
    }

    @Override // com.mg.ola.a.a.b.a
    public void a() {
        this.b = false;
        this.i = true;
        i();
        int size = this.f.size();
        for (int i = 0; i < size; i++) {
            e eVar = this.f.get(i);
            ArrayList<a.InterfaceC0079a> arrayListF = eVar.a.f();
            if (arrayListF != null && arrayListF.size() > 0) {
                for (a.InterfaceC0079a interfaceC0079a : new ArrayList(arrayListF)) {
                    if ((interfaceC0079a instanceof d) || (interfaceC0079a instanceof a)) {
                        eVar.a.b(interfaceC0079a);
                    }
                }
            }
        }
        final ArrayList<e> arrayList = new ArrayList();
        for (int i2 = 0; i2 < size; i2++) {
            e eVar2 = this.f.get(i2);
            if (this.h == null) {
                this.h = new a(this);
            }
            if (eVar2.b == null || eVar2.b.size() == 0) {
                arrayList.add(eVar2);
            } else {
                int size2 = eVar2.b.size();
                for (int i3 = 0; i3 < size2; i3++) {
                    C0080c c0080c = eVar2.b.get(i3);
                    c0080c.a.a.a(new d(this, eVar2, c0080c.b));
                }
                eVar2.c = (ArrayList) eVar2.b.clone();
            }
            eVar2.a.a(this.h);
        }
        if (this.j <= 0) {
            for (e eVar3 : arrayList) {
                eVar3.a.a();
                this.c.add(eVar3.a);
            }
        } else {
            this.k = n.b(0.0f, 1.0f);
            this.k.a(this.j);
            this.k.a(new com.mg.ola.a.a.b.b() { // from class: com.mg.ola.a.a.b.c.1
                boolean a = false;

                @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                public void a(com.mg.ola.a.a.b.a aVar) {
                    if (this.a) {
                        return;
                    }
                    int size3 = arrayList.size();
                    for (int i4 = 0; i4 < size3; i4++) {
                        e eVar4 = (e) arrayList.get(i4);
                        eVar4.a.a();
                        c.this.c.add(eVar4.a);
                    }
                }

                @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                public void b(com.mg.ola.a.a.b.a aVar) {
                    this.a = true;
                }
            });
            this.k.a();
        }
        if (this.a != null) {
            ArrayList arrayList2 = (ArrayList) this.a.clone();
            int size3 = arrayList2.size();
            for (int i4 = 0; i4 < size3; i4++) {
                ((a.InterfaceC0079a) arrayList2.get(i4)).c(this);
            }
        }
        if (this.e.size() == 0 && this.j == 0) {
            this.i = false;
            if (this.a != null) {
                ArrayList arrayList3 = (ArrayList) this.a.clone();
                int size4 = arrayList3.size();
                for (int i5 = 0; i5 < size4; i5++) {
                    ((a.InterfaceC0079a) arrayList3.get(i5)).a(this);
                }
            }
        }
    }

    @Override // com.mg.ola.a.a.b.a
    public void a(Interpolator interpolator) {
        Iterator<e> it2 = this.e.iterator();
        while (it2.hasNext()) {
            it2.next().a.a(interpolator);
        }
    }

    @Override // com.mg.ola.a.a.b.a
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public c a(long j) {
        if (j < 0) {
            throw new IllegalArgumentException("duration must be a value of zero or greater");
        }
        Iterator<e> it2 = this.e.iterator();
        while (it2.hasNext()) {
            it2.next().a.a(j);
        }
        this.l = j;
        return this;
    }

    @Override // com.mg.ola.a.a.b.a
    public void b() {
        this.b = true;
        if (e()) {
            ArrayList arrayList = null;
            if (this.a != null) {
                arrayList = (ArrayList) this.a.clone();
                Iterator it2 = arrayList.iterator();
                while (it2.hasNext()) {
                    ((a.InterfaceC0079a) it2.next()).b(this);
                }
            }
            if (this.k != null && this.k.d()) {
                this.k.b();
            } else if (this.f.size() > 0) {
                Iterator<e> it3 = this.f.iterator();
                while (it3.hasNext()) {
                    it3.next().a.b();
                }
            }
            if (arrayList != null) {
                Iterator it4 = arrayList.iterator();
                while (it4.hasNext()) {
                    ((a.InterfaceC0079a) it4.next()).a(this);
                }
            }
            this.i = false;
        }
    }

    @Override // com.mg.ola.a.a.b.a
    public void c() {
        this.b = true;
        if (e()) {
            if (this.f.size() != this.e.size()) {
                i();
                for (e eVar : this.f) {
                    if (this.h == null) {
                        this.h = new a(this);
                    }
                    eVar.a.a(this.h);
                }
            }
            if (this.k != null) {
                this.k.b();
            }
            if (this.f.size() > 0) {
                Iterator<e> it2 = this.f.iterator();
                while (it2.hasNext()) {
                    it2.next().a.c();
                }
            }
            if (this.a != null) {
                Iterator it3 = ((ArrayList) this.a.clone()).iterator();
                while (it3.hasNext()) {
                    ((a.InterfaceC0079a) it3.next()).a(this);
                }
            }
            this.i = false;
        }
    }

    @Override // com.mg.ola.a.a.b.a
    public boolean d() {
        Iterator<e> it2 = this.e.iterator();
        while (it2.hasNext()) {
            if (it2.next().a.d()) {
                return true;
            }
        }
        return false;
    }

    @Override // com.mg.ola.a.a.b.a
    public boolean e() {
        return this.i;
    }

    @Override // com.mg.ola.a.a.b.a
    /* JADX INFO: renamed from: h, reason: merged with bridge method [inline-methods] */
    public c clone() {
        c cVar = (c) super.clone();
        cVar.g = true;
        cVar.b = false;
        cVar.i = false;
        cVar.c = new ArrayList<>();
        cVar.d = new HashMap<>();
        cVar.e = new ArrayList<>();
        cVar.f = new ArrayList<>();
        HashMap map = new HashMap();
        for (e eVar : this.e) {
            e eVarClone = eVar.clone();
            map.put(eVar, eVarClone);
            cVar.e.add(eVarClone);
            cVar.d.put(eVarClone.a, eVarClone);
            ArrayList arrayList = null;
            eVarClone.b = null;
            eVarClone.c = null;
            eVarClone.e = null;
            eVarClone.d = null;
            ArrayList<a.InterfaceC0079a> arrayListF = eVarClone.a.f();
            if (arrayListF != null) {
                for (a.InterfaceC0079a interfaceC0079a : arrayListF) {
                    if (interfaceC0079a instanceof a) {
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(interfaceC0079a);
                    }
                }
                if (arrayList != null) {
                    Iterator it2 = arrayList.iterator();
                    while (it2.hasNext()) {
                        arrayListF.remove((a.InterfaceC0079a) it2.next());
                    }
                }
            }
        }
        for (e eVar2 : this.e) {
            e eVar3 = (e) map.get(eVar2);
            if (eVar2.b != null) {
                for (C0080c c0080c : eVar2.b) {
                    eVar3.a(new C0080c((e) map.get(c0080c.a), c0080c.b));
                }
            }
        }
        return cVar;
    }
}
