package chat.ola.vn.n;

import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.telephony.gsm.GsmCellLocation;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.entity.d;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.n.b;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;

/* JADX INFO: loaded from: classes.dex */
class a {
    protected Context a;
    protected b.InterfaceC0042b b;
    protected long c;
    protected boolean d;
    private C0041a e;
    private C0041a f;
    private C0041a g;
    private LocationManager i;
    private Location h = null;
    private Runnable j = null;
    private boolean k = true;
    private long l = 0;

    /* JADX INFO: renamed from: chat.ola.vn.n.a$a, reason: collision with other inner class name */
    class C0041a implements LocationListener {
        C0041a() {
        }

        @Override // android.location.LocationListener
        public void onLocationChanged(Location location) {
            try {
                a.this.i.removeUpdates(this);
            } catch (Throwable unused) {
            }
            if (a.this.h == null || b.a(location, a.this.h)) {
                a.this.h = location;
            }
            try {
                a.this.h = location;
                a.this.a();
                c.a().a(a.this.h);
                if (a.this.b != null) {
                    a.this.b.a(a.this.h.getLongitude(), a.this.h.getLatitude(), a.this.h.getAccuracy());
                    OlaApplication.b.a(a.this.h.getLongitude() + "", a.this.h.getLatitude() + "");
                }
            } catch (Throwable unused2) {
            }
        }

        @Override // android.location.LocationListener
        public void onProviderDisabled(String str) {
        }

        @Override // android.location.LocationListener
        public void onProviderEnabled(String str) {
        }

        @Override // android.location.LocationListener
        public void onStatusChanged(String str, int i, Bundle bundle) {
        }
    }

    public a(Context context) {
        this.a = context;
        this.i = (LocationManager) context.getSystemService("location");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a() {
        try {
            OlaApplication.c(this.j);
        } catch (Throwable unused) {
        }
        try {
            this.i.removeUpdates(this.e);
        } catch (Throwable unused2) {
        }
        try {
            this.i.removeUpdates(this.f);
        } catch (Throwable unused3) {
        }
        try {
            this.i.removeUpdates(this.g);
        } catch (Throwable unused4) {
        }
    }

    private void b() {
        int lac;
        int cid;
        try {
            TelephonyManager telephonyManager = (TelephonyManager) this.a.getSystemService("phone");
            String networkOperator = telephonyManager.getNetworkOperator();
            if (m.a(networkOperator) || telephonyManager.getPhoneType() == 2) {
                return;
            }
            GsmCellLocation gsmCellLocation = (GsmCellLocation) telephonyManager.getCellLocation();
            if (gsmCellLocation != null) {
                cid = gsmCellLocation.getCid();
                lac = gsmCellLocation.getLac();
            } else {
                lac = 0;
                cid = 0;
            }
            int i = Integer.parseInt(networkOperator.substring(0, 3));
            int i2 = Integer.parseInt(networkOperator.substring(3));
            String hexString = Integer.toHexString(cid);
            String hexString2 = Integer.toHexString(lac);
            String hexString3 = Integer.toHexString(i);
            String hexString4 = Integer.toHexString(i2);
            final OlaNetworkService olaNetworkService = OlaApplication.b;
            if (olaNetworkService != null) {
                olaNetworkService.a(hexString, hexString2, hexString3, hexString4, f.a(new e() { // from class: chat.ola.vn.n.a.2
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 31;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i3, short s, String str, d[] dVarArr) {
                        try {
                            olaNetworkService.a((String) null, (String) null);
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        try {
                            String str = (String) objArr[0];
                            String str2 = (String) objArr[1];
                            Location location = new Location("network");
                            location.setLongitude(Double.parseDouble(str));
                            location.setLatitude(Double.parseDouble(str2));
                            location.setAccuracy(3000.0f);
                            if (a.this.h == null || b.a(location, a.this.h)) {
                                a.this.h = location;
                            }
                        } catch (Throwable unused) {
                        }
                    }
                }));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(long j, boolean z) {
        try {
            this.e = new C0041a();
            if (this.h != null && System.currentTimeMillis() - this.l <= 300000) {
                if (this.b != null) {
                    this.b.a(this.h.getLongitude(), this.h.getLatitude(), this.h.getAccuracy());
                }
                this.b = null;
            }
            if (j <= 0) {
                j = 30000;
            }
            this.d = z;
            this.c = j;
            this.k = this.i.isProviderEnabled("gps");
            if (!this.k) {
                try {
                    f.b((short) 31);
                    if (this.b != null) {
                        this.b.l_();
                        return;
                    }
                    return;
                } catch (Throwable unused) {
                    return;
                }
            }
            if (this.b != null) {
                this.b.k_();
            }
            Location lastKnownLocation = this.i.getLastKnownLocation("gps");
            if (lastKnownLocation == null) {
                lastKnownLocation = this.i.getLastKnownLocation("network");
            }
            if (lastKnownLocation != null && b.a(lastKnownLocation, this.h)) {
                this.h = lastKnownLocation;
                this.l = System.currentTimeMillis();
                this.e.onLocationChanged(this.h);
                return;
            }
            this.i.requestLocationUpdates("gps", 60000L, 1.0f, this.e);
            if (this.i.isProviderEnabled("network")) {
                this.f = new C0041a();
                this.i.requestLocationUpdates("network", 60000L, 1.0f, this.f);
            }
            if (this.i.isProviderEnabled("passive")) {
                this.g = new C0041a();
                this.i.requestLocationUpdates("passive", 60000L, 1.0f, this.g);
            }
            if (n.b(this.a)) {
                b();
            }
            if (this.c > 0) {
                this.j = new Runnable() { // from class: chat.ola.vn.n.a.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (a.this.h != null) {
                                c.a().a(a.this.h);
                                a.this.b.a(a.this.h.getLongitude(), a.this.h.getLatitude(), a.this.h.getAccuracy());
                                OlaApplication.b.a(a.this.h.getLongitude() + "", a.this.h.getLatitude() + "");
                            } else if (a.this.k) {
                                a.this.b.j_();
                            } else {
                                a.this.b.l_();
                            }
                        } catch (Throwable th) {
                            a.this.a();
                            throw th;
                        }
                        a.this.a();
                    }
                };
                OlaApplication.a(this.j, this.c);
            }
        } catch (Throwable unused2) {
        }
    }

    public void a(b.InterfaceC0042b interfaceC0042b) {
        this.b = interfaceC0042b;
    }
}
