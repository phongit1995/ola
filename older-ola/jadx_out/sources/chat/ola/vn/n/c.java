package chat.ola.vn.n;

import android.location.Location;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.e;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.network.a.a.l;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c implements l.a {
    private static c c;
    private OlaVenueEntity a = null;
    private List<OlaVenueEntity> b = null;
    private long d = 0;
    private Location e;

    public static c a() {
        if (c == null) {
            c = new c();
        }
        return c;
    }

    @Override // chat.ola.vn.network.a.a.l.a
    public void a(int i, String str) {
    }

    public void a(Location location) {
        this.e = location;
        try {
            if (this.e != null) {
                this.d = System.currentTimeMillis();
                if (location.getAccuracy() <= 50.0f) {
                    OlaApplication.b.a(this);
                }
            }
        } catch (Throwable unused) {
        }
    }

    public void a(OlaVenueEntity olaVenueEntity) {
        this.a = olaVenueEntity;
    }

    public void a(String str) {
        if (str == null) {
            return;
        }
        try {
            if (this.b == null) {
                this.b = new ArrayList(20);
            }
            if (this.a != null && m.a(str, this.a.b())) {
                this.a = null;
            }
            for (OlaVenueEntity olaVenueEntity : this.b) {
                if (m.a(str, olaVenueEntity.b())) {
                    olaVenueEntity.b(System.currentTimeMillis());
                    return;
                }
            }
            OlaVenueEntity olaVenueEntity2 = new OlaVenueEntity();
            olaVenueEntity2.a(str);
            olaVenueEntity2.b(System.currentTimeMillis());
            this.b.add(olaVenueEntity2);
            e.a().d(this.b);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.network.a.a.l.a
    public void a(List<OlaVenueEntity> list) {
        try {
            OlaVenueEntity olaVenueEntity = list.get(0);
            if (olaVenueEntity != null) {
                this.a = olaVenueEntity;
                if (m.a(this.a.f()) || m.a(this.a.c())) {
                    this.a = null;
                }
            }
            if (b(this.a)) {
                this.a = null;
            }
        } catch (Throwable unused) {
        }
    }

    public String[] a(long j) {
        try {
            if (b() != null && c() != null && System.currentTimeMillis() - this.d <= j) {
                return new String[]{b(), c()};
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public String b() {
        try {
            return this.e.getLongitude() + "";
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean b(OlaVenueEntity olaVenueEntity) {
        try {
            if (this.b == null) {
                this.b = e.a().y();
            }
            for (OlaVenueEntity olaVenueEntity2 : this.b) {
                if (m.a(olaVenueEntity.b(), olaVenueEntity2.b()) && System.currentTimeMillis() - olaVenueEntity2.k() <= 28800000) {
                    return true;
                }
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public String c() {
        try {
            return this.e.getLatitude() + "";
        } catch (Throwable unused) {
            return null;
        }
    }

    public String[] d() {
        return a(900000L);
    }

    public Location e() {
        return this.e;
    }

    public OlaVenueEntity f() {
        return this.a;
    }
}
