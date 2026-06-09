package chat.ola.vn.util.d;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

/* JADX INFO: loaded from: classes.dex */
public class a implements SensorEventListener {
    private SensorManager a;
    private long e;
    private InterfaceC0053a f;
    private Context g;
    private long i;
    private long j;
    private float b = -1.0f;
    private float c = -1.0f;
    private float d = -1.0f;
    private int h = 0;

    /* JADX INFO: renamed from: chat.ola.vn.util.d.a$a, reason: collision with other inner class name */
    public interface InterfaceC0053a {
        void a();
    }

    public a(Context context) {
        this.g = context;
        a();
    }

    public void a() {
        try {
            this.a = (SensorManager) this.g.getSystemService("sensor");
            if (this.a == null || this.a.registerListener(this, this.a.getDefaultSensor(1), 3)) {
                return;
            }
            this.a.unregisterListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(InterfaceC0053a interfaceC0053a) {
        this.f = interfaceC0053a;
    }

    public void b() {
        try {
            if (this.a != null) {
                this.a.unregisterListener(this);
                this.a = null;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.hardware.SensorEventListener
    public void onAccuracyChanged(Sensor sensor, int i) {
    }

    @Override // android.hardware.SensorEventListener
    public void onSensorChanged(SensorEvent sensorEvent) {
        try {
            if (sensorEvent.sensor.getType() != 1) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.e;
            float fAbs = Math.abs(sensorEvent.values[0] - this.b) + Math.abs(sensorEvent.values[1] - this.c) + Math.abs(sensorEvent.values[2] - this.d);
            if (jCurrentTimeMillis - this.j > 500) {
                this.h = 0;
            }
            if (jCurrentTimeMillis - this.e > 100) {
                if ((fAbs / j) * 10000.0f > 1200.0f) {
                    int i = this.h + 1;
                    this.h = i;
                    if (i >= 5 && jCurrentTimeMillis - this.i > 1000) {
                        this.i = jCurrentTimeMillis;
                        this.h = 0;
                        if (this.f != null) {
                            this.f.a();
                        }
                    }
                    this.j = jCurrentTimeMillis;
                }
                this.e = jCurrentTimeMillis;
                this.b = sensorEvent.values[0];
                this.c = sensorEvent.values[1];
                this.d = sensorEvent.values[2];
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
