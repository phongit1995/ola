package com.google.firebase.components;

import android.support.annotation.GuardedBy;
import com.google.android.gms.common.internal.Preconditions;
import com.google.firebase.events.Event;
import com.google.firebase.events.EventHandler;
import com.google.firebase.events.Publisher;
import com.google.firebase.events.Subscriber;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes2.dex */
class zzf implements Publisher, Subscriber {

    @GuardedBy("this")
    private final Map<Class<?>, ConcurrentHashMap<EventHandler<Object>, Executor>> zza = new HashMap();

    @GuardedBy("this")
    private Queue<Event<?>> zzb = new ArrayDeque();
    private final Executor zzc;

    zzf(Executor executor) {
        this.zzc = executor;
    }

    private synchronized Set<Map.Entry<EventHandler<Object>, Executor>> zza(Event<?> event) {
        ConcurrentHashMap<EventHandler<Object>, Executor> concurrentHashMap = this.zza.get(event.getType());
        if (concurrentHashMap == null) {
            return Collections.emptySet();
        }
        return concurrentHashMap.entrySet();
    }

    @Override // com.google.firebase.events.Publisher
    public void publish(final Event<?> event) {
        Preconditions.checkNotNull(event);
        synchronized (this) {
            if (this.zzb != null) {
                this.zzb.add(event);
                return;
            }
            for (final Map.Entry<EventHandler<Object>, Executor> entry : zza(event)) {
                entry.getValue().execute(new Runnable(entry, event) { // from class: com.google.firebase.components.zzg
                    private final Map.Entry zza;
                    private final Event zzb;

                    {
                        this.zza = entry;
                        this.zzb = event;
                    }

                    @Override // java.lang.Runnable
                    public final void run() {
                        ((EventHandler) this.zza.getKey()).handle(this.zzb);
                    }
                });
            }
        }
    }

    @Override // com.google.firebase.events.Subscriber
    public <T> void subscribe(Class<T> cls, EventHandler<? super T> eventHandler) {
        subscribe(cls, eventHandler, this.zzc);
    }

    @Override // com.google.firebase.events.Subscriber
    public synchronized <T> void subscribe(Class<T> cls, EventHandler<? super T> eventHandler, Executor executor) {
        Preconditions.checkNotNull(cls);
        Preconditions.checkNotNull(eventHandler);
        Preconditions.checkNotNull(executor);
        if (!this.zza.containsKey(cls)) {
            this.zza.put(cls, new ConcurrentHashMap<>());
        }
        this.zza.get(cls).put(eventHandler, executor);
    }

    @Override // com.google.firebase.events.Subscriber
    public synchronized <T> void unsubscribe(Class<T> cls, EventHandler<? super T> eventHandler) {
        Preconditions.checkNotNull(cls);
        Preconditions.checkNotNull(eventHandler);
        if (this.zza.containsKey(cls)) {
            ConcurrentHashMap<EventHandler<Object>, Executor> concurrentHashMap = this.zza.get(cls);
            concurrentHashMap.remove(eventHandler);
            if (concurrentHashMap.isEmpty()) {
                this.zza.remove(cls);
            }
        }
    }

    final void zza() {
        Queue<Event<?>> queue;
        synchronized (this) {
            if (this.zzb != null) {
                queue = this.zzb;
                this.zzb = null;
            } else {
                queue = null;
            }
        }
        if (queue != null) {
            Iterator<Event<?>> it2 = queue.iterator();
            while (it2.hasNext()) {
                publish(it2.next());
            }
        }
    }
}
